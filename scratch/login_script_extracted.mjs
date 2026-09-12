
    import { supabase } from "./assets/js/common/supabaseClient.js";

    /* ========================================================
       ELEMENTS
       ======================================================== */
    const loginForm = document.getElementById("loginForm");
    const emailInput = document.getElementById("email");
    const passwordInput = document.getElementById("password");
    const togglePassword = document.getElementById("togglePassword");
    const loginButton = document.getElementById("loginButton");
    const googleLoginButton = document.getElementById("googleLoginButton");
    const registerButton = document.getElementById("registerButton");
    const statusMessage = document.getElementById("statusMessage");

    /* ========================================================
       STATUS MESSAGE
       ======================================================== */
    function showStatus(message, type = "error") {
      if (!statusMessage) return;
      statusMessage.textContent = message;
      statusMessage.className = "status-message show " + type;
    }

    function clearStatus() {
      if (!statusMessage) return;
      statusMessage.textContent = "";
      statusMessage.className = "status-message";
    }

    /* ========================================================
       PASSWORD SHOW / HIDE
       ======================================================== */
    if (togglePassword && passwordInput) {
      togglePassword.addEventListener("click", function () {
        if (passwordInput.type === "password") {
          passwordInput.type = "text";
          togglePassword.textContent = "🙈";
          togglePassword.setAttribute("aria-label", "Hide password");
        } else {
          passwordInput.type = "password";
          togglePassword.textContent = "👁";
          togglePassword.setAttribute("aria-label", "Show password");
        }
      });
    }

    /* ========================================================
       REGISTER BUTTON
       ======================================================== */
    if (registerButton) {
      registerButton.addEventListener("click", function () {
        window.location.href = "register.html";
      });
    }

    /* ========================================================
       VALIDATION
       ======================================================== */
    function validateEmailOrUsername(value) {
      if (!value) {
        return { valid: false, message: "Please enter your email or username." };
      }
      if (value.length < 3) {
        return { valid: false, message: "Email or username must contain at least 3 characters." };
      }
      return { valid: true, message: "" };
    }

    function validatePassword(value) {
      if (!value) {
        return { valid: false, message: "Please enter your password." };
      }
      if (value.length < 6) {
        return { valid: false, message: "Password must contain at least 6 characters." };
      }
      return { valid: true, message: "" };
    }

    /* ========================================================
       REAL SUPABASE LOGIN FLOW (NO PAGE REFRESH)
       ======================================================== */
    async function executeLogin() {
      clearStatus();

      const emailOrUsername = emailInput.value.trim();
      const password = passwordInput.value;

      const userValidation = validateEmailOrUsername(emailOrUsername);
      if (!userValidation.valid) {
        showStatus(userValidation.message, "error");
        emailInput.focus();
        return;
      }

      const passwordValidation = validatePassword(password);
      if (!passwordValidation.valid) {
        showStatus(passwordValidation.message, "error");
        passwordInput.focus();
        return;
      }

      loginButton.disabled = true;
      loginButton.innerHTML = '<span class="spinner"></span>Logging in...';

      try {
        const rawInput = (emailOrUsername || "").trim();
        let targetEmail = rawInput.toLowerCase();
        let targetPassword = password;

        if (!targetEmail.includes("@")) {
          // Resolve custom username to email from profiles table
          if (!supabase) {
            throw new Error("Authentication service unavailable. Please check connection.");
          }
          const { data: profile } = await supabase
            .from("profiles")
            .select("email, role")
            .ilike("username", targetEmail)
            .maybeSingle();

          if (profile && profile.email) {
            targetEmail = profile.email.toLowerCase();
          } else {
            throw new Error("No account found with this username. Please check your username or sign in with your email.");
          }
        }

        if (!supabase) {
          throw new Error("Supabase client is not available. Please check connection.");
        }

        // Perform Real Supabase Auth Login
        const { data, error } = await supabase.auth.signInWithPassword({
          email: targetEmail,
          password: targetPassword
        });

        if (error) {
          console.error("[Supabase Auth Error]", error);

          if (error.message && error.message.includes("Invalid login credentials")) {
            throw new Error("Invalid email or password. Please check your credentials.");
          } else if (error.message && error.message.includes("Email not confirmed")) {
            throw new Error("Your email address is not yet confirmed. Please check your inbox.");
          }
          throw error;
        }

        if (!data || !data.user) {
          throw new Error("Authentication failed. No authenticated user returned.");
        }

        // Retrieve Authoritative Profile Record from Supabase database
        const { data: userProfile, error: profileError } = await supabase
          .from("profiles")
          .select("id, role, is_verified, account_status, is_blocked")
          .eq("id", data.user.id)
          .maybeSingle();

        if (profileError) {
          console.error("[Profile Load Error]", profileError);
        }

        // Account status check (suspended or blocked accounts receive no protected access)
        if (
          userProfile?.account_status === "suspended" ||
          userProfile?.account_status === "blocked" ||
          userProfile?.is_blocked === true
        ) {
          await supabase.auth.signOut();
          sessionStorage.clear();
          localStorage.removeItem("askexpert_user_id");
          localStorage.removeItem("askexpert_user_role");
          throw new Error("Your account has been suspended or restricted. Please contact support.");
        }

        // Resolve trusted role strictly from database profile
        const trustedRole = userProfile?.role || "user";

        // Store session cache for UI continuity (never for privileged authorization)
        sessionStorage.setItem("askexpert_user_id", data.user.id);
        sessionStorage.setItem("askexpert_user_role", trustedRole);
        localStorage.setItem("askexpert_user_id", data.user.id);
        localStorage.setItem("askexpert_user_role", trustedRole);

        showStatus("Login successful! Redirecting...", "success");

        const urlParams = new URLSearchParams(window.location.search);
        const redirectUrl = urlParams.get("redirect");

        setTimeout(function () {
          // Prevent open redirect vulnerabilities: only allow relative paths
          if (redirectUrl && !redirectUrl.startsWith("http") && !redirectUrl.startsWith("//") && !redirectUrl.startsWith("\\")) {
            window.location.replace(redirectUrl);
          } else if (trustedRole === "admin") {
            window.location.replace("admin-dashboard.html");
          } else if (trustedRole === "expert" || trustedRole === "professional") {
            if (userProfile && userProfile.is_verified !== true) {
              window.location.replace("professional-verification.html");
            } else {
              window.location.replace("professional-dashboard.html");
            }
          } else {
            window.location.replace("user-dashboard.html");
          }
        }, 400);
        return;

      } catch (error) {
        console.error("AskExpert Login Error:", error);
        const message = error && error.message
          ? error.message
          : "Unable to sign in. Please check your details and try again.";
        showStatus(message, "error");
        loginButton.disabled = false;
        loginButton.textContent = "Login";
      }
    }

    loginButton.addEventListener("click", function (e) {
      e.preventDefault();
      executeLogin();
    });

    loginForm.addEventListener("submit", function (e) {
      e.preventDefault();
      executeLogin();
    });

    /* ========================================================
       GOOGLE OAUTH SIGN IN
       ======================================================== */
    if (googleLoginButton) {
      googleLoginButton.addEventListener("click", async function (e) {
        e.preventDefault();
        try {
          clearStatus();
          googleLoginButton.disabled = true;
          googleLoginButton.innerHTML = '<span class="spinner" style="border-top-color:#1f2937;border-color:rgba(0,0,0,0.15)"></span>Connecting to Google...';

          const redirectTo = `${window.location.origin}/auth-callback.html`;
          const { data, error } = await supabase.auth.signInWithOAuth({
            provider: "google",
            options: {
              redirectTo: redirectTo,
              queryParams: {
                access_type: "offline",
                prompt: "consent",
              }
            }
          });

          if (error) throw error;
        } catch (err) {
          console.error("Google Auth Error:", err);
          showStatus(err.message || "Failed to initiate Google Sign In. Please try again.", "error");
          googleLoginButton.disabled = false;
          googleLoginButton.innerHTML = `
            <svg viewBox="0 0 24 24">
              <path fill="#4285F4" d="M23.745 12.27c0-.7-.06-1.4-.19-2.07H12v4.51h6.6c-.29 1.52-1.14 2.82-2.4 3.68v3.05h3.88c2.27-2.09 3.665-5.17 3.665-9.17z"/>
              <path fill="#34A853" d="M12 24c3.24 0 5.95-1.08 7.93-2.91l-3.88-3.05c-1.08.72-2.45 1.16-4.05 1.16-3.12 0-5.77-2.1-6.72-4.93H1.25v3.15C3.26 21.36 7.33 24 12 24z"/>
              <path fill="#FBBC05" d="M5.28 14.27c-.25-.72-.38-1.49-.38-2.27s.13-1.55.38-2.27V6.58H1.25C.45 8.18 0 9.98 0 12s.45 3.82 1.25 5.42l4.03-3.15z"/>
              <path fill="#EA4335" d="M12 4.75c1.77 0 3.35.61 4.6 1.8l3.42-3.42C17.95 1.19 15.24 0 12 0 7.33 0 3.26 2.64 1.25 6.58l4.03 3.15c.95-2.83 3.6-4.98 6.72-4.98z"/>
            </svg>
            Continue with Google
          `;
        }
      });
    }

    /* ========================================================
       CLEAR STATUS WHEN USER TYPES
       ======================================================== */
    emailInput.addEventListener("input", function () {
      if (statusMessage.classList.contains("show")) {
        clearStatus();
      }
    });

    passwordInput.addEventListener("input", function () {
      if (statusMessage.classList.contains("show")) {
        clearStatus();
      }
    });

    emailInput.addEventListener("keydown", function (event) {
      if (event.key === "Enter") {
        event.preventDefault();
        passwordInput.focus();
      }
    });

    passwordInput.addEventListener("keydown", function (event) {
      if (event.key === "Enter") {
        event.preventDefault();
        executeLogin();
      }
    });

    /* ========================================================
       EXISTING SESSION CHECK (AUTO-REDIRECT AFTER DATABASE VALIDATION)
       ======================================================== */
    async function checkExistingSession() {
      if (!supabase) return;
      try {
        const { data: { session }, error } = await supabase.auth.getSession();
        if (error || !session?.user) {
          return; // No active session, keep login form fully visible
        }

        // Validate account status & authoritative role from database
        const { data: profile } = await supabase
          .from("profiles")
          .select("id, role, full_name, is_verified, account_status, is_blocked")
          .eq("id", session.user.id)
          .maybeSingle();

        if (profile?.account_status === "suspended" || profile?.account_status === "blocked" || profile?.is_blocked === true) {
          await supabase.auth.signOut();
          sessionStorage.clear();
          localStorage.removeItem("askexpert_user_id");
          localStorage.removeItem("askexpert_user_role");
          return;
        }

        // Keep the sign-in page available when a visitor explicitly opens it.
        // Redirect an existing session only when a protected page supplied a safe
        // return path (for example, chat.html redirects unauthenticated visitors here).
        const requestedPath = new URLSearchParams(window.location.search).get("redirect");
        const safeRequestedPath = requestedPath &&
          !requestedPath.startsWith("http") &&
          !requestedPath.startsWith("//") &&
          !requestedPath.startsWith("\\")
          ? requestedPath
          : null;
        if (safeRequestedPath) {
          window.location.replace(safeRequestedPath);
        }
      } catch (err) {
        console.error("Existing session validation error:", err);
      }
    }

    checkExistingSession();
  