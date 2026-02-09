import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'reset_password/reset_email_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/auth_service.dart';
import '../../services/user_service.dart';
import '../../services/current_user_service.dart';





class StudentLoginScreen extends StatefulWidget {
  const StudentLoginScreen({super.key});


  @override
  State<StudentLoginScreen> createState() => _StudentLoginScreenState();
}
 class _StudentLoginScreenState extends State<StudentLoginScreen> {
  String? selectedRegulation;


  
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();


bool rememberMe = false;
  bool obscurePassword = true;




final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

Future<void> handleStudentLogin() async {
  try {
    if (selectedRegulation == null) {
      throw 'Please select regulation';
    }

    final input = emailController.text.trim();
    final password = passwordController.text.trim();

    if (input.isEmpty || password.isEmpty) {
      throw 'Enter email / roll number and password';
    }

    User? user;

    // 🔹 EMAIL LOGIN
    if (input.contains('@')) {
      user = await _authService.loginWithEmail(
        email: input,
        password: password,
      );
    }
    // 🔹 Email NUMBER LOGIN
    else {
      final data = await _userService.getUserByRoll(input);
      if (data == null) throw 'Invalid EMAIL ID';

      user = await _authService.loginWithEmail(
        email: data['email'],
        password: password,
      );
    }

    if (user == null) throw 'Login failed';

    // 🔹 FETCH USER RECORD
    final userData = await _userService.getUserByUid(user.uid);
    if (userData == null) throw 'User record not found';

    // 🔹 ROLE CHECK
    if (userData['role'] != 'student') {
      throw 'Not a student account';
    }

// 🔒 STATUS CHECK (VERY IMPORTANT)
if (userData['status'] != 'active') {
  await FirebaseAuth.instance.signOut();
  throw 'Your account is not active. Please contact admission office.';
}

    // 🔹 REGULATION CHECK ✅
    if (userData['regulation'] != selectedRegulation) {
      throw 'Invalid regulation selected';
    }

    // 🔹 REMEMBER ME
    final prefs = await SharedPreferences.getInstance();
    if (rememberMe)
     {
      await prefs.setBool('rememberMe', true);
      await prefs.setString('userRole', 'student');
    } else {
      await prefs.clear();
    }

  // ✅ LOAD USER INTO CACHE (VERY IMPORTANT)
await CurrentUserService.loadUser();

// ✅ SUCCESS
Navigator.pushReplacementNamed(context, '/student');



  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.toString())),
    );
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
              _buildLoginCard(context),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }


  // ---------------- HEADER ----------------
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Icon(Icons.school, color: Colors.white, size: 42),
          const SizedBox(height: 12),
          Text(
            'Student Portal',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'ST. Lourdes Engineering College',
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.9),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }


  // ---------------- LOGIN CARD ----------------
  Widget _buildLoginCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---- REGULATION ----
            Text('Regulation *',
                style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: selectedRegulation,
              items: const [
                DropdownMenuItem(value: '2021', child: Text('2021')),
                DropdownMenuItem(value: '2025', child: Text('2025')),
              ],
              onChanged: (value) {
                setState(() => selectedRegulation = value);
              },
              decoration: InputDecoration(
                prefixIcon:
                    Icon(Icons.rule_outlined, color: Colors.grey[700]),
                hintText: 'Select regulation',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ---- EMAIL ----
            Text('Email Address *',
                style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon:
                    Icon(Icons.email_outlined, color: Colors.grey[700]),
                hintText: 'student@slec.ac.in',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),


            const SizedBox(height: 16),

            // ---- PASSWORD ----
            Text('Password *',
                style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            TextField(
              controller: passwordController,
              obscureText: obscurePassword,
              decoration: InputDecoration(
                prefixIcon:
                    Icon(Icons.lock_outline, color: Colors.grey[700]),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey[700],
                  ),
                  onPressed: () =>
                      setState(() => obscurePassword = !obscurePassword),
                ),
                hintText: 'Enter your password',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),


            const SizedBox(height: 8),


            // ---- Remember + Forgot ----
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (v) =>
                          setState(() => rememberMe = v!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Text('Remember me',
                        style: GoogleFonts.inter(
                            fontSize: 13, color: Colors.black87)),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ResetEmailScreen()),
                    );
                  },
                  child: Text(
                    'Forgot password?',
                    style: GoogleFonts.inter(
                      color: Colors.blueAccent,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),


            const SizedBox(height: 10),

            // ---- SIGN IN ----
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: const Color(0xFF8E2DE2),
                ),
                onPressed: handleStudentLogin,
                child: Text('Sign In',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ),
            ),
        ],
        ),
      ),
    );
  }


  // ---------------- FOOTER ----------------
  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        '© 2024 ST. Lourdes Engineering College',
        style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 12),
      ),
    );
  }}


