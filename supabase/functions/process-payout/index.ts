// supabase/functions/process-payout/index.ts
// Supabase Edge Function: Real Payout Processing & RazorpayX Disbursal
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

    // 1. Authenticate caller
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

    // 2. Authorize admin role
    const { data: callerProfile, error: profileErr } = await supabaseClient
      .from("profiles")
      .select("role")
      .eq("id", user.id)
      .single();

    if (profileErr || callerProfile?.role !== "admin") {
      return new Response(JSON.stringify({ error: "Forbidden: Only system administrators can process payouts" }), {
        status: 403,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // 3. Parse and validate payload
    const { payout_id, action, notes } = await req.json();

    if (!payout_id || !action || !["approve", "reject"].includes(action)) {
      return new Response(JSON.stringify({ error: "Invalid parameters: payout_id and action ('approve' | 'reject') required" }), {
        status: 400,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // 4. Fetch target payout request
    const { data: payout, error: fetchErr } = await supabaseClient
      .from("payout_requests")
      .select("*, expert:expert_id(id, full_name, email, phone, wallet_balance)")
      .eq("id", payout_id)
      .single();

    if (fetchErr || !payout) {
      return new Response(JSON.stringify({ error: "Payout request not found" }), {
        status: 404,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // Prevent double-processing
    if (payout.status === "paid") {
      return new Response(JSON.stringify({ error: "Payout request has already been disbursed and marked paid" }), {
        status: 400,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    if (payout.status === "rejected") {
      return new Response(JSON.stringify({ error: "Payout request has already been rejected and refunded" }), {
        status: 400,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    const now = new Date().toISOString();

    // 5. Handle REJECTION (Calls atomic admin_reject_payout RPC)
    if (action === "reject") {
      const rejectReason = notes || "Payout request rejected by administrator.";

      const { data: rpcResult, error: rpcErr } = await supabaseClient.rpc("admin_reject_payout", {
        p_payout_id: payout.id,
        p_admin_id: user.id,
        p_reason: rejectReason,
      });

      if (rpcErr || !rpcResult?.success) {
        console.error("Payout rejection RPC error:", rpcErr || rpcResult);
        return new Response(JSON.stringify({
          error: rpcResult?.message || rpcErr?.message || "Failed to reject payout"
        }), {
          status: 500,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        });
      }

      return new Response(
        JSON.stringify({
          success: true,
          status: "rejected",
          message: "Payout rejected and reserved funds restored to expert wallet balance",
          payout_id: payout.id,
          restored_amount: rpcResult.restored_amount,
          new_wallet_balance: rpcResult.new_wallet_balance,
        }),
        {
          status: 200,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        }
      );
    }

    // 6. Handle APPROVAL & DISBURSAL (RazorpayX)
    const keyId = Deno.env.get("RAZORPAY_KEY_ID");
    const keySecret = Deno.env.get("RAZORPAY_KEY_SECRET");
    const accountNumber = Deno.env.get("RAZORPAY_ACCOUNT_NUMBER");

    // Strictly enforce real payment provider credentials
    if (!keyId || !keySecret || !accountNumber) {
      const missingConfigMsg = "RazorpayX payout provider account is unconfigured. Required: RAZORPAY_KEY_ID, RAZORPAY_KEY_SECRET, RAZORPAY_ACCOUNT_NUMBER in Supabase secrets.";

      await supabaseClient
        .from("payout_requests")
        .update({
          status: "processing",
          notes: missingConfigMsg,
          failure_reason: "Provider credentials unconfigured",
        })
        .eq("id", payout.id);

      return new Response(
        JSON.stringify({
          success: false,
          status: "processing",
          error: missingConfigMsg,
          message: "Payout status retained as 'processing'. Real disbursement blocked until RazorpayX credentials are configured.",
          payout_id: payout.id,
        }),
        {
          status: 422,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        }
      );
    }

    // 7. Invoke RazorpayX Payouts API
    const authCredentials = btoa(`${keyId}:${keySecret}`);
    const amountInPaise = Math.round(Number(payout.amount) * 100);

    const razorpayRes = await fetch("https://api.razorpay.com/v1/payouts", {
      method: "POST",
      headers: {
        "Authorization": `Basic ${authCredentials}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        account_number: accountNumber,
        amount: amountInPaise,
        currency: "INR",
        mode: "IMPS",
        purpose: "payout",
        reference_id: payout.id,
        narration: `AskExpert Payout #${payout.id.slice(0, 8)}`,
        notes: {
          expert_id: payout.expert_id,
          payout_request_id: payout.id,
        },
      }),
    });

    const razorpayData = await razorpayRes.json();

    if (!razorpayRes.ok) {
      console.error("RazorpayX Payout error:", razorpayData);
      const errMsg = razorpayData.error?.description || "RazorpayX payout API rejected the transaction";

      await supabaseClient
        .from("payout_requests")
        .update({
          status: "processing",
          failure_reason: errMsg,
          notes: `Disbursement failed at provider: ${errMsg}`,
        })
        .eq("id", payout.id);

      return new Response(
        JSON.stringify({
          success: false,
          status: "processing",
          error: errMsg,
          provider_error: razorpayData.error,
          payout_id: payout.id,
        }),
        {
          status: 502,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        }
      );
    }

    // 8. On successful or accepted provider payout:
    // Balance was already deducted upon request creation via request_payout RPC.
    // Do NOT deduct balance again. Only mark status as paid and record provider UTR.
    const providerPayoutId = razorpayData.id;
    const utr = razorpayData.utr || null;
    const providerStatus = razorpayData.status; // 'processed' | 'processing' | 'queued'

    const finalStatus = providerStatus === "processed" ? "paid" : "processing";

    await supabaseClient
      .from("payout_requests")
      .update({
        status: finalStatus,
        provider_payout_id: providerPayoutId,
        utr: utr,
        processed_at: now,
        notes: `Disbursed via RazorpayX (Status: ${providerStatus}). UTR: ${utr || 'Pending bank confirmation'}`,
      })
      .eq("id", payout.id);

    // Notify expert
    await supabaseClient.from("notifications").insert({
      user_id: payout.expert_id,
      type: "payout_disbursed",
      title: "💰 Payout Disbursed",
      message: `Your withdrawal of ₹${payout.amount} has been initiated via bank transfer (UTR: ${utr || providerPayoutId}).`,
      related_id: payout.id,
      is_read: false,
      created_at: now,
    });

    return new Response(
      JSON.stringify({
        success: true,
        status: finalStatus,
        message: `Payout successfully submitted to RazorpayX (Status: ${providerStatus})`,
        payout_id: payout.id,
        provider_payout_id: providerPayoutId,
        utr: utr,
      }),
      {
        status: 200,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      }
    );
  } catch (err: any) {
    console.error("Process payout fatal error:", err);
    return new Response(JSON.stringify({ error: err.message || "Internal server error" }), {
      status: 500,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }
});
