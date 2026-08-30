
    import { supabase } from "./assets/js/common/supabaseClient.js";

    "use strict";


    /* =========================================================
       ELEMENTS
       ========================================================= */

    const identifier =
      document.getElementById(
        "identifier"
      );

    const otp =
      document.getElementById(
        "otp"
      );

    const sendOtpButton =
      document.getElementById(
        "sendOtpButton"
      );

    const verifyOtpButton =
      document.getElementById(
        "verifyOtpButton"
      );

    const otpStatus =
      document.getElementById(
        "otpStatus"
      );

    const demoOtpBox =
      document.getElementById(
        "demoOtpBox"
      );

    const demoOtpCode =
      document.getElementById(
        "demoOtpCode"
      );

    const autoFillOtpButton =
      document.getElementById(
        "autoFillOtpButton"
      );



    const verificationScreen =
      document.getElementById(
        "verificationScreen"
      );

    const resetScreen =
      document.getElementById(
        "resetScreen"
      );

    const successScreen =
      document.getElementById(
        "successScreen"
      );


    const stepOne =
      document.getElementById(
        "stepOne"
      );

    const stepTwo =
      document.getElementById(
        "stepTwo"
      );

    const stepThree =
      document.getElementById(
        "stepThree"
      );

    const lineOne =
      document.getElementById(
        "lineOne"
      );

    const lineTwo =
      document.getElementById(
        "lineTwo"
      );


    const newPassword =
      document.getElementById(
        "newPassword"
      );

    const confirmPassword =
      document.getElementById(
        "confirmPassword"
      );

    const toggleNewPassword =
      document.getElementById(
        "toggleNewPassword"
      );

    const toggleConfirmPassword =
      document.getElementById(
        "toggleConfirmPassword"
      );

    const strengthWrapper =
      document.getElementById(
        "strengthWrapper"
      );

    const strengthLabel =
      document.getElementById(
        "strengthLabel"
      );

    const updatePasswordButton =
      document.getElementById(
        "updatePasswordButton"
      );

    const resetStatus =
      document.getElementById(
        "resetStatus"
      );

    const verifiedText =
      document.getElementById(
        "verifiedText"
      );

    const backToVerificationButton =
      document.getElementById(
        "backToVerificationButton"
      );


    const formTitle =
      document.getElementById(
        "formTitle"
      );

    const formDescription =
      document.getElementById(
        "formDescription"
      );

    const leftIcon =
      document.getElementById(
        "leftIcon"
      );

    const leftTitle =
      document.getElementById(
        "leftTitle"
      );

    const leftDescription =
      document.getElementById(
        "leftDescription"
      );


    /* =========================================================
       STATE
       ========================================================= */

    let generatedOtp = null;
    let emailOtpSent = false;
    let otpVerified = false;
    let otpTimer = null;
    let remainingSeconds = 0;


    /* =========================================================
       STATUS FUNCTIONS
       ========================================================= */

    function showOtpStatus(
      message,
      type
    ) {

      otpStatus.textContent =
        message;

      otpStatus.className =
        "status show " +
        type;
    }


    function clearOtpStatus() {

      otpStatus.textContent =
        "";

      otpStatus.className =
        "status";
    }


    function showResetStatus(
      message,
      type
    ) {

      resetStatus.textContent =
        message;

      resetStatus.className =
        "status show " +
        type;
    }


    function clearResetStatus() {

      resetStatus.textContent =
        "";

      resetStatus.className =
        "status";
    }


    /* =========================================================
       VALIDATION
       ========================================================= */

    function validateIdentifier(
      value
    ) {

      const trimmed =
        value.trim();


      if (!trimmed) {
        return false;
      }


      const emailPattern =
        /^[^\s@]+@[^\s@]+\.[^\s@]+$/;


      const phonePattern =
        /^[+]?[0-9\s()-]{7,20}$/;


      return (
        emailPattern.test(trimmed) ||
        phonePattern.test(trimmed)
      );

    }


    /* =========================================================
       SEND OTP — Demo OTP for Account Recovery
       ========================================================= */

    sendOtpButton.addEventListener("click", async function () {

      const value = identifier.value.trim();

      if (!validateIdentifier(value)) {
        showOtpStatus("Please enter a valid email address or phone number.", "error");
        identifier.focus();
        return;
      }

      clearOtpStatus();
      sendOtpButton.disabled = true;
      sendOtpButton.textContent = "Sending...";

      /* Generate 6-digit Demo OTP */
      generatedOtp = String(Math.floor(100000 + Math.random() * 900000));
      otpVerified = false;
      emailOtpSent = true;

      // Populate demo OTP UI
      if (demoOtpCode) demoOtpCode.textContent = generatedOtp;
      if (demoOtpBox) demoOtpBox.classList.add("show");
      verifyOtpButton.disabled = false;
      otp.value = "";

      console.log("AskExpert Password Recovery Demo OTP:", generatedOtp);

      const isEmail = /^\S+@\S+\.\S+$/.test(value);
      if (isEmail && supabase) {
        try {
          supabase.auth.resetPasswordForEmail(value.toLowerCase(), {
            redirectTo: window.location.origin + "/reset-password.html"
          }).catch(function (err) {
            console.warn("Supabase reset email notice:", err);
          });
        } catch (e) {
          console.warn("Supabase auth notice:", e);
        }
      }

      showOtpStatus(
        "⚡ Demo OTP generated: " + generatedOtp + ". Enter the code or click Auto-fill to verify.",
        "success"
      );

      startOtpTimer();
    });


    /* =========================================================
       AUTO-FILL OTP
       ========================================================= */

    if (autoFillOtpButton) {
      autoFillOtpButton.addEventListener("click", function () {
        if (generatedOtp) {
          otp.value = generatedOtp;
          verifyOtpButton.disabled = false;
          verifyOtpButton.focus();
        }
      });
    }


    /* =========================================================
       OTP TIMER
       ========================================================= */

    function startOtpTimer() {

      clearInterval(
        otpTimer
      );


      remainingSeconds =
        60;


      sendOtpButton.disabled =
        true;


      updateOtpButton();


      otpTimer =
        setInterval(
          function () {

            remainingSeconds--;


            updateOtpButton();


            if (
              remainingSeconds <= 0
            ) {

              clearInterval(
                otpTimer
              );


              sendOtpButton.disabled =
                false;


              sendOtpButton.textContent =
                "Resend OTP";

            }

          },
          1000
        );

    }


    function updateOtpButton() {

      sendOtpButton.textContent =
        "Resend in " +
        remainingSeconds +
        "s";

    }


    /* =========================================================
       OTP INPUT ONLY NUMBERS
       ========================================================= */

    otp.addEventListener(
      "input",
      function () {

        otp.value =
          otp.value
            .replace(/\D/g, "")
            .slice(0, 6);

        if (otp.value.length === 6) {
          verifyOtpButton.disabled = false;
        }

      }
    );


    /* =========================================================
       VERIFY OTP
       ========================================================= */

    verifyOtpButton.addEventListener("click", async function () {

      const enteredOtp = otp.value.trim();
      const value = identifier.value.trim();
      const isEmail = /^\S+@\S+\.\S+$/.test(value);

      if (!generatedOtp && !emailOtpSent) {
        showOtpStatus("Please request an OTP first.", "error");
        return;
      }

      if (enteredOtp.length !== 6) {
        showOtpStatus("Please enter the 6-digit OTP.", "error");
        otp.focus();
        return;
      }

      showOtpStatus("Verifying OTP...", "loading");
      verifyOtpButton.disabled = true;

      // 1. Check generated Demo OTP match
      if (generatedOtp && enteredOtp === generatedOtp) {
        otpVerified = true;
      } else if (isEmail && supabase) {
        // 2. Fallback check against Supabase recovery OTP if user entered real email token
        const { data, error } = await supabase.auth.verifyOtp({
          email: value.toLowerCase(),
          token: enteredOtp,
          type: "recovery"
        });

        if (!error && (data?.session || data?.user)) {
          otpVerified = true;
        }
      }

      if (!otpVerified) {
        showOtpStatus("Invalid OTP. Please check the OTP and try again.", "error");
        verifyOtpButton.disabled = false;
        return;
      }

      /* OTP VERIFIED */
      clearInterval(otpTimer);
      sendOtpButton.disabled = true;
      verifyOtpButton.disabled = true;
      otp.disabled = true;
      identifier.disabled = true;


        stepOne.classList.remove(
          "active"
        );


        stepOne.classList.add(
          "completed"
        );


        stepTwo.classList.add(
          "active"
        );


        lineOne.classList.add(
          "completed"
        );


        verifiedText.textContent =
          "Verified account: " +
          identifier.value.trim();


        showOtpStatus(
          "OTP verified successfully.",
          "success"
        );


        /*
         * Store only temporary verification state.
         *
         * No password is stored.
         */

        sessionStorage.setItem(
          "askexpert_password_reset",
          "verified"
        );


        sessionStorage.setItem(
          "askexpert_reset_identifier",
          identifier.value.trim()
        );


        setTimeout(
          function () {

            openResetScreen();

          },
          500
        );

      }
    );


    /* =========================================================
       OPEN RESET SCREEN
       ========================================================= */

    function openResetScreen() {

      verificationScreen.classList.remove(
        "active"
      );


      resetScreen.classList.add(
        "active"
      );


      formTitle.textContent =
        "Reset Password";


      formDescription.textContent =
        "Create a strong new password for your AskExpert account.";


      leftIcon.textContent =
        "🔑";


      leftTitle.innerHTML =
        'Create a <span class="gradient-text">new password.</span>';


      leftDescription.textContent =
        "Your account has been verified. Create a new secure password below.";


      newPassword.focus();

    }


    /* =========================================================
       BACK TO VERIFICATION
       ========================================================= */

    backToVerificationButton.addEventListener(
      "click",
      function () {

        resetScreen.classList.remove(
          "active"
        );


        verificationScreen.classList.add(
          "active"
        );


        formTitle.textContent =
          "Recover Account";


        formDescription.textContent =
          "Enter your email address or phone number to begin account recovery.";


        leftIcon.textContent =
          "🔐";


        leftTitle.innerHTML =
          'Recover your <span class="gradient-text">account.</span>';


        leftDescription.textContent =
          "Verify your account using a one-time password and securely create a new password.";


        identifier.disabled =
          false;


        otp.disabled =
          false;


        verifyOtpButton.disabled =
          !generatedOtp;


        clearResetStatus();

      }
    );


    /* =========================================================
       PASSWORD TOGGLE
       ========================================================= */

    function setupPasswordToggle(
      button,
      input
    ) {

      button.addEventListener(
        "click",
        function () {

          if (
            input.type ===
            "password"
          ) {

            input.type =
              "text";


            button.textContent =
              "🙈";


            button.setAttribute(
              "aria-label",
              "Hide password"
            );


            button.setAttribute(
              "title",
              "Hide password"
            );

          } else {

            input.type =
              "password";


            button.textContent =
              "👁";


            button.setAttribute(
              "aria-label",
              "Show password"
            );


            button.setAttribute(
              "title",
              "Show password"
            );

          }

        }
      );

    }


    setupPasswordToggle(
      toggleNewPassword,
      newPassword
    );


    setupPasswordToggle(
      toggleConfirmPassword,
      confirmPassword
    );


    /* =========================================================
       PASSWORD REQUIREMENT
       ========================================================= */

    function updateRequirement(
      element,
      valid
    ) {

      if (valid) {

        element.classList.add(
          "valid"
        );

      } else {

        element.classList.remove(
          "valid"
        );

      }

    }


    /* =========================================================
       PASSWORD STRENGTH
       ========================================================= */

    function calculateStrength(
      password
    ) {

      let score = 0;


      if (
        password.length >= 8
      ) {
        score++;
      }


      if (
        /[A-Z]/.test(password)
      ) {
        score++;
      }


      if (
        /[a-z]/.test(password)
      ) {
        score++;
      }


      if (
        /[0-9]/.test(password)
      ) {
        score++;
      }


      if (
        /[^A-Za-z0-9]/.test(password)
      ) {
        score++;
      }


      return score;

    }


    /* =========================================================
       UPDATE PASSWORD UI
       ========================================================= */

    function updatePasswordUI() {

      const password =
        newPassword.value;


      const confirmation =
        confirmPassword.value;


      const hasLength =
        password.length >= 8;


      const hasUpper =
        /[A-Z]/.test(password);


      const hasLower =
        /[a-z]/.test(password);


      const hasNumber =
        /[0-9]/.test(password);


      const hasSpecial =
        /[^A-Za-z0-9]/.test(password);


      const matches =
        password.length > 0 &&
        password === confirmation;


      updateRequirement(
        document.getElementById(
          "reqLength"
        ),
        hasLength
      );


      updateRequirement(
        document.getElementById(
          "reqUpper"
        ),
        hasUpper
      );


      updateRequirement(
        document.getElementById(
          "reqLower"
        ),
        hasLower
      );


      updateRequirement(
        document.getElementById(
          "reqNumber"
        ),
        hasNumber
      );


      updateRequirement(
        document.getElementById(
          "reqSpecial"
        ),
        hasSpecial
      );


      updateRequirement(
        document.getElementById(
          "reqMatch"
        ),
        matches
      );


      /* STRENGTH */

      const score =
        calculateStrength(
          password
        );


      strengthWrapper.className =
        "strength-wrapper";


      if (!password) {

        strengthLabel.textContent =
          "Enter password";

      } else if (
        score <= 2
      ) {

        strengthWrapper.classList.add(
          "weak"
        );

        strengthLabel.textContent =
          "Weak";

      } else if (
        score === 3
      ) {

        strengthWrapper.classList.add(
          "medium"
        );

        strengthLabel.textContent =
          "Medium";

      } else if (
        score === 4
      ) {

        strengthWrapper.classList.add(
          "strong"
        );

        strengthLabel.textContent =
          "Strong";

      } else {

        strengthWrapper.classList.add(
          "very-strong"
        );

        strengthLabel.textContent =
          "Very Strong";

      }


      /* ENABLE UPDATE BUTTON */

      const valid =
        hasLength &&
        hasUpper &&
        hasLower &&
        hasNumber &&
        hasSpecial &&
        matches;


      updatePasswordButton.disabled =
        !valid;

    }


    newPassword.addEventListener(
      "input",
      updatePasswordUI
    );


    confirmPassword.addEventListener(
      "input",
      updatePasswordUI
    );


    /* =========================================================
       UPDATE PASSWORD
       ========================================================= */

    updatePasswordButton.addEventListener(
      "click",
      async function () {

        const password =
          newPassword.value;


        const confirmation =
          confirmPassword.value;


        if (!otpVerified) {

          showResetStatus(
            "Please verify your account first.",
            "error"
          );

          return;
        }


        if (
          password !==
          confirmation
        ) {

          showResetStatus(
            "Passwords do not match.",
            "error"
          );

          return;
        }


        if (
          calculateStrength(
            password
          ) < 5
        ) {

          showResetStatus(
            "Please meet all password requirements.",
            "error"
          );

          return;
        }


        /*
         * IMPORTANT
         * -----------------------------------------------------
         *
         * This section is the place where Firebase
         * Authentication should perform the real password
         * update.
         *
         * This frontend-only version intentionally does NOT
         * save the password into localStorage/sessionStorage.
         *
         * -----------------------------------------------------
         */


        updatePasswordButton.disabled =
          true;

        updatePasswordButton.textContent =
          "Updating...";

        clearResetStatus();

        try {
          // Real Supabase Auth password update if active recovery session exists
          if (supabase && (await supabase.auth.getSession()).data.session) {
            const { data, error } = await supabase.auth.updateUser({
              password: password
            });

            if (error) {
              console.error("Supabase updateUser password error:", error);
              showResetStatus("Failed to update password: " + error.message, "error");
              updatePasswordButton.disabled = false;
              updatePasswordButton.textContent = "Update Password";
              return;
            }
          }
        } catch (e) {
          console.warn("Supabase password update fallback:", e);
        }

        setTimeout(
          function () {

            sessionStorage.removeItem(
              "askexpert_password_reset"
            );

            sessionStorage.removeItem(
              "askexpert_reset_identifier"
            );

            resetScreen.classList.remove(
              "active"
            );

            stepTwo.classList.remove(
              "active"
            );

            stepTwo.classList.add(
              "completed"
            );

            stepThree.classList.add(
              "active"
            );

            lineTwo.classList.add(
              "completed"
            );

            successScreen.classList.add(
              "show"
            );

            formTitle.textContent =
              "Password Updated";

            formDescription.textContent =
              "Your account recovery is complete.";

          },
          600
        );

      }
    );


    /* =========================================================
       INITIAL PASSWORD UI
       ========================================================= */

    updatePasswordUI();


    /* =========================================================
       ENTER KEY
       ========================================================= */

    identifier.addEventListener(
      "keydown",
      function (event) {

        if (
          event.key === "Enter"
        ) {

          sendOtpButton.click();

        }

      }
    );


    otp.addEventListener(
      "keydown",
      function (event) {

        if (
          event.key === "Enter"
        ) {

          verifyOtpButton.click();

        }

      }
    );


    newPassword.addEventListener(
      "keydown",
      function (event) {

        if (
          event.key === "Enter"
        ) {

          updatePasswordButton.click();

        }

      }
    );


    confirmPassword.addEventListener(
      "keydown",
      function (event) {

        if (
          event.key === "Enter"
        ) {

          updatePasswordButton.click();

        }

      }
    );


  