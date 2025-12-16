import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'reset_new_screen.dart';

class ResetOTPScreen extends StatelessWidget {
  const ResetOTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController otpController = TextEditingController();

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
                      Text('Verify OTP',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 6),
                      Text(
                        'Enter the 6-digit code sent to your email',
                        style: GoogleFonts.inter(color: Colors.grey[700], fontSize: 13),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: otpController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.key_outlined),
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
                          style: _buttonStyle(),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const ResetNewScreen()),
                            );
                          },
                          child: Text('Verify OTP',
                              style: GoogleFonts.inter(
                                  color: Colors.white, fontWeight: FontWeight.w600)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('← Change Email'),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Resend OTP'),
                          ),
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
            child: const Icon(Icons.lock_outline, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 14),
          Text('Reset Password',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18)),
          Text('Student Portal', style: GoogleFonts.inter(color: Colors.grey[700])),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
              color: index == activeIndex ? Colors.blueAccent : Colors.grey[300],
            ),
          ),
        ),
      );
}
