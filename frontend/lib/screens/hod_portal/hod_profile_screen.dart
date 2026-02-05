import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/current_user_service.dart';


  class HODProfileScreen extends StatefulWidget {
  const HODProfileScreen({super.key});

  @override
  State<HODProfileScreen> createState() => _HODProfileScreenState();
}

class _HODProfileScreenState extends State<HODProfileScreen> {
Map<String, dynamic>? userData;


  String status = "Present";

Color get statusColor {
  switch (status) {
    case "Absent":
      return Colors.red;
    case "Permission":
      return Colors.orange;
    case "OD":
      return Colors.blue;
    default:
      return Colors.green;
  }
}
@override
void initState() {
  super.initState();
  userData = CurrentUserService.getUser();
}

IconData get statusIcon {
  switch (status) {
    case "Absent":
      return Icons.cancel;
    case "Permission":
      return Icons.access_time;
    case "OD":
      return Icons.work_outline;
    default:
      return Icons.check_circle;
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ================= PROFILE TITLE =================
Text(
  "Profile",
  style: GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.grey[800],
  ),
),


const SizedBox(height: 12),

             

              // ================= PROFILE CARD =================
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: const Color(0xFFF3E8FF),
          child: const Icon(
            Icons.person_outline,
            color: Colors.purpleAccent,
            size: 30,
          ),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
  userData?['username'] ?? '',
  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
),

Text(
  userData?['staffId'] ?? '',
  style: GoogleFonts.inter(fontSize: 13, color: Colors.grey),
),

Text(
  userData?['department'] ?? '',
  style: GoogleFonts.inter(fontSize: 13, color: Colors.grey),
),

Text(
  userData?['designation'] ?? '',
  style: GoogleFonts.inter(fontSize: 13, color: Colors.grey),
),

          ],
        ),
      ],
    ),

    // ✅ Settings icon stays
    IconButton(
      icon: const Icon(Icons.settings_outlined, color: Colors.grey),
      onPressed: () {
        showDialog(
          context: context,
          barrierColor: Colors.black.withOpacity(0.45),
          builder: (_) => const _SettingsDialog(),
        );
      },
    ),
  ],
),

              ),

              const SizedBox(height: 14),

// ================= STATUS =================
InkWell(
  onTap: _showStatusPopup,
  borderRadius: BorderRadius.circular(16),
  child: Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(statusIcon, color: statusColor),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Status",
                style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
            Text(
              status,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: statusColor,
              ),
            ),
          ],
        ),
        const Spacer(),
        const Icon(Icons.chevron_right, color: Colors.grey),
      ],
    ),
  ),
),

const SizedBox(height: 14),
              // ================= DETAILS =================
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
  children: [
    _Detail(Icons.email_outlined, userData?['email'] ?? ''),
    _Detail(Icons.phone_outlined, userData?['phone'] ?? ''),
    _Detail(Icons.school_outlined, userData?['department'] ?? ''),
    _Detail(Icons.location_on_outlined, userData?['address'] ?? ''),
  ],
),

              ),

              const SizedBox(height: 24),

              // ================= LOGOUT =================

              const SizedBox(height: 24),

SizedBox(
  width: double.infinity,
  child: OutlinedButton.icon(
    icon: const Icon(
      Icons.logout_outlined,
      color: Color.fromARGB(255, 47, 44, 52),
      size: 20,
    ),
    label: Text(
      "Logout",
      style: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: const Color.fromARGB(255, 47, 44, 52),
      ),
    ),
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 14),
      side: BorderSide(color: const Color.fromARGB(255, 83, 83, 83)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: const Color.fromARGB(255, 83, 83, 83).withOpacity(0.04),
    ),
    onPressed: () {
      showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.45),
        builder: (_) => const LogoutConfirmDialog(),
      );
    },
  ),
),

            ],
          ),
        ),
      ),
    );
  }


  // ================= STATUS POPUP =================
void _showStatusPopup() {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.45),
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Update Status",
                    style: GoogleFonts.inter(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Text("Select your current attendance status",
                style: GoogleFonts.inter(
                    fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 16),

            _statusOption("Present", Icons.check_circle, Colors.green),
            _statusOption("Absent", Icons.cancel, Colors.red),
            _statusOption("Permission", Icons.access_time, Colors.orange),
            _statusOption("OD", Icons.work_outline, Colors.blue),
          ],
        ),
      ),
    ),
  );
}

Widget _statusOption(String value, IconData icon, Color color) {
  final selected = status == value;
  return InkWell(
    onTap: () {
      setState(() => status = value);
      Navigator.pop(context);
    },
    borderRadius: BorderRadius.circular(14),
    child: Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: selected ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: selected ? Colors.white : color),
          const SizedBox(width: 12),
          Text(value,
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : Colors.black)),
        ],
      ),
    ),
  );
}

}

// ===================================================================
// ================= SETTINGS DIALOG =================================
// ===================================================================

class _SettingsDialog extends StatefulWidget {
  const _SettingsDialog();

  @override
  State<_SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<_SettingsDialog> {
  bool notifications = true;
  bool showChangePassword = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 70),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Settings",
                      style: GoogleFonts.inter(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Text(
                "Manage your account and preferences",
                style: GoogleFonts.inter(fontSize: 13, color: Colors.grey),
              ),

              const SizedBox(height: 16),

              // PUSH NOTIFICATIONS
              _card(
                child: Row(
                  children: [
                    _icon(Icons.notifications_outlined, Colors.blueAccent,
                        const Color(0xFFE8F2FF)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Push Notifications",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600)),
                          Text("Receive notifications on your device",
                              style: GoogleFonts.inter(
                                  fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ),
                    Switch(
  value: notifications,
  activeColor: Colors.black,
  activeTrackColor: Colors.black.withOpacity(0.35),

  inactiveThumbColor: Colors.grey.shade600,
  inactiveTrackColor: Colors.grey.shade300,

  onChanged: (v) {
    setState(() {
      notifications = v;
    });
  },
),

                  ],
                ),
              ),

              const SizedBox(height: 12),

              // CHANGE PASSWORD
              _card(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => setState(
                          () => showChangePassword = !showChangePassword),
                      child: Row(
                        children: [
                          _icon(Icons.lock_outline, Colors.green,
                              const Color(0xFFE8FFF0)),
                          const SizedBox(width: 12),
                          const Expanded(
                              child: Text("Change Password")),
                          Text(showChangePassword ? "Cancel" : "",
                              style: GoogleFonts.inter(color: Colors.red)),
                        ],
                      ),
                    ),
                    if (showChangePassword) ...[
                      const SizedBox(height: 12),
                      _label("Current Password"),
                      _input("Enter current password"),
                      _label("New Password"),
                      _input("Enter new password"),
                      _label("Confirm Password"),
                      _input("Confirm new password"),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding:
                                const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
          onPressed: () {
  // ✅ Close change password section
  setState(() {
    showChangePassword = false;
  });

  // ✅ Show success message
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Password updated successfully"),
      backgroundColor: Colors.green,
    ),
  );
},


                          child: const Text("Update Password"),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // TERMS
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierColor: Colors.black.withOpacity(0.45),
                    builder: (_) => const TermsConditionsDialog(),
                  );
                },
                child: _tile(Icons.description_outlined, Colors.purpleAccent,
                    "Terms and Conditions", "Read our terms of service"),
              ),

              // PRIVACY POLICY
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierColor: Colors.black.withOpacity(0.45),
                    builder: (_) => const PrivacyPolicyDialog(),
                  );
                },
                child: _tile(Icons.privacy_tip_outlined, Colors.orange,
                    "Privacy Policy", "Learn how we protect your data"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card({required Widget child}) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: child,
      );

  Widget _icon(IconData icon, Color color, Color bg) => Container(
        height: 40,
        width: 40,
        decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: color),
      );

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(text,
            style: GoogleFonts.inter(
                fontSize: 12, fontWeight: FontWeight.w500)),
      );

  Widget _input(String hint) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
          ),
        ),
      );

  Widget _tile(
      IconData icon, Color color, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          _icon(icon, color, color.withOpacity(0.15)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style:
                        GoogleFonts.inter(fontWeight: FontWeight.w600)),
                Text(subtitle,
                    style: GoogleFonts.inter(
                        fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}

// ===================================================================
// ================= TERMS POPUP =====================================
// ===================================================================

class TermsConditionsDialog extends StatelessWidget {
  const TermsConditionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return _policyDialog(
      context,
      "Terms and Conditions",
      const [
        _PolicyItem("1. Acceptance of Terms",
            "By accessing the portal you agree to these terms."),
        _PolicyItem("2. Professional Conduct",
            "Portal must be used for official purposes only."),
        _PolicyItem("3. Account Security",
            "You are responsible for safeguarding your credentials."),
      ],
    );
  }
}

// ===================================================================
// ================= PRIVACY POPUP ===================================
// ===================================================================

class PrivacyPolicyDialog extends StatelessWidget {
  const PrivacyPolicyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return _policyDialog(
      context,
      "Privacy Policy",
      const [
        _PolicyItem("1. Information We Collect",
            "We collect personal and professional information."),
        _PolicyItem("2. Data Security",
            "We use security measures to protect your data."),
      ],
    );
  }
}

// ===================================================================
// ================= SHARED POLICY DIALOG ============================
// ===================================================================

Widget _policyDialog(
    BuildContext context, String title, List<Widget> children) {
  return Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: GoogleFonts.inter(
                      fontSize: 16, fontWeight: FontWeight.w600)),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          Text("Last updated: October 30, 2025",
              style: GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 12),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: children),
            ),
          ),
        ],
      ),
    ),
  );
}

class _PolicyItem extends StatelessWidget {
  final String title;
  final String text;
  const _PolicyItem(this.title, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  GoogleFonts.inter(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(text,
              style:
                  GoogleFonts.inter(fontSize: 13, height: 1.5)),
        ],
      ),
    );
  }
}

// ===================================================================
// ================= DETAIL WIDGET ===================================
// ===================================================================

class _Detail extends StatelessWidget {
  final IconData icon;
  final String text;
  const _Detail(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
class LogoutConfirmDialog extends StatelessWidget {
  const LogoutConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Logout"),
      content: const Text("Are you sure you want to logout?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // close dialog
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/',
              (route) => false,
            );
          },
          child: const Text("Logout"),
        ),
      ],
    );
  }
}