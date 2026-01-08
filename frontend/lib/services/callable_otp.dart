import 'package:cloud_functions/cloud_functions.dart';

class CallableOtp {

 Future<void> sendOtp({
   required String email,
   required String otp,
 }) async {

   final callable =
      FirebaseFunctions.instance
          .httpsCallable('sendOtpEmail');

   await callable.call({
     "email": email,
     "otp": otp,
   });

 }

}
