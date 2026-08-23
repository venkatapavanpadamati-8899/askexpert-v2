// supabase/functions/session-dispute/index.ts
// Supabase Edge Function: Server-Side Consultation Dispute Filing & Earnings Freeze
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

    // 2. Parse dispute payload
    const { session_id, conversation_id, reason, description } = await req.json();

    if (!reason || !description) {
      return new Response(JSON.stringify({ error: "Missing dispute reason or description" }), {
        status: 400,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // 3. Locate Session
    let query = supabaseClient.from("consultation_sessions").select("*");
    if (session_id) {
      query = query.eq("id", session_id);
    } else if (conversation_id) {
      query = query.eq("conversation_id", conversation_id).order("created_at", { ascending: false }).limit(1);
    }

    const { data: session } = await query.maybeSingle();

    // 4. Freeze Session Status to 'disputed'
    if (session) {
      await supabaseClient
        .from("consultation_sessions")
        .update({ status: "disputed" })
        .eq("id", session.id);
    }

    // 5. File Dispute in public.reports Table for Admin Investigation
    const { data: reportRecord, error: reportError } = await supabaseClient
      .from("reports")
      .insert({
        reporter_id: user.id,
        reported_user_id: session?.expert_id || null,
        report_type: "Consultation Session Dispute",
        reason: reason,
        description: description,
        conversation_id: session?.conversation_id || conversation_id || null,
        payment_id: session?.payment_id || null,
        priority: "high",
        status: "open",
      })
      .select()
      .single();

    if (reportError) {
      console.error("Dispute insert error:", reportError);
    }

    // 6. Log Session Dispute Event
    if (session) {
      await supabaseClient.from("session_events").insert({
        session_id: session.id,
        event_type: "session_disputed",
        triggered_by: user.id,
        metadata: {
          reason: reason,
          report_id: reportRecord?.id,
        },
      });
    }

    return new Response(
      JSON.stringify({
        success: true,
        message: "Dispute case filed and session placed under review",
        report_id: reportRecord?.id,
        case_ref: `REP-${Math.floor(1000 + Math.random() * 9000)}`,
      }),
      {
        status: 200,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      }
    );
  } catch (err: any) {
    console.error("Dispute error:", err);
    return new Response(JSON.stringify({ error: err.message || "Internal server error" }), {
      status: 500,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }
});
