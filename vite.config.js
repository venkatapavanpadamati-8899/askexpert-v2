import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import { resolve } from 'path';

export default defineConfig({
  plugins: [react()],
  server: {
    port: 5173,
    host: true
  },
  build: {
    rollupOptions: {
      input: {
        main: resolve(__dirname, 'index.html'),
        login: resolve(__dirname, 'login.html'),
        register: resolve(__dirname, 'register.html'),
        forgotPassword: resolve(__dirname, 'forgot-password.html'),
        resetPassword: resolve(__dirname, 'reset-password.html'),
        userDashboard: resolve(__dirname, 'user-dashboard.html'),
        experts: resolve(__dirname, 'experts.html'),
        expertProfile: resolve(__dirname, 'expert-profile.html'),
        askQuestion: resolve(__dirname, 'ask-question.html'),
        questions: resolve(__dirname, 'questions.html'),
        questionDetails: resolve(__dirname, 'question-details.html'),
        chat: resolve(__dirname, 'chat.html'),
        payments: resolve(__dirname, 'payments.html'),
        paymentHistory: resolve(__dirname, 'payment-history.html'),
        profile: resolve(__dirname, 'profile.html'),
        editProfile: resolve(__dirname, 'edit-profile.html'),
        notifications: resolve(__dirname, 'notifications.html'),
        review: resolve(__dirname, 'review.html'),
        professionalDashboard: resolve(__dirname, 'professional-dashboard.html'),
        professionalVerification: resolve(__dirname, 'professional-verification.html'),
        professionalEarnings: resolve(__dirname, 'professional-earnings.html'),
        professionalProfile: resolve(__dirname, 'professional-profile.html'),
        consultationRequests: resolve(__dirname, 'consultation-requests.html'),
        adminLogin: resolve(__dirname, 'admin-login.html'),
        adminDashboard: resolve(__dirname, 'admin-dashboard.html'),
        adminUsers: resolve(__dirname, 'admin-users.html'),
        adminProfessionals: resolve(__dirname, 'admin-professionals.html'),
        adminQuestions: resolve(__dirname, 'admin-questions.html'),
        adminPayments: resolve(__dirname, 'admin-payments.html'),
        adminReports: resolve(__dirname, 'admin-reports.html'),
        adminHealth: resolve(__dirname, 'admin-health.html'),
        adminAiFixCenter: resolve(__dirname, 'admin-ai-fix-center.html'),
        flowchart: resolve(__dirname, 'flowchart.html')
      }
    }
  }
});
