import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'admin_reset_new_screen.dart';
import 'admin_reset_email_screen.dart';

class AdminResetOTPScreen extends StatelessWidget {
  const AdminResetOTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController otpController = TextEditingController();

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
            Text('Administrative Portal',
                style: GoogleFonts.inter(color: Colors.grey[700])),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: _cardStyle(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Verify OTP',
                        style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 6),
                    Text(
                      'Enter the 6-digit code sent to admin@slec.ac.in',
                      style: GoogleFonts.inter(color: Colors.grey[700], fontSize: 13),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: otpController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.verified_outlined),
                        hintText: 'Enter 6-digit OTP',
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
                            MaterialPageRoute(builder: (_) => const AdminResetNewScreen()),
                          );
                        },
                        child: Text('Verify OTP',
                            style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const AdminResetEmailScreen()),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.arrow_back, size: 16),
                              const SizedBox(width: 4),
                              Text('Change Email', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        Text('Resend OTP',
                            style: GoogleFonts.inter(
                                color: Colors.blue[700], fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            _dotIndicator(1),
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
