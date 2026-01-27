import 'dart:math';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;


class OtpService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String generateOtp() {
    return (100000 + Random().nextInt(900000)).toString();
  }

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
Future<void> sendOtpEmail({
  required String email,
  required String otp,
}) async {
  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'origin': 'http://localhost',
    },
    body: jsonEncode({
     "service_id": "service_a9h7x28",
  "template_id": "template_u8udh0g",
  "user_id": "Zhc5JbJO-QrMNTNwa",
      "template_params": {
        "email": email,
        "otp": otp,
      }
    }),
  );

  if (response.statusCode != 200) {
    throw 'EmailJS failed: ${response.body}';
  }
}


  Future<void> verifyOtp({
    required String email,
    required String enteredOtp,
  }) async {
    final doc = await _db.collection('email_otps').doc(email).get();

    if (!doc.exists) throw 'OTP not found';

    final data = doc.data()!;
    final expiresAt = (data['expiresAt'] as Timestamp).toDate();

    if (DateTime.now().isAfter(expiresAt)) throw 'OTP expired';
    if (data['otp'] != enteredOtp) throw 'Invalid OTP';

    await _db.collection('email_otps').doc(email).update({
      'verified': true,
    });
  }
}
