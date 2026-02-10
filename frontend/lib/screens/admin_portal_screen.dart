import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/auth_service.dart';
import '../../services/user_service.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../services/current_user_service.dart';


import 'management_portal/management_portal_screen.dart';
import 'staff_portal/staff_portal_screen.dart';
import 'hod_portal/hod_portal_screen.dart';
import 'timetable_portal/timetable_portal_screen.dart';
import 'examcell_portal/examcell_portal_screen.dart';
import 'admission_portal/admission_portal_screen.dart';
import 'reset_password/admin_reset_email_screen.dart';

class AdminPortalScreen extends StatefulWidget {
  const AdminPortalScreen({super.key});

  @override
  State<AdminPortalScreen> createState() => _AdminPortalScreenState();
}

class _AdminPortalScreenState extends State<AdminPortalScreen> {
  String? selectedRole;


  bool _isPasswordVisible = false;


  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final roles = ['Management','Principal','Admission','HOD','Staff', 'TimeTable', 'ExamCell'];

  Future<void> _handleLogin() async {
   try {
    if (selectedRole == null ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      throw 'Please fill all fields';
    }

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // 🔐 LOGIN USING EMAIL
    final user = await AuthService().loginWithEmail(
      email: email,
      password: password,
    );

    if (user == null) {
      throw 'Login failed';
    }

    // 🔎 FETCH USER DATA
    final userData =
        await UserService().getUserByUid(user.uid);
        await CurrentUserService.loadUser();


    if (userData == null) {
      throw 'User record not found';
    }

    final actualRole = userData['role'];

    // 🚫 ROLE VALIDATION (IMPORTANT STEP 5)
    if (actualRole.toLowerCase() !=
        selectedRole!.toLowerCase()) {
      throw 'You selected the wrong role';
    }

    // 💾 SAVE SESSION (OPTIONAL)
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userRole', actualRole);

    // 🚀 NAVIGATION
    if (actualRole == 'Staff') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => StaffPortalScreen(
            username: userData['username'] ?? email,
          ),
        ),
      );
    } else if (actualRole == 'HOD') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HODPortalScreen(
            username: userData['username'] ?? email,
          ),
        ),
      );
    } 
    else if (actualRole == 'TimeTable') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => TimetablePortalScreen(
            username: userData['username'] ?? email,
          ),
        ),
      );
    }
    else if (actualRole == 'ExamCell') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ExamCellPortalScreen(
            username: userData['username'] ?? email,
          ),
        ),
      );
    }else if (actualRole == 'Admission') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => AdmissionPortalScreen(
            username: userData['username'] ?? email,
          ),
        ),
      );
    }else if (actualRole == 'Principal') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HODPortalScreen(
            username: userData['username'] ?? email,
          ),
        ),
      );
    }else if (actualRole == 'Management') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ManagementPortalScreen(
            username: userData['username'] ?? email,
          ),
        ),
      );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$actualRole portal coming soon')),
      );
    }
  } catch (e) {
  showErrorPopup(context, e.toString());
}
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: _cardStyle(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select your administrative role to access the system',
                        style: GoogleFonts.inter(color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 16),
                      Text('Administrative Role',
                          style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      _buildDropdown(),
                      const SizedBox(height: 16),
                      Text('Email',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        _buildTextField(
                        controller: emailController,
                       hint: 'Enter your email',
                        icon: Icons.email_outlined,
                      ),

                      const SizedBox(height: 16),
                      Text('Password',style: GoogleFonts.inter(fontWeight: FontWeight.w600),),
                      const SizedBox(height: 6),
                      _buildTextField(
                        controller: passwordController,
                        hint: 'Enter your password',
                        icon: Icons.lock_outline,
                        obscure: true,
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                           context,
                            MaterialPageRoute(
                        builder: (_) => const AdminResetEmailScreen(),),
                          );
                        },
                        child: Text(
                         'Forgot Password?',
                         style: GoogleFonts.inter(
                         fontSize: 14,
                         fontWeight: FontWeight.w600,
                         color: Colors.blue[700],
                          ),
                        ),
                     ),
                  ),
                  const SizedBox(height: 4),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: _handleLogin,
                          child: Text('Access Admin Panel',
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
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

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white10,
            child: Icon(Icons.school_outlined, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 12),
          Text('SLEC Admin Panel',
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          Text('Administrative Access Portal',
              style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13)),
        ],
      ),
    );
  }

 Widget _buildDropdown() {
  return DropdownButtonFormField<String>(
    value: selectedRole,
    items: roles.map((role) {
      return DropdownMenuItem<String>(
        value: role,
        child: Text(
          role,
          style: GoogleFonts.inter(fontWeight: FontWeight.w500),
        ),
      );
    }).toList(),
    onChanged: (val) => setState(() => selectedRole = val),
    icon: const Icon(Icons.keyboard_arrow_down_rounded),
    decoration: InputDecoration(
      prefixIcon: const Icon(Icons.admin_panel_settings_outlined),
      hintText: 'Select your role',
      hintStyle: GoogleFonts.inter(color: Colors.grey[600]),
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding: const EdgeInsets.symmetric(vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
    dropdownColor: Colors.white,
    borderRadius: BorderRadius.circular(14),
    style: GoogleFonts.inter(color: Colors.black),
  );
}

  void showErrorPopup(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ❌ ICON
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 32,
              ),
            ),
            const SizedBox(height: 14),

            // TITLE
            Text(
              'Login Failed',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),

            // MESSAGE
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: Colors.grey[700],
              ),
            ),

            const SizedBox(height: 18),

            // BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text('OK', style: GoogleFonts.inter(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


 Widget _buildTextField({
  required TextEditingController controller,
  required String hint,
  required IconData icon,
  bool obscure = false,
}) {
  return TextField(
    controller: controller,
    obscureText: obscure ? !_isPasswordVisible : false,
    decoration: InputDecoration(
      prefixIcon: Icon(icon),
      hintText: hint,
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),

      // 👁 EYE ICON ONLY FOR PASSWORD
      suffixIcon: obscure
          ? IconButton(
              icon: Icon(
                _isPasswordVisible
                    ? Icons.visibility_outlined 
                   : Icons.visibility_off_outlined,
                color: Colors.grey[700],
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            )
          : null,
    ),
  );
}


  BoxDecoration _cardStyle() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      );

 }