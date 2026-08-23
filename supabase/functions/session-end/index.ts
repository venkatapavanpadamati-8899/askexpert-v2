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

    // 3. Locate Active Session
    let query = supabaseClient.from("consultation_sessions").select("*");
    if (session_id) {
      query = query.eq("id", session_id);
    } else {
      query = query.eq("conversation_id", conversation_id).eq("status", "active").order("created_at", { ascending: false }).limit(1);
    }

    const { data: session, error: fetchError } = await query.maybeSingle();

    if (fetchError || !session) {
      return new Response(JSON.stringify({ error: "Active consultation session not found" }), {
        status: 404,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // 4. Update Session Status to 'completed' & Record End Timestamp
    const now = new Date().toISOString();
    const { error: updateError } = await supabaseClient
      .from("consultation_sessions")
      .update({
        status: "completed",
        ended_at: now,
      })
      .eq("id", session.id);

    if (updateError) {
      console.error("Session update error:", updateError);
    }

    // 5. Update Conversation Status to 'closed'
    if (session.conversation_id) {
      await supabaseClient
        .from("conversations")
        .update({ status: "closed" })
        .eq("id", session.conversation_id);
    }

    // 6. Process Client Rating & Review (if provided)
    if (rating && rating >= 1 && rating <= 5) {
      await supabaseClient.from("reviews").insert({
        session_id: session.id,
        user_id: user.id,
        expert_id: session.expert_id,
        rating: Math.min(5, Math.max(1, parseInt(String(rating), 10))),
        comment: comment || null,
      });

      // Recalculate Expert Rating in public.profiles
      const { data: expertReviews } = await supabaseClient
        .from("reviews")
        .select("rating")
        .eq("expert_id", session.expert_id);

      if (expertReviews && expertReviews.length > 0) {
        const avgRating = expertReviews.reduce((sum, r) => sum + r.rating, 0) / expertReviews.length;
        await supabaseClient
          .from("profiles")
          .update({
            rating: Math.round(avgRating * 100) / 100,
            reviews_count: expertReviews.length,
          })
          .eq("id", session.expert_id);
      }
    }

    // 7. Log Session Completion Event
    await supabaseClient.from("session_events").insert({
      session_id: session.id,
      event_type: "session_completed",
      triggered_by: user.id,
      metadata: {
        ended_at: now,
        expert_net_earnings: session.expert_net_earnings,
        rating: rating || null,
      },
    });

    // 8. Emit Completion Notification to Expert
    await supabaseClient.from("notifications").insert({
      user_id: session.expert_id,
      type: "session_completed",
      title: "✅ Consultation Completed",
      message: `Your consultation has concluded. Net earnings of ₹${session.expert_net_earnings} have been finalized into your balance.`,
      related_id: session.conversation_id,
      is_read: false,
    });

    return new Response(
      JSON.stringify({
        success: true,
        message: "Consultation session successfully finalized and earnings settled",
        session_id: session.id,
        expert_net_earnings: session.expert_net_earnings,
        ended_at: now,
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
