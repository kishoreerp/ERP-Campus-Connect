import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'reset_success_screen.dart';
import 'package:http/http.dart' as http;


class ResetNewScreen extends StatelessWidget {
  final String email; // ✅ REQUIRED

  const ResetNewScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final TextEditingController pass1 = TextEditingController();
    final TextEditingController pass2 = TextEditingController();

    Future<void> handleReset() async {
  try {
    final p1 = pass1.text.trim();
    final p2 = pass2.text.trim();

    if (p1.length < 6) {
      throw 'Password must be at least 6 characters';
    }

    if (p1 != p2) {
      throw 'Passwords do not match';
    }

    // ✅ CALL YOUR BACKEND – OTP BASED UPDATE
    await http.post(
      Uri.parse("https://YOUR_BACKEND_URL/student/reset-password"),
      headers: {'Content-Type': 'application/json'},
      body: '''
      {
        "email": "$email",
        "password": "$p1"
      }
      ''',
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ResetSuccessScreen()),
    );

  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.toString())),
    );
  }
}

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: _boxStyle(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Create New Password',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 6),
                      Text(
                        'Choose a strong password for your account',
                        style: GoogleFonts.inter(
                            color: Colors.grey[700], fontSize: 13),
                      ),
                      const SizedBox(height: 16),

                      // NEW PASSWORD
                      TextField(
                        controller: pass1,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline),
                          hintText: 'Enter new password',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // CONFIRM PASSWORD
                      TextField(
                        controller: pass2,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline),
                          hintText: 'Confirm new password',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: _buttonStyle(),
                          onPressed: () async {
                            try {
                                   final p1 = pass1.text.trim();
                                   final p2 = pass2.text.trim();

                                     if (p1.length < 6) {
      throw 'Password must be at least 6 characters';
    }

    if (p1 != p2) {
      throw 'Passwords do not match';
    }

    // ✅ FIREBASE SECURE PASSWORD RESET
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: email,
    );

    // ✅ SUCCESS
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const ResetSuccessScreen(),
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
  }
},
                          child: Text(
                            'Reset Password',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _dotIndicator(2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() => Column(
        children: [
          const SizedBox(height: 40),
          Container(
            height: 56,
            width: 56,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child:
                const Icon(Icons.lock_outline, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 14),
          Text(
            'Reset Password',
            style:
                GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            'Student Portal',
            style: GoogleFonts.inter(color: Colors.grey[700]),
          ),
          const SizedBox(height: 20),
        ],
      );

  BoxDecoration _boxStyle() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      );

  ButtonStyle _buttonStyle() => ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );

  Widget _dotIndicator(int activeIndex) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          3,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  index == activeIndex ? Colors.blueAccent : Colors.grey[300],
            ),
          ),
        ),
      );
}
