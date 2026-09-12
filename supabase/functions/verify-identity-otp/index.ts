// supabase/functions/verify-identity-otp/index.ts
// Free-KYC Advisory Notice
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
      mode: "FREE_KYC",
      message: "No OTP verification required. Verification is conducted via Admin signed document review.",
      status: "MANUAL_REVIEW_REQUIRED"
    }),
    {
      status: 200,
      headers: { ...corsHeaders, "Content-Type": "application/json" }
    }
  );
});
