// supabase/functions/video-room/index.ts
// Supabase Edge Function: Secure Server-Side Video/Audio Room & Meeting Token Generation (Daily.co)
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
    const { session_id, conversation_id, mode } = await req.json();
    const callMode = mode === "audio" ? "audio" : "video";

    if (!session_id && !conversation_id) {
      return new Response(JSON.stringify({ error: "Missing session_id or conversation_id" }), {
        status: 400,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // 3. Locate Target Session (using confirmed schema columns: user_id, expert_id, payment_id, status)
    let sessionQuery = supabaseClient
      .from("consultation_sessions")
      .select("*, expert:expert_id(id, full_name), client:user_id(id, full_name)");

    if (session_id) {
      sessionQuery = sessionQuery.eq("id", session_id);
    } else {
      sessionQuery = sessionQuery.eq("conversation_id", conversation_id).eq("status", "active").order("created_at", { ascending: false }).limit(1);
    }

    const { data: session, error: sessionErr } = await sessionQuery.maybeSingle();

    if (sessionErr || !session) {
      return new Response(JSON.stringify({ error: "Active consultation session not found" }), {
        status: 404,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // Participant Authorization: caller must be user_id (client) or expert_id
    const isParticipant = user.id === session.user_id || user.id === session.expert_id;
    if (!isParticipant) {
      return new Response(JSON.stringify({ error: "Forbidden: You are not an authorized participant in this consultation" }), {
        status: 403,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    if (session.status !== "active") {
      return new Response(JSON.stringify({ error: `Cannot join call: consultation session is ${session.status}` }), {
        status: 400,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // 4. Validate Paid Status via linked payment record in public.payments
    if (!session.payment_id) {
      return new Response(JSON.stringify({ error: "Payment verification required: No payment attached to this consultation session" }), {
        status: 402,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    const { data: paymentRecord, error: paymentErr } = await supabaseClient
      .from("payments")
      .select("id, status")
      .eq("id", session.payment_id)
      .maybeSingle();

    if (paymentErr || !paymentRecord || paymentRecord.status !== "successful") {
      return new Response(
        JSON.stringify({
          error: `Payment unverified: Consultation payment status is '${paymentRecord?.status || "unpaid"}' (required: 'successful')`,
          code: "PAYMENT_NOT_SUCCESSFUL"
        }),
        {
          status: 402,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        }
      );
    }

    // 5. Daily.co API Secret Configuration Check
    const dailyApiKey = Deno.env.get("DAILY_API_KEY");
    if (!dailyApiKey) {
      return new Response(
        JSON.stringify({
          success: false,
          error: "DAILY_API_KEY secret is not configured in Supabase Edge Function secrets. Video and audio calling requires a Daily.co API key.",
          code: "PROVIDER_UNCONFIGURED",
          provider: "daily",
        }),
        {
          status: 422,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        }
      );
    }

    // 6. Create or Retrieve Daily.co Private Room
    const roomCleanId = session.id.replace(/[^a-zA-Z0-9]/g, "").slice(0, 16);
    const roomName = `ae_${roomCleanId}`;
    const expTime = Math.floor(Date.now() / 1000) + 3600; // 1-hour expiry

    const createRoomRes = await fetch("https://api.daily.co/v1/rooms", {
      method: "POST",
      headers: {
        "Authorization": `Bearer ${dailyApiKey}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        name: roomName,
        privacy: "private",
        properties: {
          exp: expTime,
          enable_chat: false,
          enable_screenshare: callMode === "video",
          start_video_off: callMode === "audio",
        },
      }),
    });

    let roomUrl = "";
    if (createRoomRes.ok) {
      const roomData = await createRoomRes.json();
      roomUrl = roomData.url;
    } else {
      const errJson = await createRoomRes.json();
      if (errJson?.error === "invalid-request-error" && errJson?.info?.includes("already exists")) {
        // Room already created, fetch its URL
        const getRoomRes = await fetch(`https://api.daily.co/v1/rooms/${roomName}`, {
          headers: { "Authorization": `Bearer ${dailyApiKey}` },
        });
        if (getRoomRes.ok) {
          const existingRoom = await getRoomRes.json();
          roomUrl = existingRoom.url;
        }
      }
      if (!roomUrl) {
        console.error("Daily room creation error:", errJson);
        throw new Error(errJson?.info || "Failed to create Daily video room");
      }
    }

    // 7. Generate Single-Use Participant Meeting Token
    const isOwner = user.id === session.expert_id;
    const callerName = isOwner ? session.expert?.full_name : session.client?.full_name;

    const tokenRes = await fetch("https://api.daily.co/v1/meeting-tokens", {
      method: "POST",
      headers: {
        "Authorization": `Bearer ${dailyApiKey}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        properties: {
          room_name: roomName,
          is_owner: isOwner,
          user_name: callerName || (isOwner ? "Expert" : "Client"),
          user_id: user.id,
          exp: expTime,
          enable_screenshare: callMode === "video",
        },
      }),
    });

    const tokenData = await tokenRes.json();
    if (!tokenRes.ok || !tokenData.token) {
      console.error("Daily meeting token error:", tokenData);
      throw new Error(tokenData?.info || "Failed to generate meeting token");
    }

    return new Response(
      JSON.stringify({
        success: true,
        provider: "daily",
        room_url: roomUrl,
        token: tokenData.token,
        room_name: roomName,
        mode: callMode,
        exp: expTime,
      }),
      {
        status: 200,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      }
    );
  } catch (err: any) {
    console.error("Video room error:", err);
    return new Response(JSON.stringify({ error: err.message || "Internal server error" }), {
      status: 500,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }
});
