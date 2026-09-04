import { createClient } from '@supabase/supabase-js';
import fs from 'fs';

const supabase = createClient('https://girexuzrkeiylkbqglks.supabase.co', 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P');

// All candidate tables and candidate columns from all sql files in database/
const candidateTables = {
  profiles: [
    'id', 'email', 'full_name', 'username', 'avatar_url', 'phone', 'role',
    'headline', 'specialization', 'bio', 'experience_years', 'languages',
    'skills', 'category', 'location', 'consultation_fee', 'rating',
    'reviews_count', 'is_verified', 'is_blocked', 'is_demo',
    'availability_status', 'account_status', 'wallet_balance', 'created_at', 'updated_at'
  ],
  professional_verifications: [
    'id', 'expert_id', 'council_registration_no', 'council_registration_number',
    'degree_qualification', 'id_document_path', 'verification_status',
    'identity_verified', 'degree_verified', 'council_verified',
    'rejection_reason', 'submitted_at', 'created_at', 'updated_at'
  ],
  questions: [
    'id', 'user_id', 'title', 'description', 'body', 'category', 'tags',
    'language', 'status', 'answers_count', 'answer_count',
    'moderation_status', 'moderation_reason', 'moderated_by', 'moderated_at',
    'created_at', 'updated_at'
  ],
  answers: [
    'id', 'question_id', 'user_id', 'expert_id', 'author_name', 'author_role',
    'author_avatar', 'author_headline', 'content', 'media_url',
    'helpful_count', 'is_accepted', 'created_at', 'updated_at'
  ],
  conversations: [
    'id', 'user_id', 'expert_id', 'professional_id', 'status', 'created_at', 'updated_at'
  ],
  messages: [
    'id', 'conversation_id', 'sender_id', 'sender_role', 'recipient_id',
    'content', 'message_type', 'media_url', 'media_metadata', 'status', 'created_at'
  ],
  consultation_requests: [
    'id', 'question_id', 'user_id', 'expert_id', 'professional_id',
    'offered_amount', 'status', 'message', 'created_at', 'updated_at'
  ],
  payments: [
    'id', 'user_id', 'expert_id', 'conversation_id', 'amount', 'currency',
    'payment_method', 'provider', 'provider_payment_id', 'status', 'description', 'created_at'
  ],
  payout_requests: [
    'id', 'expert_id', 'amount', 'status', 'payout_reference', 'notes', 'created_at', 'processed_at'
  ],
  notifications: [
    'id', 'user_id', 'recipient_id', 'type', 'title', 'message', 'related_id', 'is_read', 'created_at'
  ],
  reports: [
    'id', 'reporter_id', 'reported_user_id', 'question_id', 'message_id',
    'reason', 'status', 'resolution_notes', 'resolved_by', 'created_at', 'resolved_at'
  ],
  consultation_sessions: [
    'id', 'request_id', 'user_id', 'expert_id', 'scheduled_start', 'scheduled_end',
    'actual_start', 'actual_end', 'session_type', 'status', 'session_rate',
    'total_amount', 'escrow_payment_id', 'notes', 'created_at', 'updated_at'
  ],
  reviews: [
    'id', 'session_id', 'expert_id', 'user_id', 'rating', 'review_text', 'created_at'
  ],
  session_events: [
    'id', 'session_id', 'event_type', 'actor_id', 'payload', 'created_at'
  ],
  system_health: [
    'id', 'metric_name', 'metric_value', 'status', 'details', 'recorded_at'
  ],
  audit_logs: [
    'id', 'actor_id', 'action_type', 'resource_type', 'target_table',
    'record_id', 'details', 'ip_address', 'user_agent', 'created_at'
  ],
  system_errors: [
    'id', 'fingerprint', 'error_type', 'error_message', 'message',
    'stack_trace', 'component_stack', 'source_file', 'source_line',
    'environment', 'browser_info', 'user_id', 'session_id',
    'occurrence_count', 'first_seen_at', 'last_seen_at', 'status',
    'created_at', 'updated_at'
  ],
  error_fix_proposals: [
    'id', 'error_id', 'proposal_title', 'root_cause_analysis', 'affected_files',
    'proposed_code_changes', 'proposed_diff', 'risk_level', 'confidence_score',
    'rollback_plan', 'status', 'approved_by', 'approved_at', 'execution_log',
    'created_at', 'updated_at'
  ],
  domains: [
    'id', 'name', 'slug', 'description', 'icon', 'color', 'created_at'
  ],
  issue_reports: [
    'id', 'reporter_id', 'report_type', 'title', 'description', 'steps_to_reproduce',
    'severity', 'status', 'system_logs', 'screenshot_url', 'created_at', 'updated_at'
  ],
  ai_fix_proposals: [
    'id', 'report_id', 'root_cause_analysis', 'proposed_diff', 'affected_files',
    'risk_level', 'rollback_instructions', 'ai_confidence_score', 'status',
    'created_at', 'updated_at'
  ],
  admin_approvals: [
    'id', 'proposal_id', 'admin_id', 'decision', 'admin_notes', 'action_status', 'executed_at'
  ],
  privacy_settings: [
    'id', 'user_id', 'allow_chat_requests', 'profile_visibility', 'share_activity_status',
    'created_at', 'updated_at'
  ]
};

async function probeLiveSchema() {
  const schemaReport = {};

  for (const [table, cols] of Object.entries(candidateTables)) {
    // 1. Check if table exists
    const { error: tblErr } = await supabase.from(table).select('*').limit(0);
    if (tblErr && tblErr.message.includes('Could not find the table')) {
      schemaReport[table] = { exists: false, error: tblErr.message };
      continue;
    }

    const existingCols = [];
    const missingCols = [];

    // Probe columns in batches of 5
    for (const col of cols) {
      const { error: colErr } = await supabase.from(table).select(col).limit(0);
      if (!colErr) {
        existingCols.push(col);
      } else {
        missingCols.push({ col, error: colErr.message });
      }
    }

    schemaReport[table] = {
      exists: true,
      existingCols,
      missingCols: missingCols.map(m => m.col)
    };
  }

  fs.writeFileSync('scratch/live_schema_dump.json', JSON.stringify(schemaReport, null, 2));
  console.log('Live schema dump written to scratch/live_schema_dump.json');
}

probeLiveSchema();
