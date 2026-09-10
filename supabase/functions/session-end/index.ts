// supabase/functions/session-end/index.ts
// Supabase Edge Function: Server-Side Consultation Finalization, Earnings Settlement & Review Processing
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

    // 2. Parse request payload
    const { session_id, conversation_id, rating, comment } = await req.json();

    if (!session_id && !conversation_id) {
      return new Response(JSON.stringify({ error: "Missing session_id or conversation_id" }), {
        status: 400,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // 3. Locate Target Session ID
    let targetSessionId = session_id;
    if (!targetSessionId && conversation_id) {
      const { data: convSession, error: convError } = await supabaseClient
        .from("consultation_sessions")
        .select("id")
        .eq("conversation_id", conversation_id)
        .eq("status", "active")
        .order("created_at", { ascending: false })
        .limit(1)
        .maybeSingle();

      if (convError || !convSession) {
        return new Response(JSON.stringify({ error: "Active consultation session not found for conversation" }), {
          status: 404,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        });
      }
      targetSessionId = convSession.id;
    }

    // 4. Call Atomic Settlement RPC
    // Row-locked (FOR UPDATE), participant-authorized, idempotent, wallet credited once
    const cleanRating = rating && rating >= 1 && rating <= 5 ? Math.round(Number(rating)) : null;
    const cleanComment = comment ? String(comment).slice(0, 1000) : null;

    const { data: rpcResult, error: rpcError } = await supabaseClient.rpc("settle_consultation_session", {
      p_session_id: targetSessionId,
      p_caller_id: user.id,
      p_rating: cleanRating,
      p_comment: cleanComment,
    });

    if (rpcError) {
      console.error("Atomic settlement RPC error:", rpcError);
      return new Response(JSON.stringify({ error: rpcError.message || "Failed to execute atomic settlement" }), {
        status: 500,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    if (!rpcResult || !rpcResult.success) {
      const statusCode = rpcResult?.error === "FORBIDDEN" ? 403 : (rpcResult?.error === "SESSION_NOT_FOUND" ? 404 : 400);
      return new Response(JSON.stringify({
        error: rpcResult?.message || "Settlement failed",
        code: rpcResult?.error || "SETTLEMENT_ERROR"
      }), {
        status: statusCode,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    return new Response(
      JSON.stringify({
        success: true,
        message: rpcResult.already_settled
          ? "Consultation session was already finalized"
          : "Consultation session successfully finalized and wallet credited atomically",
        session_id: targetSessionId,
        expert_net_earnings: rpcResult.expert_net_earnings,
        new_wallet_balance: rpcResult.new_wallet_balance ?? rpcResult.current_wallet_balance,
        ended_at: rpcResult.ended_at || new Date().toISOString(),
        already_settled: Boolean(rpcResult.already_settled),
      }),
      {
        status: 200,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      }
    );
  } catch (err: any) {
    console.error("Session end error:", err);
    return new Response(JSON.stringify({ error: err.message || "Internal server error" }), {
      status: 500,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }
});
