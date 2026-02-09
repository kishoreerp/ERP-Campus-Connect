import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/screens/slec_home_screen.dart';

class ManagementProfileScreen extends StatefulWidget {
  const ManagementProfileScreen({super.key});

  @override
  State<ManagementProfileScreen> createState() =>
      _ManagementProfileScreenState();
}

class _ManagementProfileScreenState
    extends State<ManagementProfileScreen> {

  // ================= STATE =================
  String selectedStatus = "Present";
  String phoneNumber = "+91 9876543210";

  bool notificationsEnabled = true;
  bool showChangePassword = false;

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController =
      TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //---------------- HEADER ----------------
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text("SLEC",
                        style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(width: 10),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Admin Panel",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600)),
                      Text("Management Admin",
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.grey)),
                    ],
                  ),

                  const Spacer(),

                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: showSettingsPopup,
                  )
                ],
              ),

              const SizedBox(height: 20),

              //---------------- PROFILE CARD ----------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.person,
                          color: Colors.white, size: 36),
                    ),
                    const SizedBox(height: 10),
                    Text("Dr. Sandhiya",
                        style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    Text("Management Admin",
                        style: GoogleFonts.inter(color: Colors.grey)),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              //---------------- STATUS TILE ----------------
              InkWell(
                onTap: showStatusDialog,
                child: card(
                  Row(
                    children: [
                      Icon(
                        getStatusIcon(selectedStatus),
                        color: getStatusColor(selectedStatus),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text("Status",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600)),
                          Text(selectedStatus,
                              style: GoogleFonts.inter(
                                  color: Colors.grey)),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              //---------------- PERSONAL INFO ----------------
              card(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("Personal Information",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold)),

                    const SizedBox(height: 12),

                    infoRow("Full Name", "Dr. Sandhiya"),
                    infoRow("Employee ID", "SLEC-2024-001"),
                    infoRow("Email", "principal@slec.edu.in"),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              label("Phone"),
                              value(phoneNumber),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: editPhoneDialog,
                        )
                      ],
                    ),

                    const SizedBox(height: 12),

                    infoRow("Department", "Administration"),
                    infoRow("Date of Joining",
                        "January 15, 2015"),
                    infoRow("Total Experience",
                        "25 Years (10 Years at SLEC)"),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              //---------------- LOGOUT ----------------
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.logout),
                  label: const Text("Logout"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(14)),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const SlecHomeScreen(),
                      ),
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

  void showStatusDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Update Status",
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),

                statusOption("Present"),
                statusOption("Absent"),
                statusOption("Permission"),
                statusOption("OD"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget statusOption(String value) {
    bool selected = selectedStatus == value;

    return InkWell(
      onTap: () {
        setState(() => selectedStatus = value);
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(getStatusIcon(value),
                color: getStatusColor(value)),
            const SizedBox(width: 12),
            Text(
              value == "OD" ? "OD (On Duty)" : value,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color:
                    selected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= SETTINGS POPUP =================

  void showSettingsPopup() {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    Text("Settings",
                        style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () =>
                          Navigator.pop(context),
                    )
                  ],
                ),

                Text(
                  "Manage your account settings and preferences",
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey),
                ),

                const SizedBox(height: 20),

                settingsSwitchTile(),
                changePasswordTile(),
              settingsItemTile(
  Icons.description,
  "Terms and Conditions",
  onTap: () {
    showDialog(
      context: context,
      builder: (_) => const TermsConditionsDialog(),
    );
  },
),

settingsItemTile(
  Icons.privacy_tip,
  "Privacy Policy",
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
      },
    );
  }

  Widget settingsSwitchTile() {
    return card(
      Row(
        children: [
          Icon(
            notificationsEnabled
                ? Icons.notifications_active
                : Icons.notifications_off,
            color: notificationsEnabled
                ? Colors.blue
                : Colors.grey,
          ),
          const SizedBox(width: 12),
          const Text("Push Notifications"),
          const Spacer(),
          Switch(
            value: notificationsEnabled,
            onChanged: (v) {
              setState(() {
                notificationsEnabled = v;
              });
            },
          )
        ],
      ),
    );
  }

Widget changePasswordTile() {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // HEADER ROW
        InkWell(
          onTap: () {
            setState(() {
              showChangePassword = !showChangePassword;
            });
          },
          child: Row(
            children: [
              const Icon(Icons.lock, color: Colors.green),
              const SizedBox(width: 12),
              const Text(
                "Change Password",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Text(
                showChangePassword ? "Cancel" : "Change",
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        if (showChangePassword) ...[
          const SizedBox(height: 14),

          const Text("Current Password"),
          const SizedBox(height: 6),
          TextField(
            controller: currentPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Enter current password",
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 12),

          const Text("New Password"),
          const SizedBox(height: 6),
          TextField(
            controller: newPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Enter new password",
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 12),

          const Text("Confirm Password"),
          const SizedBox(height: 6),
          TextField(
            controller: confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Confirm new password",
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: updatePassword,
              child: const Text("Update Password"),
            ),
          ),
        ],
      ],
    ),
  );
}

  void updatePassword() {
    if (newPasswordController.text !=
        confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text("Passwords do not match")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content:
              Text("Password Updated Successfully")),
    );

    setState(() {
     bool showChangePassword = false;
      currentPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
    });
  }

 Widget settingsItemTile(
  IconData icon,
  String title, {
  VoidCallback? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: card(
      Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 12),
          Text(title),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    ),
  );
}

  // ================= PHONE EDIT =================

  void editPhoneDialog() {
    TextEditingController controller =
        TextEditingController(text: phoneNumber);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Phone"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.phone,
          decoration:
              const InputDecoration(border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                phoneNumber = controller.text;
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  // ================= HELPERS =================

  IconData getStatusIcon(String status) {
    switch (status) {
      case "Present":
        return Icons.check_circle;
      case "Absent":
        return Icons.cancel;
      case "Permission":
        return Icons.schedule;
      case "OD":
        return Icons.assignment;
      default:
        return Icons.help;
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Present":
        return Colors.green;
      case "Absent":
        return Colors.red;
      case "Permission":
        return Colors.orange;
      case "OD":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  Widget card(Widget child) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: child,
    );
  }

  Widget infoRow(String title, String val) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label(title),
          value(val),
        ],
      ),
    );
  }

  Widget label(String t) {
    return Text(t,
        style: GoogleFonts.inter(
            fontSize: 12,
            color: Colors.grey));
  }

  Widget value(String t) {
    return Text(t,
        style: GoogleFonts.inter(
            fontWeight: FontWeight.w600));
  }
}

////////////////////////////////////////////////////////////
/// PRIVACY POLICY DIALOG
////////////////////////////////////////////////////////////
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
                      onChanged: (v) =>
                          setState(() => notifications = v),
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

