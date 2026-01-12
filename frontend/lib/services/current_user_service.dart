import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class CurrentUserService {
  static Map<String, dynamic>? _userData;

  static Future<void> loadUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (doc.exists) {
      _userData = doc.data();
    }
  }

  static Map<String, dynamic>? getUser() {
    return _userData;
  }

  static void clear() {
    _userData = null;
  }
}
