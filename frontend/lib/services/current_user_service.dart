import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CurrentUserService {
  static Map<String, dynamic>? _user;

  static Future<void> loadUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (doc.exists) {
      _user = doc.data();
      print('USER LOADED: $_user'); // 🔍 DEBUG
    }
  }

  static Map<String, dynamic>? getUser() {
    return _user;
  }

  static void clear() {
    _user = null;
  }
}
