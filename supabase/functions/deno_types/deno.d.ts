// Ambient type definitions for Supabase Edge Functions in VS Code / TypeScript
declare namespace Deno {
  export namespace env {
    export function get(key: string): string | undefined;
    export function set(key: string, value: string): void;
    export function toObject(): Record<string, string>;
  }
}

declare module "https://deno.land/std@0.168.0/http/server.ts" {
  export function serve(
    handler: (req: Request) => Response | Promise<Response>,
    options?: { port?: number; onListen?: (localAddr: { hostname: string; port: number }) => void; signal?: AbortSignal }
  ): void;
}

declare module "https://esm.sh/@supabase/supabase-js@2.39.0" {
  export * from "@supabase/supabase-js";
}
