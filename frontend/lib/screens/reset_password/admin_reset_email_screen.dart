import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'admin_reset_otp_screen.dart';

class AdminResetEmailScreen extends StatelessWidget {
  const AdminResetEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: _cardStyle(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Enter Your Email',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 6),
                    Text(
                        "We'll send you a verification code to reset your password",
                        style: GoogleFonts.inter(
                            color: Colors.grey[700], fontSize: 13)),
                    const SizedBox(height: 16),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email_outlined),
                        hintText: 'Enter your email',
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
                        style: _btnStyle(),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const AdminResetOTPScreen()),
                          );
                        },
                        child: Text('Send OTP',
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_back, size: 16),
                          const SizedBox(width: 4),
                          Text('Back to Login',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            _dotIndicator(0),
          ],
        ),
      ),
    );
  }

  Widget _header() => Column(
        children: [
          const SizedBox(height: 40),
          const CircleAvatar(
              radius: 28,
              backgroundColor: Colors.blue,
              child:
                  Icon(Icons.lock_outline, color: Colors.white, size: 28)),
          const SizedBox(height: 12),
          Text('Reset Password',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold, fontSize: 18)),
          Text('Administrative Portal',
              style: GoogleFonts.inter(color: Colors.grey[700])),
        ],
      );

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
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      );

  Widget _dotIndicator(int index) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          3,
          (i) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: i == index ? Colors.blueAccent : Colors.grey[300],
            ),
          ),
        ),
      );
}
