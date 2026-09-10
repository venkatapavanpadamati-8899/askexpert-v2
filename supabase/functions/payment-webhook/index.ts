// supabase/functions/payment-webhook/index.ts
// Supabase Edge Function: Asynchronous Payment Gateway Webhook Receiver & Disputer
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.39.0";

serve(async (req: Request) => {
  if (req.method !== "POST") {
    return new Response("Method not allowed", { status: 405 });
  }

  try {
    const supabaseClient = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? ""
    );

    const rawBody = await req.text();
    const webhookSecret = Deno.env.get("RAZORPAY_WEBHOOK_SECRET");
    const suppliedSignature = req.headers.get("x-razorpay-signature") || "";
    if (!webhookSecret || !suppliedSignature) {
      return new Response(JSON.stringify({ error: "Missing webhook signature" }), { status: 401 });
    }
    const key = await crypto.subtle.importKey("raw", new TextEncoder().encode(webhookSecret), { name: "HMAC", hash: "SHA-256" }, false, ["sign"]);
    const signature = await crypto.subtle.sign("HMAC", key, new TextEncoder().encode(rawBody));
    const expectedSignature = Array.from(new Uint8Array(signature)).map((byte) => byte.toString(16).padStart(2, "0")).join("");
    const supplied = new TextEncoder().encode(suppliedSignature);
    const expected = new TextEncoder().encode(expectedSignature);
    let mismatch = supplied.length ^ expected.length;
    for (let index = 0; index < Math.max(supplied.length, expected.length); index++) mismatch |= (supplied[index] || 0) ^ (expected[index] || 0);
    if (mismatch !== 0) return new Response(JSON.stringify({ error: "Invalid webhook signature" }), { status: 401 });
    const body = JSON.parse(rawBody);
    const event = body.event || body.type;
    const payload = body.payload || body.data;

    console.log(`[AskExpert Webhook] Received event: ${event}`);

    switch (event) {
      case "payment.captured":
      case "charge.succeeded": {
        const orderId = payload.payment?.entity?.order_id || payload.order_id;
        const paymentId = payload.payment?.entity?.id || payload.id;

        if (orderId) {
          await supabaseClient
            .from("payments")
            .update({
              status: "successful",
              provider_payment_id: paymentId,
            })
            .eq("provider_payment_id", orderId);
        }
        break;
      }

      case "payment.failed":
      case "charge.failed": {
        const orderId = payload.payment?.entity?.order_id || payload.order_id;
        if (orderId) {
          await supabaseClient
            .from("payments")
            .update({ status: "failed" })
            .eq("provider_payment_id", orderId);
        }
        break;
      }

      case "refund.processed":
      case "refund.created": {
        const paymentId = payload.refund?.entity?.payment_id || payload.payment_id;
        if (paymentId) {
          await supabaseClient
            .from("payments")
            .update({ status: "refunded" })
            .eq("provider_payment_id", paymentId);
        }
        break;
      }

      default:
        console.log(`[AskExpert Webhook] Unhandled event: ${event}`);
    }

    return new Response(JSON.stringify({ status: "processed" }), {
      status: 200,
      headers: { "Content-Type": "application/json" },
    });
  } catch (err: any) {
    console.error("[AskExpert Webhook Error]:", err);
    return new Response(JSON.stringify({ error: err.message }), {
      status: 500,
      headers: { "Content-Type": "application/json" },
    });
  }
});
