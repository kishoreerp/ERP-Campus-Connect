import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'reset_password/reset_email_screen.dart';
import 'student_portal/student_portal_screen.dart';


class StudentLoginScreen extends StatefulWidget {
  const StudentLoginScreen({super.key});


  @override
  State<StudentLoginScreen> createState() => _StudentLoginScreenState(); // ✅ correct
}


class _StudentLoginScreenState extends State<StudentLoginScreen> {
  bool useEmail = false;
  bool rememberMe = false;
  bool obscurePassword = true;


  final TextEditingController rollController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


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
            // ---- Toggle Buttons ----
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => useEmail = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: !useEmail ? Colors.black : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Roll Number',
                            style: GoogleFonts.inter(
                              color: !useEmail ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => useEmail = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: useEmail ? Colors.black : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Email',
                            style: GoogleFonts.inter(
                              color: useEmail ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),


            const SizedBox(height: 20),


            // ---- Roll or Email Field ----
            Text(
              useEmail ? 'Email Address *' : 'Roll Number *',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: useEmail ? emailController : rollController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  useEmail ? Icons.email_outlined : Icons.person_outline,
                  color: Colors.grey[700],
                ),
                hintText: useEmail ? 'student@slec.ac.in' : 'roll number',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),


            const SizedBox(height: 16),


            // ---- Password ----
            Text('Password *', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            TextField(
              controller: passwordController,
              obscureText: obscurePassword,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[700]),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey[700],
                  ),
                  onPressed: () => setState(() => obscurePassword = !obscurePassword),
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
                      onChanged: (v) => setState(() => rememberMe = v!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Text('Remember me',
                        style: GoogleFonts.inter(fontSize: 13, color: Colors.black87)),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ResetEmailScreen()),
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


            // ---- Sign In Button ----
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: const Color(0xFF8E2DE2),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StudentPortalScreen( ),
                    ),
                  );
                },
                child: Text('Sign In',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),


            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }


  // ---------------- FOOTER ----------------
  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: Text(
              'Having trouble logging in? Contact IT Support',
              style: GoogleFonts.inter(
                color: Colors.blueAccent,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '© 2024 ST. Lourdes Engineering College',
            style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 12),
          ),
        ],
      ),
    );
  }
}





