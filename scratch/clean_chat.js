import fs from 'fs';

const filePath = 'd:/ASKEXPERT/chat.html';
let code = fs.readFileSync(filePath, 'utf8');

// Replace EXPERT_DIRECTORY declaration
const oldDirRegex = /\/\* =+\s*APPLICATION STATE & EXPERT DIRECTORY[\s\S]*?let currentExpert = EXPERT_DIRECTORY\["Adv\. Vikram Rao"\];/;

const newDirCode = `/* ========================================================
   APPLICATION STATE & VERIFIED EXPERT INITIALIZATION
   ======================================================== */
    let currentExpert = null;`;

code = code.replace(oldDirRegex, newDirCode);

// Update switchActiveConversation to remove fallback logic
const oldSwitchBlockRegex = /async function switchActiveConversation\(expert\) \{[\s\S]*?subscribeToRealtime\(activeConversationId\);\s*\} catch \(err\) \{[\s\S]*?\}\s*\}/;

const newSwitchBlockCode = `async function switchActiveConversation(expert) {
      if (!expert || !expert.id) {
        renderInvalidExpertState("No valid expert specified.");
        return;
      }

      currentExpert = expert;
      applyExpertToUI(expert);

      if (!supabase) {
        renderInvalidExpertState("Database connection unavailable.");
        return;
      }

      try {
        // Strict DB verification: profile must exist, role must be expert, and is_verified must be true
        const { data: dbExpert, error: expCheckErr } = await supabase
          .from("profiles")
          .select("id, full_name, headline, specialization, is_verified, role")
          .eq("id", expert.id)
          .eq("role", "expert")
          .eq("is_verified", true)
          .maybeSingle();

        if (expCheckErr || !dbExpert) {
          renderInvalidExpertState("The requested expert profile is not verified or no longer available.");
          return;
        }

        const targetExpertId = dbExpert.id;

        // Find or create conversation in 'conversations' table
        const { data: existingConv } = await supabase
          .from("conversations")
          .select("id")
          .eq("user_id", currentUserId)
          .eq("expert_id", targetExpertId)
          .maybeSingle();

        if (existingConv && existingConv.id) {
          activeConversationId = existingConv.id;
        } else {
          const { data: newConv, error: createErr } = await supabase
            .from("conversations")
            .insert({
              user_id: currentUserId,
              expert_id: targetExpertId,
              status: "active"
            })
            .select("id")
            .single();

          if (createErr || !newConv) {
            console.error("Error creating conversation:", createErr);
            renderInvalidExpertState("Unable to initiate consultation session.");
            return;
          }
          activeConversationId = newConv.id;
        }

        enableChatInput();

        // Load historical messages
        await loadMessages(activeConversationId);

        // Subscribe to Realtime Postgres Changes
        subscribeToRealtime(activeConversationId);

      } catch (err) {
        console.error("switchActiveConversation error:", err);
        renderInvalidExpertState("Error connecting to expert consultation service.");
      }
    }`;

code = code.replace(oldSwitchBlockRegex, newSwitchBlockCode);

fs.writeFileSync(filePath, code, 'utf8');
console.log('Cleaned up EXPERT_DIRECTORY and switchActiveConversation in chat.html');
