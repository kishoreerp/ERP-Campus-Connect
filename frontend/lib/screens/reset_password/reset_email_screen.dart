import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/otp_service.dart';
import 'reset_otp_screen.dart';

class ResetEmailScreen extends StatelessWidget {
  const ResetEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final OtpService otpService = OtpService();

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
                      Text(
                        'Enter Your Email',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "We'll send you a verification code to reset your password",
                        style: GoogleFonts.inter(
                          color: Colors.grey[700],
                          fontSize: 13,
                        ),
                      ),
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
                          style: _buttonStyle(),
                          onPressed: () async {
                            try {
                              final email =
                                  emailController.text.trim();

                              if (email.isEmpty) {
                                throw 'Enter email address';
                              }

                              final otp = otpService.generateOtp();

                              await otpService.saveOtp(
                                email: email,
                                otp: otp,
                              );

                              await otpService.sendOtpEmail(
                                email: email,
                                otp: otp,
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('OTP sent to your email'),
                                ),
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ResetOTPScreen(email: email),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.toString()),
                                ),
                              );
                            }
                          },
                          child: Text(
                            'Send OTP',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_back, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              'Back to Login',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
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
