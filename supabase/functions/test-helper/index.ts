import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.39.0";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }
  try {
    const supabaseClient = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? ""
    );

    const body = await req.json();
    const action = body.action;

    if (action === 'seed') {
      const ts = Date.now();
      const userEmail = `test_video_user_${ts}@example.com`;
      const expertEmail = `test_video_expert_${ts}@example.com`;

      const { data: userAuth, error: uErr } = await supabaseClient.auth.admin.createUser({
        email: userEmail,
        password: 'Password123!',
        email_confirm: true
      });
      if (uErr) throw uErr;

      const { data: expertAuth, error: eErr } = await supabaseClient.auth.admin.createUser({
        email: expertEmail,
        password: 'Password123!',
        email_confirm: true
      });
      if (eErr) throw eErr;

      // Wait a moment for trigger
      await new Promise(r => setTimeout(r, 1000));

      const userId = userAuth.user.id;
      const expertId = expertAuth.user.id;

      await supabaseClient.from('profiles').update({ role: 'expert', is_verified: true, fee: 500 }).eq('id', expertId);

      const { data: payment, error: pErr } = await supabaseClient.from('payments').insert({
        amount: 500,
        currency: 'INR',
        status: 'successful',
        expert_id: expertId,
        user_id: userId,
        payment_method: 'card',
        provider: 'razorpay',
        provider_payment_id: 'pay_dummy',
        description: 'Test booking'
      }).select().single();
      if (pErr) throw new Error("Payment Error: " + pErr.message);

      const { data: conv, error: cErr } = await supabaseClient.from('conversations').insert({
        user_id: userId,
        expert_id: expertId,
        status: 'active'
      }).select().single();
      if (cErr) throw new Error("Conv Error: " + cErr.message);

      const { data: session, error: sErr } = await supabaseClient.from('consultation_sessions').insert({
        user_id: userId,
        expert_id: expertId,
        payment_id: payment.id,
        conversation_id: conv.id,
        status: 'active'
      }).select().single();
      if (sErr) throw new Error("Session Error: " + sErr.message);

      return new Response(JSON.stringify({ userId, expertId, paymentId: payment.id, sessionId: session.id, userEmail }), { headers: { ...corsHeaders, "Content-Type": "application/json" } });
    }

    if (action === 'cleanup') {
      const { sessionId, paymentId, userId, expertId } = body;
      await supabaseClient.from('consultation_sessions').delete().eq('id', sessionId);
      await supabaseClient.from('payments').delete().eq('id', paymentId);
      await supabaseClient.auth.admin.deleteUser(userId);
      await supabaseClient.auth.admin.deleteUser(expertId);
      return new Response(JSON.stringify({ success: true }), { headers: { ...corsHeaders, "Content-Type": "application/json" } });
    }

    return new Response(JSON.stringify({ error: 'invalid action' }), { status: 400, headers: corsHeaders });
  } catch (err) {
    return new Response(JSON.stringify({ error: err.message }), { status: 500, headers: corsHeaders });
  }
});
