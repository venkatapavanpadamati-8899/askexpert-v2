// supabase/functions/session-start/index.ts
// Supabase Edge Function: Server-Side Consultation Session Start & Timer Initialization
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

    // 1. Authenticate user from JWT token
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
    const { conversation_id, expert_id, duration_minutes = 30 } = await req.json();

    if (!conversation_id && !expert_id) {
      return new Response(JSON.stringify({ error: "Missing conversation_id or expert_id" }), {
        status: 400,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // 3. Verify Payment Status from Database (Prevent unpaid access)
    let paymentQuery = supabaseClient
      .from("payments")
      .select("id, amount, status, expert_id")
      .eq("user_id", user.id)
      .eq("status", "successful")
      .order("created_at", { ascending: false })
      .limit(1);

    if (expert_id) {
      paymentQuery = paymentQuery.eq("expert_id", expert_id);
    }

    const { data: paymentRecord, error: payError } = await paymentQuery.maybeSingle();

    if (payError || !paymentRecord) {
      return new Response(
        JSON.stringify({ error: "No verified successful payment found for this consultation" }),
        { status: 403, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    // 4. Calculate Server-Side Duration & Expiration Timestamp
    const now = new Date();
    const durationMins = parseInt(String(duration_minutes), 10) || 30;
    const expiresAt = new Date(now.getTime() + durationMins * 60 * 1000);

    const grossAmount = paymentRecord.amount ? parseFloat(String(paymentRecord.amount)) : 1200.00;
    const platformFee = Math.round(grossAmount * 0.10 * 100) / 100; // 10% platform fee
    const expertNetEarnings = Math.round((grossAmount - platformFee) * 100) / 100;

    // 5. Create or Update Active Session in public.consultation_sessions
    const { data: sessionRecord, error: sessionError } = await supabaseClient
      .from("consultation_sessions")
      .insert({
        conversation_id: conversation_id,
        user_id: user.id,
        expert_id: paymentRecord.expert_id,
        payment_id: paymentRecord.id,
        duration_minutes: durationMins,
        status: "active",
        started_at: now.toISOString(),
        expires_at: expiresAt.toISOString(),
        expert_gross_amount: grossAmount,
        platform_fee: platformFee,
        expert_net_earnings: expertNetEarnings,
      })
      .select()
      .single();

    if (sessionError) {
      console.error("Session creation error:", sessionError);
      return new Response(JSON.stringify({ error: "Failed to initialize consultation session" }), {
        status: 500,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // 6. Log Session Start Event in public.session_events
    await supabaseClient.from("session_events").insert({
      session_id: sessionRecord.id,
      event_type: "session_started",
      triggered_by: user.id,
      metadata: {
        started_at: now.toISOString(),
        duration_minutes: durationMins,
        expires_at: expiresAt.toISOString(),
      },
    });

    // 7. Return Authoritative Timer Metadata
    return new Response(
      JSON.stringify({
        success: true,
        session_id: sessionRecord.id,
        status: "active",
        started_at: now.toISOString(),
        expires_at: expiresAt.toISOString(),
        duration_minutes: durationMins,
        remaining_seconds: durationMins * 60,
      }),
      {
        status: 200,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      }
    );
  } catch (err: any) {
    console.error("Session start error:", err);
    return new Response(JSON.stringify({ error: err.message || "Internal server error" }), {
      status: 500,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }
});
