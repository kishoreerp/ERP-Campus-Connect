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


  // ================= STATUS COLOR =================


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


  // ================= LOGOUT =================


  void _confirmLogout() {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.logout,
              size: 40,
              color: Colors.black,
            ),
            const SizedBox(height: 16),
            Text(
              "Logout",
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Are you sure you want to logout?",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 24),


            /// Buttons Row
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.black),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/login",
                        (route) => false,
                      );
                    },
                    child: const Text("Logout"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}


  // ================= STATUS DIALOG =================


  void _showStatusDialog() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Update Status",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              _statusOption("Present", Colors.green),
              _statusOption("Absent", Colors.red),
              _statusOption("Permission", Colors.orange),
              _statusOption("OD", Colors.blue),
            ],
          ),
        ),
      ),
    );
  }


  Widget _statusOption(String status, Color color) {
    final selected = currentStatus == status;


    return GestureDetector(
      onTap: () {
        setState(() => currentStatus = status);
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(
  horizontal: 14,
  vertical: 7,
),
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(Icons.check_circle,
                color: selected ? Colors.white : color),
            const SizedBox(width: 12),
            Text(
              status,
              style: TextStyle(
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


  // ================= UI =================


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [


              /// HEADER
              Container(
                height: 150,
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


              Transform.translate(
                offset: const Offset(0, -100),
                child: Column(
                  children: [


                    /// PROFILE CARD
                    Container(
                      width: MediaQuery.of(context)
                              .size
                              .width *
                          0.9,
                      padding: const EdgeInsets.symmetric(
                       horizontal: 18,
                       vertical: 12,
                        ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.08),
                            blurRadius: 20,
                          )
                        ],
                      ),
                      child: Column(
                        children: [


                          /// SETTINGS
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: const Icon(
                                  Icons.settings_outlined),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) =>
                                      const _SettingsDialog(),
                                );
                              },
                            ),
                          ),


                          const CircleAvatar(
                            radius: 30,
                            backgroundColor:
                                Color(0xFFE3F2FD),
                            child: Icon(Icons.person,
                                size: 28,
                                color: Colors.blue),
                          ),


                          const SizedBox(height: 10),


                          Text(
  "Dr. Rajesh Kumar",
  style: GoogleFonts.inter(
    fontSize: 17,   // reduced
    fontWeight: FontWeight.w600,
  ),
),


const SizedBox(height: 3),


Text(
  "Principal",
  style: GoogleFonts.inter(
    fontSize: 13,
    color: Colors.grey.shade600,
  ),
),


const SizedBox(height: 2),


Text(
  "ABC Engineering College",
  style: GoogleFonts.inter(
    fontSize: 12.5,
    color: Colors.grey.shade500,
  ),
),


const SizedBox(height: 2),


Text(
  "Ph.D in Computer Science",   // ✅ Qualification added
  style: GoogleFonts.inter(
    fontSize: 12,
    color: Colors.grey.shade500,
  ),
),
                          /// STATUS
                          GestureDetector(
                            onTap: _showStatusDialog,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 18,
                                      vertical: 10),
                              decoration: BoxDecoration(
                                color: getStatusColor()
                                    .withOpacity(0.12),
                                borderRadius:
                                    BorderRadius.circular(
                                        25),
                              ),
                              child: Row(
                                mainAxisSize:
                                    MainAxisSize.min,
                                children: [
                                  Icon(Icons.circle,
                                      size: 10,
                                      color:
                                          getStatusColor()),
                                  const SizedBox(width: 8),
                                  Text(
                                    currentStatus,
                                    style: TextStyle(
                                        fontWeight:
                                            FontWeight.bold,
                                        color:
                                            getStatusColor()),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),


                   


                    /// EXPERIENCE CARD (Departments removed)
                    Container(
  margin: const EdgeInsets.only(top: 16),
  padding: const EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 10,
  ),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(30),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
      )
    ],
  ),
  child: Text(
    "15+ Years Experience",
    style: GoogleFonts.inter(
      fontWeight: FontWeight.w600,
      fontSize: 13,
    ),
  ),
),
const SizedBox(height: 10),
                    /// CONTACT
                    _sectionCard(
                      title: "Contact Information",
                      children: [
                        _infoTile(Icons.email,
                            "principal@college.edu"),
                        _infoTile(Icons.phone,
                            "+91 9876543210"),
                        _infoTile(Icons.location_on,
                            "Main Block, First Floor"),
                      ],
                    ),


                    const SizedBox(height: 20),


                    /// LOGOUT
                    SizedBox(
  width: MediaQuery.of(context).size.width * 0.9,
  child: OutlinedButton.icon(
    icon: const Icon(Icons.logout_outlined),
    label: const Text("Logout"),
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.black,
      side: const BorderSide(color: Colors.black),
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ).copyWith(
      overlayColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.black.withOpacity(0.08);
          }
          return null;
        },
      ),
    ),
    onPressed: _confirmLogout,
  ),
),


                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }




  // ================= REUSABLE WIDGETS =================


  static Widget _statCard(String text) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
          )
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }


  static Widget _sectionCard(
      {required String title,
      required List<Widget> children}) {
    return Container(
      margin:
          const EdgeInsets.symmetric(horizontal: 20),
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
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }


  static Widget _infoTile(
      IconData icon, String value) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
// ===================================================================
// ================= UPDATED ELEGANT SETTINGS DIALOG =================
// ===================================================================


class _SettingsDialog extends StatefulWidget {
  const _SettingsDialog();


  @override
  State<_SettingsDialog> createState() => _SettingsDialogState();
}


class _SettingsDialogState extends State<_SettingsDialog> {
  bool notifications = false;
  bool showChangePassword = false;


  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white, // more white
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 22, vertical: 70),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [


              /// HEADER
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Settings",
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Manage your account preferences",
                        style: GoogleFonts.inter(
                          fontSize: 12.5,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () =>
                        Navigator.pop(context),
                  )
                ],
              ),


              const SizedBox(height: 22),


              /// PUSH NOTIFICATIONS
              _card(
                child: Row(
                  children: [
                    _iconBox(Icons.notifications_outlined,
                        Colors.blue),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        "Push Notifications",
                        style: GoogleFonts.inter(
                            fontWeight:
                                FontWeight.w600),
                      ),
                    ),


                    /// Smaller & visible switch
                    Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: notifications,
                        activeColor: Colors.black,
                        activeTrackColor:
                            Colors.black.withOpacity(0.35),
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor:
                            Colors.grey.shade400,
                        onChanged: (v) {
                          setState(() {
                            notifications = v;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),


              const SizedBox(height: 16),


              /// CHANGE PASSWORD
              _card(
                child: Column(
                  children: [
                    InkWell(
                      borderRadius:
                          BorderRadius.circular(14),
                      onTap: () {
                        setState(() {
                          showChangePassword =
                              !showChangePassword;
                        });
                      },
                      child: Row(
                        children: [
                          _iconBox(Icons.lock_outline,
                              Colors.green),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              "Change Password",
                              style:
                                  GoogleFonts.inter(
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
                          ),
                          Icon(
                            showChangePassword
                                ? Icons.keyboard_arrow_up
                                : Icons
                                    .keyboard_arrow_down,
                            size: 20,
                          )
                        ],
                      ),
                    ),


                    if (showChangePassword) ...[
                      const SizedBox(height: 14),


                      _smallInput("Current Password"),
                      const SizedBox(height: 8),


                      _smallInput("New Password"),
                      const SizedBox(height: 8),


                      _smallInput("Confirm Password"),


                      const SizedBox(height: 16),


                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.black,
                            foregroundColor:
                                Colors.white,
                            padding:
                                const EdgeInsets
                                    .symmetric(
                                        vertical: 12),
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                              "Update Password"),
                        ),
                      ),
                    ]
                  ],
                ),
              ),


              const SizedBox(height: 16),


              /// TERMS
             _card(
  child: InkWell(
    borderRadius: BorderRadius.circular(14),
    onTap: () {
      showDialog(
        context: context,
        builder: (_) => const _PolicyDialog(
          title: "Terms & Conditions",
          content:
              "1. Acceptance of Terms\n\n"
              "By accessing this portal, you agree to comply with institutional policies.\n\n"
              "2. Professional Conduct\n\n"
              "The system must be used strictly for official purposes.\n\n"
              "3. Account Responsibility\n\n"
              "You are responsible for safeguarding your login credentials.",
        ),
      );
    },
    child: Row(
      children: [
        _iconBox(Icons.description_outlined, Colors.purple),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            "Terms & Conditions",
            style: GoogleFonts.inter(fontWeight: FontWeight.w600),
          ),
        ),
        const Icon(Icons.chevron_right, size: 20),
      ],
    ),
  ),
),
              const SizedBox(height: 12),


              /// PRIVACY
            _card(
  child: InkWell(
    borderRadius: BorderRadius.circular(14),
    onTap: () {
      showDialog(
        context: context,
        builder: (_) => const _PolicyDialog(
          title: "Privacy Policy",
          content:
              "1. Information Collection\n\n"
              "We collect only necessary professional and account information.\n\n"
              "2. Data Protection\n\n"
              "Your data is stored securely and protected against unauthorized access.\n\n"
              "3. Confidentiality\n\n"
              "Your information will never be shared without permission.",
        ),
      );
    },
    child: Row(
      children: [
        _iconBox(Icons.privacy_tip_outlined, Colors.orange),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            "Privacy Policy",
            style: GoogleFonts.inter(fontWeight: FontWeight.w600),
          ),
        ),
        const Icon(Icons.chevron_right, size: 20),
      ],
    ),
  ),
),
            ],
          ),
        ),
      ),
    );
  }


  // ================= REUSABLE =================


  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: child,
    );
  }


  Widget _iconBox(IconData icon, Color color) {
    return Container(
      height: 38,
      width: 38,
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius:
            BorderRadius.circular(10),
      ),
      child: Icon(icon,
          color: color,
          size: 20),
    );
  }


  Widget _smallInput(String hint) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
            fontSize: 13),
        filled: true,
        fillColor: Colors.grey.shade200,
        contentPadding:
            const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12),
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
// =====================================================
// =============== POLICY DIALOG ========================
// =====================================================


class _PolicyDialog extends StatelessWidget {
  final String title;
  final String content;


  const _PolicyDialog({
    required this.title,
    required this.content,
  });


  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFF8F9FB),
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () =>
                      Navigator.pop(context),
                )
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  content,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    height: 1.6,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}