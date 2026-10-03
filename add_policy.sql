CREATE POLICY "Admins can view professional verifications" ON professional_verifications FOR SELECT USING (is_admin());
CREATE POLICY "Admins can update professional verifications" ON professional_verifications FOR UPDATE USING (is_admin());
