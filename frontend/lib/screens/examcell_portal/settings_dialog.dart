import 'package:flutter/material.dart';
import 'terms_conditions_dialog.dart';
import 'privacy_policy_dialog.dart';



class SettingsDialog extends StatefulWidget {
  const SettingsDialog({super.key});

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  bool notificationsEnabled = true;
  bool showChangePassword = false;

  final TextEditingController currentPwd = TextEditingController();
  final TextEditingController newPwd = TextEditingController();
  final TextEditingController confirmPwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- HEADER ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Settings',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Text(
              'Manage your account settings and preferences',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // ---------- NOTIFICATIONS ----------
            _settingsTile(
              icon: Icons.notifications,
              iconColor: Colors.blue,
              title: 'Notifications',
              subtitle: 'Enable push notifications',
              trailing: Switch(
                value: notificationsEnabled,
                onChanged: (val) {
                  setState(() => notificationsEnabled = val);
                },
              ),
            ),

            const SizedBox(height: 12),

            // ---------- CHANGE PASSWORD ----------
            Container(
              padding: const EdgeInsets.all(14),
              decoration: _cardDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        showChangePassword = !showChangePassword;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: Color(0xFFE8F5E9),
                              child: Icon(Icons.lock,
                                  size: 18, color: Colors.green),
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Change Password',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Text(
                          showChangePassword ? 'Cancel' : '',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  if (showChangePassword) ...[
                    const SizedBox(height: 16),
                    _passwordField(
                        'Current Password', 'Enter current password', currentPwd),
                    _passwordField(
                        'New Password', 'Enter new password', newPwd),
                    _passwordField(
                        'Confirm Password', 'Confirm new password', confirmPwd),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Update Password'),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ---------- TERMS ----------
            _settingsTile(
  icon: Icons.description,
  iconColor: Colors.purple,
  title: 'Terms and Conditions',
  subtitle: 'Read our terms of service',
  trailing: const Icon(Icons.chevron_right),
  onTap: () {
    showDialog(
      context: context,
      builder: (_) => const TermsConditionsDialog(),
    );
  },
),


            const SizedBox(height: 12),

            // ---------- PRIVACY ----------
            _settingsTile(
  icon: Icons.privacy_tip,
  iconColor: Colors.orange,
  title: 'Privacy Policy',
  subtitle: 'Read our privacy policy',
  trailing: const Icon(Icons.chevron_right),
  onTap: () {
    showDialog(
      context: context,
      builder: (_) => const PrivacyPolicyDialog(),
    );
  },
),

          ],
        ),
      ),
    );
  }

  // ================= HELPERS =================

 Widget _settingsTile({
  required IconData icon,
  required Color iconColor,
  required String title,
  required String subtitle,
  Widget? trailing,
  VoidCallback? onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: iconColor.withOpacity(0.15),
            child: Icon(icon, size: 18, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    ),
  );
}


  Widget _passwordField(
      String label, String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            obscureText: true,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    );
  }
}
