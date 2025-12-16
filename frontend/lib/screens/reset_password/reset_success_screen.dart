import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../student_login_screen.dart';
import '../student_portal/student_portal_screen.dart';

class ResetSuccessScreen extends StatelessWidget {
  const ResetSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const StudentLoginScreen()),
        (route) => false,
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const CircleAvatar(
              radius: 28,
              backgroundColor: Colors.blue,
              child: Icon(Icons.lock_outline, color: Colors.white, size: 28),
            ),
            const SizedBox(height: 12),
            Text('Reset Password',
                style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('Student Portal',
                style: GoogleFonts.inter(color: Colors.grey[700])),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: _cardStyle(),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundColor: Color(0xFFE8F5E9),
                      child: Icon(Icons.check_circle,
                          color: Colors.green, size: 38),
                    ),
                    const SizedBox(height: 16),
                    Text('Password Reset Successful!',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 6),
                    Text('Your password has been updated successfully.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(color: Colors.grey[700])),
                    const SizedBox(height: 10),
                    Text('Redirecting to login page...',
                        style: GoogleFonts.inter(color: Colors.grey[600])),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: _btnStyle(),
                        onPressed: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const StudentLoginScreen()),
                          (route) => false,
                        ),
                        child: Text('Go to Login',
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
    );
  }

  BoxDecoration _cardStyle() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3))
        ],
      );

  ButtonStyle _btnStyle() => ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      );
}
