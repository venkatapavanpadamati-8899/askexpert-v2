/**
 * AskExpert - Global Error Tracker & Security Classifier
 * Intercepts JS runtime errors, unhandled promise rejections, API failures, and Supabase errors.
 * Scrubs sensitive credentials (passwords, tokens, keys) and logs classified errors to public.system_errors.
 */

import { supabase } from './supabaseClient.js';

const SENSITIVE_KEYS = [
  'password', 'confirmpassword', 'token', 'bearer', 'access_token', 
  'refresh_token', 'service_role', 'secret', 'apikey', 'card_number', 'cvv'
];

/**
 * Sanitize strings and objects to strip sensitive information before sending to error logs
 */
export function sanitizeData(data) {
  if (!data) return data;
  if (typeof data === 'string') {
    let sanitized = data;
    SENSITIVE_KEYS.forEach(key => {
      const regex = new RegExp(`("${key}"\\s*:\\s*")[^"]+(")`, 'gi');
      sanitized = sanitized.replace(regex, `$1[REDACTED]$2`);
    });
    return sanitized;
  }
  if (typeof data === 'object') {
    try {
      const copy = JSON.parse(JSON.stringify(data));
      const scrub = (obj) => {
        for (let k in obj) {
          if (SENSITIVE_KEYS.some(sk => k.toLowerCase().includes(sk))) {
            obj[k] = '[REDACTED]';
          } else if (typeof obj[k] === 'object' && obj[k] !== null) {
            scrub(obj[k]);
          }
        }
      };
      scrub(copy);
      return copy;
    } catch (e) {
      return '[Unsanitizable Object]';
    }
  }
  return data;
}

/**
 * Generate a deterministic fingerprint hash for grouping duplicate errors
 */
export function computeFingerprint(category, message, location) {
  const cleanMsg = (message || '').replace(/\b0x[0-9a-f]+\b/gi, '').replace(/\d+/g, 'N');
  const str = `${category}:${cleanMsg}:${location || window.location.pathname}`;
  let hash = 0;
  for (let i = 0; i < str.length; i++) {
    const char = str.charCodeAt(i);
    hash = (hash << 5) - hash + char;
    hash |= 0;
  }
  return 'ERR_' + Math.abs(hash).toString(36).toUpperCase();
}

/**
 * Classify error category based on message, stack, and URL context
 */
export function classifyError(message = '', stack = '', url = '') {
  const msgLower = (message + ' ' + stack + ' ' + url).toLowerCase();
  
  if (msgLower.includes('payment') || msgLower.includes('stripe') || msgLower.includes('razorpay') || msgLower.includes('checkout') || msgLower.includes('payout')) {
    return 'PAYMENT';
  }
  if (msgLower.includes('auth') || msgLower.includes('login') || msgLower.includes('signup') || msgLower.includes('jwt') || msgLower.includes('token expired') || msgLower.includes('session')) {
    return 'AUTHENTICATION';
  }
  if (msgLower.includes('rls') || msgLower.includes('row-level security') || msgLower.includes('permission denied') || msgLower.includes('unauthorized') || msgLower.includes('forbidden')) {
    return 'SECURITY';
  }
  if (msgLower.includes('postgres') || msgLower.includes('database') || msgLower.includes('foreign key') || msgLower.includes('unique constraint') || msgLower.includes('duplicate key')) {
    return 'DATABASE';
  }
  if (msgLower.includes('502') || msgLower.includes('503') || msgLower.includes('504') || msgLower.includes('networkerror') || msgLower.includes('failed to fetch')) {
    return 'INFRASTRUCTURE';
  }
  if (url.includes('admin')) {
    return 'ADMIN';
  }
  if (url.includes('expert') || url.includes('professional')) {
    return 'EXPERT';
  }
  if (url.includes('dashboard') || url.includes('profile') || url.includes('question')) {
    return 'USER';
  }
  return 'APPLICATION';
}

/**
 * Determine severity based on category and message
 */
export function computeSeverity(category, message = '') {
  if (category === 'SECURITY' || category === 'PAYMENT') return 'CRITICAL';
  if (category === 'DATABASE' || category === 'AUTHENTICATION') return 'HIGH';
  if (category === 'ADMIN' || category === 'EXPERT') return 'MEDIUM';
  return 'LOW';
}

/**
 * Capture error, format payload, and log to Supabase system_errors table
 */
export async function trackError({
  message,
  stack = '',
  page = window.location.pathname,
  category = null,
  severity = null,
  apiEndpoint = null,
  supabaseCode = null,
  dbCode = null
}) {
  try {
    const cleanMessage = sanitizeData(message || 'Unknown Application Error');
    const cleanStack = sanitizeData(stack);
    const finalCategory = category || classifyError(cleanMessage, cleanStack, page);
    const finalSeverity = severity || computeSeverity(finalCategory, cleanMessage);
    const fingerprint = computeFingerprint(finalCategory, cleanMessage, page);
    const role = localStorage.getItem('askexpert_user_role') || 'unauthenticated';

    let userId = null;
    try {
      const session = (await supabase.auth.getSession())?.data?.session;
      userId = session?.user?.id || null;
    } catch (e) {}

    // Check if error already logged to update count
    const { data: existingErr } = await supabase
      .from('system_errors')
      .select('id, occurrence_count')
      .eq('fingerprint', fingerprint)
      .maybeSingle();

    if (existingErr) {
      await supabase
        .from('system_errors')
        .update({
          occurrence_count: existingErr.occurrence_count + 1,
          last_seen_at: new Date().toISOString(),
          user_role: role,
          user_id: userId || undefined
        })
        .eq('id', existingErr.id);
    } else {
      await supabase
        .from('system_errors')
        .insert({
          fingerprint: fingerprint,
          category: finalCategory,
          severity: finalSeverity,
          error_message: cleanMessage,
          stack_trace: cleanStack,
          affected_page: page,
          user_role: role,
          user_id: userId,
          api_endpoint: apiEndpoint,
          supabase_code: supabaseCode,
          db_code: dbCode,
          occurrence_count: 1,
          status: 'OPEN'
        });
    }

    // Show friendly notification to end user without exposing tech details
    if (!page.includes('admin-dashboard')) {
      showUserErrorToast(finalCategory);
    }

  } catch (err) {
    console.error('ErrorTracker fallback error:', err);
  }
}

/**
 * Display user-friendly notification toast to end user
 */
function showUserErrorToast(category) {
  let toast = document.getElementById('ae-error-toast');
  if (!toast) {
    toast = document.createElement('div');
    toast.id = 'ae-error-toast';
    toast.style.cssText = `
      position: fixed; bottom: 20px; right: 20px; z-index: 99999;
      background: #0f172a; color: #f8fafc; border: 1px solid rgba(239, 68, 68, 0.4);
      padding: 12px 18px; border-radius: 12px; font-family: sans-serif; font-size: 13px;
      box-shadow: 0 10px 25px rgba(0,0,0,0.5); display: flex; align-items: center; gap: 10px;
      animation: fadeIn 0.3s ease;
    `;
    document.body.appendChild(toast);
  }
  
  toast.innerHTML = `
    <span style="font-size:16px;">⚠️</span>
    <div>
      <strong style="display:block; color:#f87171;">Notice</strong>
      <span style="color:#94a3b8;">A temporary issue was logged. Our system administrators have been notified.</span>
    </div>
  `;
  
  setTimeout(() => {
    if (toast) toast.remove();
  }, 4000);
}

/**
 * Initialize global event listeners
 */
export function initGlobalErrorTracker() {
  // Global runtime JavaScript errors
  window.addEventListener('error', (event) => {
    trackError({
      message: event.message || event.error?.message || 'Script Error',
      stack: event.error?.stack || `${event.filename}:${event.lineno}:${event.colno}`,
      page: window.location.pathname
    });
  });

  // Unhandled promise rejections
  window.addEventListener('unhandledrejection', (event) => {
    const reason = event.reason;
    const msg = typeof reason === 'string' ? reason : (reason?.message || 'Unhandled Promise Rejection');
    const stack = reason?.stack || '';
    trackError({
      message: msg,
      stack: stack,
      page: window.location.pathname
    });
  });

  // Intercept failed API requests (fetch wrapper)
  const originalFetch = window.fetch;
  window.fetch = async function (...args) {
    try {
      const response = await originalFetch.apply(this, args);
      if (!response.ok && response.status >= 400) {
        const urlStr = typeof args[0] === 'string' ? args[0] : (args[0]?.url || '');
        if (!urlStr.includes('system_errors')) { // Avoid recursion
          trackError({
            message: `API Request Failed with Status ${response.status} (${response.statusText})`,
            apiEndpoint: urlStr,
            page: window.location.pathname,
            category: response.status === 401 || response.status === 403 ? 'SECURITY' : 'INFRASTRUCTURE'
          });
        }
      }
      return response;
    } catch (err) {
      const urlStr = typeof args[0] === 'string' ? args[0] : (args[0]?.url || '');
      if (!urlStr.includes('system_errors')) {
        trackError({
          message: `Network/Fetch Error: ${err.message}`,
          apiEndpoint: urlStr,
          page: window.location.pathname,
          category: 'INFRASTRUCTURE'
        });
      }
      throw err;
    }
  };
}

// Auto-initialize when imported
if (typeof window !== 'undefined') {
  initGlobalErrorTracker();
}
