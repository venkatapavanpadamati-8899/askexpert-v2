// supabase/functions/payment-create/index.ts
// Supabase Edge Function: Server-Side Payment Order Creation & Registration
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

    // 1. Authenticate user from Authorization Header
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

    // 2. Parse request payload
    const { expert_id, conversation_id, payment_method = "UPI", consultation_type = "standard" } = await req.json();

    if (!expert_id) {
      return new Response(JSON.stringify({ error: "Missing expert_id" }), {
        status: 400,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // 3. Authoritative Expert Consultation Rate Lookup from Database
    const { data: expertProfile, error: expertError } = await supabaseClient
      .from("profiles")
      .select("id, full_name, consultation_fee, role, is_verified")
      .eq("id", expert_id)
      .eq("role", "expert")
      .eq("is_verified", true)
      .maybeSingle();

    if (expertError || !expertProfile) {
      return new Response(JSON.stringify({ error: "Specified expert profile is unverified or invalid" }), {
        status: 400,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    const baseFee = expertProfile.consultation_fee ? parseFloat(String(expertProfile.consultation_fee)) : 1000.00;
    const platformFee = 99.00; // Fixed encryption & SLA assurance fee
    const gstRate = 0.18;
    const gstAmount = Math.round((baseFee + platformFee) * gstRate * 100) / 100;
    const totalAmount = Math.round((baseFee + platformFee + gstAmount) * 100) / 100;

    // 4. Create a real Razorpay order. No client-created transaction can credit a consultation.
    const razorpayKeyId = Deno.env.get("RAZORPAY_KEY_ID");
    const razorpayKeySecret = Deno.env.get("RAZORPAY_KEY_SECRET");
    if (!razorpayKeyId || !razorpayKeySecret) {
      return new Response(JSON.stringify({ error: "Payment gateway is not configured" }), {
        status: 503, headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }
    const receipt = `askexpert_${crypto.randomUUID()}`;
    const gatewayResponse = await fetch("https://api.razorpay.com/v1/orders", {
      method: "POST",
      headers: {
        "Authorization": `Basic ${btoa(`${razorpayKeyId}:${razorpayKeySecret}`)}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ amount: Math.round(totalAmount * 100), currency: "INR", receipt, notes: { user_id: user.id, expert_id } }),
    });
    if (!gatewayResponse.ok) {
      console.error("Razorpay order creation failed:", await gatewayResponse.text());
      return new Response(JSON.stringify({ error: "Could not initialize payment gateway" }), {
        status: 502, headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }
    const gatewayOrder = await gatewayResponse.json();
    const orderId = gatewayOrder.id as string;

    // 5. Insert Pending Transaction into public.payments Table
    const { data: paymentRecord, error: paymentError } = await supabaseClient
      .from("payments")
      .insert({
        user_id: user.id,
        expert_id: expert_id,
        conversation_id: conversation_id || null,
        amount: totalAmount,
        currency: "INR",
        payment_method: payment_method,
        provider: "razorpay",
        provider_payment_id: orderId,
        status: "pending",
        description: `Encrypted consultation booking with ${expertProfile?.full_name || "Specialist"}`,
      })
      .select()
      .single();

    if (paymentError) {
      console.error("Payment insert error:", paymentError);
      return new Response(JSON.stringify({ error: "Failed to initialize payment record" }), {
        status: 500,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // 6. Return Secure Order Details to Client
    return new Response(
      JSON.stringify({
        success: true,
        order_id: orderId,
        payment_id: paymentRecord.id,
        razorpay_key_id: razorpayKeyId,
        amount: totalAmount,
        currency: "INR",
        breakdown: {
          base_fee: baseFee,
          platform_fee: platformFee,
          gst: gstAmount,
          total: totalAmount,
        },
        expert: {
          id: expert_id,
          name: expertProfile?.full_name || "Specialist",
        },
      }),
      {
        status: 200,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      }
    );
  } catch (err: any) {
    console.error("Error creating payment order:", err);
    return new Response(JSON.stringify({ error: err.message || "Internal server error" }), {
      status: 500,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }
});
