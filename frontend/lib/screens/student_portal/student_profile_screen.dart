import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ---------------- MAIN PROFILE SCREEN ----------------
class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  // 🔹 Student data variables (Step 2)
String name = '';
String rollNumber = '';
String email = '';
String department = '';
String year = '';
String cgpa = '';
String attendance = '';
String semester = '';
int subjects = 0;
int arrears = 0;
String phone = '';
String address = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              _buildProfileCard(),
              const SizedBox(height: 20),
              _buildContactCard(),
              const SizedBox(height: 20),
              _buildLogoutSection(context),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _loadStudentProfile() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final doc = await FirebaseFirestore.instance
      .collection('students')
      .doc(user.uid)
      .get();

  final data = doc.data();
  if (data == null) return;

  setState(() {
    name = data['name'] ?? '';
    rollNumber = data['rollNumber'] ?? '';
    email = data['email'] ?? '';
    department = data['department'] ?? '';
    year = data['year'] ?? '';
    cgpa = data['cgpa'] ?? '';
    attendance = data['attendance'] ?? '';
    semester = data['semester'] ?? '';
    subjects = data['subjects'] ?? 0;
    arrears = data['arrears'] ?? 0;
    phone = data['phone'] ?? '';
    address = data['address'] ?? '';
  });
}


  // ---------------- HEADER ----------------
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/slec_logo.png',
              height: 38,
              width: 38,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.school, color: Colors.deepPurple),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Student Portal',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Text('Computer Science Engineering',
                    style: GoogleFonts.inter(
                        fontSize: 12, color: Colors.grey[700])),
              ],
            ),
          ],
        ),
        GestureDetector(
          onTap: () => _showSettingsDialog(context),
          child: const Icon(Icons.settings_outlined, color: Colors.grey),
        ),
      ],
    );
  }

  // ---------------- PROFILE CARD ----------------
  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _whiteBox(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.deepPurple.shade100,
                child: Text('PD',
                    style: GoogleFonts.inter(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Kishore Kumar',
                      style: GoogleFonts.inter(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('211222104010',
                      style: GoogleFonts.inter(
                          fontSize: 13, color: Colors.grey[700])),
                  Text('Computer Science Engineering\nFinal Year',
                      style: GoogleFonts.inter(
                          fontSize: 13, color: Colors.grey[700])),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _infoBox('8.9', 'CGPA', Colors.blue.shade50),
              const SizedBox(width: 8),
              _infoBox('93%', 'Attendance', Colors.green.shade50),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _infoBox('Sem 7', 'Semester', Colors.purple.shade50),
              const SizedBox(width: 8),
              _infoBox('4', 'Subjects', Colors.orange.shade50),
              const SizedBox(width: 8),
              _infoBox('0', 'Arrears', Colors.red.shade50),
            ],
          ),
        ],
      ),
    );
  }
}
  Widget _infoBox(String value, String label, Color bgColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(value,
                style: GoogleFonts.inter(
                    fontSize: 16, fontWeight: FontWeight.bold)),
            Text(label,
                style:
                    GoogleFonts.inter(fontSize: 12, color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }

  // ---------------- CONTACT CARD ----------------
  Widget _buildContactCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _whiteBox(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _contactRow(Icons.email_outlined, 'Kishore1kumar4@gmail.com'),
          const SizedBox(height: 10),
          _contactRow(Icons.phone_outlined, '+91 8668088234'),
          const SizedBox(height: 10),
          _contactRow(Icons.computer_outlined, 'Computer Science Engineering'),
          const SizedBox(height: 10),
          _contactRow(Icons.location_on_outlined, 'Anagaputhur, Chennai'),
        ],
      ),
    );
  }

  Widget _contactRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.deepPurple, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style:
                  GoogleFonts.inter(fontSize: 13, color: Colors.grey[800])),
        ),
      ],
    );
  }

  // ---------------- LOGOUT SECTION ----------------
Widget _buildLogoutSection(BuildContext context) {
  return Column(
    children: [
      const SizedBox(height: 20),
      SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.logout_outlined, color: Colors.black87, size: 20),
          label: Text(
            'Logout',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              fontSize: 14.5,
            ),
          ),
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            side: BorderSide(color: Colors.grey.shade300),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    ],
  );
}

  // ---------------- WHITE BOX DECORATION ----------------
BoxDecoration _whiteBox() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 6,
        offset: const Offset(0, 3),
      ),
    ],
  );
 }
// ---------------- SETTINGS POPUP ----------------
void _showSettingsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => const _SettingsDialog(),
  );
}

class _SettingsDialog extends StatefulWidget {
  const _SettingsDialog();

  @override
  State<_SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<_SettingsDialog> {
  bool _notificationsEnabled = true;
  bool _showChangePassword = false;

  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPref();
  }

  Future<void> _loadPref() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    });
  }

  Future<void> _savePref(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', value);
    setState(() => _notificationsEnabled = value);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Settings',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold, fontSize: 18)),
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: Colors.black54)),
              ],
            ),
            const SizedBox(height: 6),
            Text('Manage your account settings and preferences',
                style: GoogleFonts.inter(color: Colors.grey[700], fontSize: 13)),
            const SizedBox(height: 20),

            // Notifications switch
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.notifications_outlined,
                          color: Colors.deepPurple),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Notifications",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600, fontSize: 13)),
                          Text("Enable push notifications",
                              style: GoogleFonts.inter(
                                  color: Colors.grey[700], fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  Switch(
                    value: _notificationsEnabled,
                    activeColor: Colors.deepPurple,
                    inactiveThumbColor: Colors.grey.shade400,
                    inactiveTrackColor: Colors.grey.shade300,
                    onChanged: (v) => _savePref(v),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),
  

// ---------------- CHANGE PASSWORD SECTION ----------------
GestureDetector(
  onTap: () {
    setState(() {
      _showChangePassword = !_showChangePassword;
    });
  },
  child: AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.lock_outline, color: Colors.green, size: 22),
                const SizedBox(width: 10),
                Text("Change Password",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600, fontSize: 13)),
              ],
            ),
            if (_showChangePassword)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showChangePassword = false;
                  });
                },
                child: Text(
                  "Cancel",
                  style: GoogleFonts.inter(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w600,
                      fontSize: 13),
                ),
              ),
          ],
        ),

        if (!_showChangePassword)
          Padding(
            padding: const EdgeInsets.only(left: 32, top: 4),
            child: Text("Update your account password",
                style: GoogleFonts.inter(
                    color: Colors.grey[700], fontSize: 12)),
          ),

        if (_showChangePassword) const SizedBox(height: 14),

        // Password Fields (only when expanded)
        if (_showChangePassword) ...[
          _textField("Current Password", "Enter current password",
              _currentController),
          const SizedBox(height: 10),
          _textField("New Password", "Enter new password", _newController),
          const SizedBox(height: 10),
          _textField("Confirm Password", "Confirm new password",
              _confirmController),
          const SizedBox(height: 14),

          // Update Password Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _updatePasswordUI,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text("Update Password",
                  style: GoogleFonts.inter(
                      color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ],
    ),
  ),
),

            // Terms & Privacy Buttons
      _settingsButton(context, Icons.description_outlined, Colors.purple,
        'Terms and Conditions', 'Read our terms of service'),
            const SizedBox(height: 10),
      _settingsButton(context, Icons.privacy_tip_outlined, Colors.orange,
        'Privacy Policy', 'Learn how we protect your data'),

            const SizedBox(height: 26),
            Center(
              child: Text(
                'SLEC Campus Connect v1.0.0\n© 2025 St. Lourdes Engineering College',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontSize: 11, color: Colors.grey[600]),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _textField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.inter(
                fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                GoogleFonts.inter(color: Colors.grey[500], fontSize: 13),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
      ],
    );
  }

  // ✅ Show popup after successful password update
  void _updatePasswordUI() {
    if (_newController.text.isEmpty ||
        _confirmController.text.isEmpty ||
        _currentController.text.isEmpty) {
      _showPopupDialog("Please fill all fields!", false);
      return;
    }
    if (_newController.text != _confirmController.text) {
      _showPopupDialog("Passwords do not match!", false);
      return;
    }
    _showPopupDialog("Password updated successfully!", true);
    setState(() {
      _showChangePassword = false;
      _currentController.clear();
      _newController.clear();
      _confirmController.clear();
    });
  }

  void _showPopupDialog(String message, bool success) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  success ? Icons.check_circle : Icons.error_outline,
                  color: success ? Colors.green : Colors.redAccent,
                  size: 50,
                ),
                const SizedBox(height: 10),
                Text(message,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  ),
                  child: const Text("OK",
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

// ---------------- SETTINGS BUTTON WITH BOTTOM SHEET ----------------
Widget _settingsButton(BuildContext context,
  IconData icon, Color color, String title, String subtitle) {
  return InkWell(
    onTap: () {
      if (title == 'Terms and Conditions') {
        _showBottomInfoSheet(context,
          title: 'Terms and Conditions',
          content:
              'By using this application, you agree to comply with all college rules and regulations. Unauthorized use, sharing of credentials, or any activity that violates academic integrity is strictly prohibited.\n\nWe reserve the right to modify or update these terms at any time. Continued use of the platform after such changes constitutes acceptance of the new terms.',
        );
      } else if (title == 'Privacy Policy') {
        _showBottomInfoSheet(context,
          title: 'Privacy Policy',
          content:
              'We respect your privacy. The data collected through this platform is used solely for academic and administrative purposes. We do not share your personal data with any third party without your consent.\n\nYou can contact the college administration if you wish to review, correct, or delete your stored information.',
        );
      }
    },
    borderRadius: BorderRadius.circular(12),
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600, fontSize: 13)),
                Text(subtitle,
                    style: GoogleFonts.inter(
                        color: Colors.grey[700], fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    ),
  );
}

// ---------------- BOTTOM SHEET INFO VIEW ----------------
void _showBottomInfoSheet(BuildContext context,
    {required String title, required String content}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),

              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: GoogleFonts.inter(
                          fontSize: 17, fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: Colors.black54),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Scrollable text area
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 350),
                child: SingleChildScrollView(
                  child: Text(
                    content,
                    style: GoogleFonts.inter(
                      color: Colors.grey[800],
                      fontSize: 13.5,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Close button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text('Close',
                      style: GoogleFonts.inter(
                          color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
} //<-- closes _showBottomInfoSheet method

}