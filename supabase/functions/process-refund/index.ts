// supabase/functions/process-refund/index.ts
// Supabase Edge Function: Server-Side Gateway Refund Execution
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.39.0";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

serve(async (req: Request) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const supabaseClient = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? ""
    );

    // Authenticate admin user
    const authHeader = req.headers.get("Authorization");
    if (!authHeader) {
      return new Response(JSON.stringify({ error: "Missing authorization header" }), {
        status: 401,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    const token = authHeader.replace("Bearer ", "");
    const { data: { user }, error: authError } = await supabaseClient.auth.getUser(token);

    if (authError || !user) {
      return new Response(JSON.stringify({ error: "Unauthorized user session" }), {
        status: 401,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    const { data: admin } = await supabaseClient.rpc("is_admin");
    if (!admin) {
      return new Response(JSON.stringify({ error: "Administrator access required" }), {
        status: 403, headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    const { payment_id, refund_amount, reason } = await req.json();

    if (!payment_id) {
      return new Response(JSON.stringify({ error: "Missing payment_id" }), {
        status: 400,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // Locate Payment
    const { data: payment, error: payError } = await supabaseClient
      .from("payments")
      .select("*")
      .eq("id", payment_id)
      .maybeSingle();

    if (payError || !payment) {
      return new Response(JSON.stringify({ error: "Payment record not found" }), {
        status: 404,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    if (payment.provider !== "razorpay" || !payment.provider_payment_id) {
      return new Response(JSON.stringify({ error: "This payment cannot be refunded through the configured provider" }), {
        status: 400, headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }
    const keyId = Deno.env.get("RAZORPAY_KEY_ID");
    const keySecret = Deno.env.get("RAZORPAY_KEY_SECRET");
    if (!keyId || !keySecret) throw new Error("Payment gateway is not configured");
    const amount = Math.round(Number(refund_amount || payment.amount) * 100);
    if (!Number.isFinite(amount) || amount <= 0 || amount > Math.round(Number(payment.amount) * 100)) {
      return new Response(JSON.stringify({ error: "Invalid refund amount" }), { status: 400, headers: { ...corsHeaders, "Content-Type": "application/json" } });
    }
    const gatewayResponse = await fetch(`https://api.razorpay.com/v1/payments/${payment.provider_payment_id}/refund`, {
      method: "POST",
      headers: { "Authorization": `Basic ${btoa(`${keyId}:${keySecret}`)}`, "Content-Type": "application/json" },
      body: JSON.stringify({ amount, notes: { reason: reason || "Dispute settlement" } }),
    });
    if (!gatewayResponse.ok) throw new Error("Gateway rejected refund");
    const gatewayRefund = await gatewayResponse.json();
    const refundRef = gatewayRefund.id;

    // Transition Payment to Refunded
    await supabaseClient
      .from("payments")
      .update({
        status: "refunded",
        description: `Refunded: ${reason || "Dispute settlement"} (${refundRef})`,
      })
      .eq("id", payment.id);

    return new Response(
      JSON.stringify({
        success: true,
        message: "Payment successfully refunded via gateway",
        refund_reference: refundRef,
        refund_amount: refund_amount || payment.amount,
      }),
      {
        status: 200,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      }
    );
  } catch (err: any) {
    console.error("Process refund error:", err);
    return new Response(JSON.stringify({ error: err.message || "Internal server error" }), {
      status: 500,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }
});
