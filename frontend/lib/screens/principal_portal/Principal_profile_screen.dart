import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalProfileScreen extends StatefulWidget {
  const PrincipalProfileScreen({super.key});

  @override
  State<PrincipalProfileScreen> createState() =>
      _PrincipalProfileScreenState();
}

class _PrincipalProfileScreenState
    extends State<PrincipalProfileScreen> {

  String currentStatus = "Present";

  Color getStatusColor() {
    switch (currentStatus) {
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

  void _showStatusSheet() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              /// Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Update Status",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),

              const SizedBox(height: 15),

              _buildStatusOption("Present", Colors.green),
              _buildStatusOption("Absent", Colors.red),
              _buildStatusOption("Permission", Colors.orange),
              _buildStatusOption("OD", Colors.blue),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildStatusOption(String status, Color color) {
  final isSelected = currentStatus == status;

  return GestureDetector(
    onTap: () {
      setState(() {
        currentStatus = status;
      });
      Navigator.pop(context);
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.black
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: isSelected ? Colors.white : color,
          ),
          const SizedBox(width: 12),
          Text(
            status,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color:
                  isSelected ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 5),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Profile",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            /// 🔷 Gradient Header
            Container(
              height: 120,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0D47A1),
                    Color(0xFF42A5F5)
                  ],
                ),
              ),
            ),

            /// 👤 PROFILE CARD
            Transform.translate(
              offset: const Offset(0, -90),
              child: Column(
                children: [

                  Container(
                    padding: const EdgeInsets.all(20),
                    width:
                        MediaQuery.of(context).size.width *
                            0.92,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.1),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [

                        /// ⚙️ Settings
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
  icon: const Icon(Icons.settings_outlined),
  onPressed: () {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) => const _SettingsDialog(),
    );
  },
),
                        ),

                        const CircleAvatar(
                          radius: 28,
                          backgroundColor:
                              Color(0xFFE3F2FD),
                          child: Icon(
                            Icons.person,
                            size: 28,
                            color: Colors.blue,
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          "Dr. Rajesh Kumar",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        const Text(
                          "Principal",
                          style: TextStyle(
                              color: Colors.grey),
                        ),

                        const SizedBox(height: 12),

                        /// 🔥 CLICKABLE STATUS BAR
                        GestureDetector(
                          onTap: _showStatusSheet,
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 10),
                            decoration: BoxDecoration(
                              color: getStatusColor()
                                  .withOpacity(0.15),
                              borderRadius:
                                  BorderRadius.circular(25),
                            ),
                            child: Row(
                              mainAxisSize:
                                  MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 12,
                                  color:
                                      getStatusColor(),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  currentStatus,
                                  style: TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                    color:
                                        getStatusColor(),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Icon(
                                  Icons
                                      .keyboard_arrow_down,
                                  size: 18,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// 📊 QUICK STATS
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: const [
                      _StatCard(
                          title: "15+",
                          value:
                              "Years Experience"),
                      SizedBox(width: 15),
                      _StatCard(
                          title: "8",
                          value: "Departments"),
                    ],
                  ),

                  const SizedBox(height: 25),

                  /// 📋 CONTACT SECTION
                  _infoSection("Contact Information", [
                    _infoTile(Icons.email, "Email",
                        "principal@college.edu"),
                    _infoTile(Icons.phone, "Phone",
                        "+91 9876543210"),
                    _infoTile(Icons.location_on, "Office",
                        "Main Block, First Floor"),
                  ]),

                  /// 🏢 ADMIN DETAILS
                  _infoSection("Administrative Details", [
                    _infoTile(Icons.apartment,
                        "Department", "Administration"),
                    _infoTile(Icons.school,
                        "Qualification",
                        "Ph.D in Computer Science"),
                    _infoTile(Icons.date_range,
                        "Joined", "12-06-2015"),
                  ]),

                  const SizedBox(height: 20),

                 /// 🚪 LOGOUT
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
      side: const BorderSide(
        color: Colors.black,  // 🔹 Border color
        width: 1.2,           // 🔹 Border thickness
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20,),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    onPressed: () {},
  ),
),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _infoSection(
      String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(0.05),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  static Widget _infoTile(
      IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style:
                  const TextStyle(color: Colors.grey),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatCard(
      {required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            textAlign: TextAlign.center,
            style:
                const TextStyle(color: Colors.grey),
          ),
        ],
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
   void _showCenterSuccess() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  size: 60,
                  color: Colors.green,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Password Updated Successfully",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context); // close popup
                    },
                    child: const Text("OK"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
                    ),Transform.scale(
  scale: 0.8, 
              child :  Switch(
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
                            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                            foregroundColor: const Color.fromARGB(255, 255, 255, 255), 
                            padding:
                                const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                                
                          ),
onPressed: () {
  _showCenterSuccess();
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
Widget _label(String text) => Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
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