// supabase/functions/resolve-dispute/index.ts
// Supabase Edge Function: Server-Side Dispute Adjudication, Refund Processing & Notification Dispatch
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

    // 1. Authenticate admin user
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

    // Verify Admin Role in profiles
    const { data: adminProfile } = await supabaseClient
      .from("profiles")
      .select("role")
      .eq("id", user.id)
      .maybeSingle();

    if (adminProfile?.role !== "admin") {
      return new Response(JSON.stringify({ error: "Forbidden: Admin access required" }), {
        status: 403,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // 2. Parse adjudication payload
    const {
      report_id,
      decision, // 'approve_full_refund' | 'approve_partial_refund' | 'reject_refund' | 'dismiss'
      refund_amount,
      resolution_notes,
    } = await req.json();

    if (!report_id || !decision || !resolution_notes) {
      return new Response(JSON.stringify({ error: "Missing required fields (report_id, decision, resolution_notes)" }), {
        status: 400,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // 3. Locate Report Record
    const { data: report, error: repError } = await supabaseClient
      .from("reports")
      .select("*")
      .eq("id", report_id)
      .maybeSingle();

    if (repError || !report) {
      return new Response(JSON.stringify({ error: "Report not found" }), {
        status: 404,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    const now = new Date().toISOString();
    let finalStatus = "resolved";
    let refundProcessed = false;

    // 4. Execute Adjudication Decision
    if (decision === "approve_full_refund" || decision === "approve_partial_refund") {
      refundProcessed = true;

      // Update public.payments status to refunded
      if (report.payment_id) {
        await supabaseClient
          .from("payments")
          .update({
            status: "refunded",
            description: `Refund processed: ${resolution_notes}`,
          })
          .eq("id", report.payment_id);
      }

      // Update consultation session status if applicable
      if (report.conversation_id) {
        await supabaseClient
          .from("consultation_sessions")
          .update({ status: "cancelled" })
          .eq("conversation_id", report.conversation_id);
      }

      // Send refund confirmation notification to Client (Reporter)
      await supabaseClient.from("notifications").insert({
        user_id: report.reporter_id,
        type: "refund_processed",
        title: "↩️ Consultation Refund Approved",
        message: `Your dispute (#${report_id.substring(0, 8)}) was resolved. Refund of ₹${refund_amount || "full amount"} has been credited back to your original payment method.`,
        related_id: report.conversation_id,
        is_read: false,
      });

      // Send dispute outcome notification to Specialist (Reported)
      if (report.reported_user_id) {
        await supabaseClient.from("notifications").insert({
          user_id: report.reported_user_id,
          type: "dispute_resolved",
          title: "⚠️ Dispute Adjudication Notice",
          message: `Consultation dispute (#${report_id.substring(0, 8)}) was resolved with a client refund adjustment. Reason: ${resolution_notes}`,
          related_id: report.conversation_id,
          is_read: false,
        });
      }
    } else if (decision === "reject_refund") {
      // Specialist upheld, client dispute rejected
      await supabaseClient.from("notifications").insert({
        user_id: report.reporter_id,
        type: "dispute_rejected",
        title: "Dispute Investigation Concluded",
        message: `Your dispute (#${report_id.substring(0, 8)}) was reviewed. Specialist counsel was verified and upheld. Notes: ${resolution_notes}`,
        related_id: report.conversation_id,
        is_read: false,
      });
    } else if (decision === "dismiss") {
      finalStatus = "dismissed";
    }

    // 5. Update Report Record
    await supabaseClient
      .from("reports")
      .update({
        status: finalStatus,
        assigned_admin: user.id,
        resolution_notes: `[Decision: ${decision}] ${resolution_notes}`,
        resolved_at: now,
      })
      .eq("id", report.id);

    return new Response(
      JSON.stringify({
        success: true,
        message: `Dispute case ${report_id} successfully adjudicated with decision: ${decision}`,
        report_id: report.id,
        status: finalStatus,
        refund_processed: refundProcessed,
      }),
      {
        status: 200,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      }
    );
  } catch (err: any) {
    console.error("Resolve dispute error:", err);
    return new Response(JSON.stringify({ error: err.message || "Internal server error" }), {
      status: 500,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }
});
