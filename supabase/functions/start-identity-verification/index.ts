// supabase/functions/start-identity-verification/index.ts
// Free-KYC Advisory Document Pre-check Edge Function
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

serve(async (req: Request) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  return new Response(
    JSON.stringify({
      success: true,
      mode: "FREE_KYC_MANUAL_REVIEW",
      message: "Identity document submitted for Admin review. Free-KYC workflow does not require OTP or paid providers.",
      identity_status: "MANUAL_REVIEW_REQUIRED"
    }),
    {
      status: 200,
      headers: { ...corsHeaders, "Content-Type": "application/json" }
    }
  );
});
