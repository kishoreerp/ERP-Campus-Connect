import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/otp_service.dart';
import 'reset_new_screen.dart';

class ResetOTPScreen extends StatefulWidget {
  final String email;

  const ResetOTPScreen({super.key, required this.email});

  @override
  State<ResetOTPScreen> createState() => _ResetOTPScreenState();
  
}

class _ResetOTPScreenState extends State<ResetOTPScreen> {
  final TextEditingController otpController = TextEditingController();
  final OtpService _otpService = OtpService();
  

  bool isLoading = false;

  Future<void> handleVerifyOtp() async {
    try {
      final otp = otpController.text.trim();

      if (otp.length != 6) {
        throw 'Enter valid 6-digit OTP';
      }

      setState(() => isLoading = true);

      await _otpService.verifyOtp(
        email: widget.email,
        enteredOtp: otp,
      );

      // ✅ OTP VERIFIED → RESET PASSWORD
     Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (_) => ResetNewScreen(email: widget.email),
  ),
);

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }
  Future<void> resendOtp(BuildContext context, String email) async {
  try {
    setState(() => isLoading = true);

    final otp = _otpService.generateOtp();

    await _otpService.saveOtp(
      email: email,
      otp: otp,
    );

    await _otpService.sendOtpEmail(
      email: email,
      otp: otp,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('New OTP sent to your email')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.toString())),
    );
  } finally {
    setState(() => isLoading = false);
  }
}


  @override
  Widget build(BuildContext context) 
  {
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
                        'Enter the 6-digit code sent to ${widget.email}',
                        style: GoogleFonts.inter(
                            color: Colors.grey[700], fontSize: 13),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
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
                          onPressed: isLoading ? null : handleVerifyOtp,
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : Text('Verify OTP',
                                  style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
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
  onPressed: () => resendOtp(context, widget.email),
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
            child:
                const Icon(Icons.lock_outline, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 14),
          Text('Reset Password',
              style:
                  GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18)),
          Text('Student Portal',
              style: GoogleFonts.inter(color: Colors.grey[700])),
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
              color:
                  index == activeIndex ? Colors.blueAccent : Colors.grey[300],
            ),
          ),
        ),
      );
}


