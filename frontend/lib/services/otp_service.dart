import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class OtpService {
  final _db = FirebaseFirestore.instance;

  // 🔢 Generate 6-digit OTP
  String generateOtp() {
    final random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  // 💾 Save OTP in Firestore
  Future<void> saveOtp({
    required String email,
    required String otp,
  }) async {
    await _db.collection('email_otps').doc(email).set({
      'email': email,
      'otp': otp,
      'verified': false,
      'expiresAt': Timestamp.fromDate(
        DateTime.now().add(const Duration(minutes: 5)),
      ),
    });
  }

  // 📩 SEND OTP EMAIL (BACKEND CALL)
  Future<void> sendOtpEmail({
    required String email,
    required String otp,
  }) async {
    final url = Uri.parse(
      'https://YOUR_BACKEND_URL/send-otp', // 👈 replace later
    );

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: '''
      {
        "email": "$email",
        "otp": "$otp"
      }
      ''',
    );

    if (response.statusCode != 200) {
      throw 'Failed to send OTP email';
    }
  }

  // ✅ VERIFY OTP
  Future<void> verifyOtp({
    required String email,
    required String enteredOtp,
  }) async {
    final doc = await _db.collection('email_otps').doc(email).get();

    if (!doc.exists) throw 'OTP not found';

    final data = doc.data()!;
    final expiresAt = (data['expiresAt'] as Timestamp).toDate();

    if (DateTime.now().isAfter(expiresAt)) {
      throw 'OTP expired';
    }

    if (data['otp'] != enteredOtp) {
      throw 'Invalid OTP';
    }

    await _db.collection('email_otps').doc(email).update({
      'verified': true,
    });
  }
}
