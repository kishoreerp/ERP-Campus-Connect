import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Get user document by UID
  Future<Map<String, dynamic>?> getUserByUid(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();

    if (!doc.exists) return null;

    return doc.data();
  }

  /// Create user if not exists (on first login)
  Future<void> createUserIfNotExists({
    required String uid,
    required String email,
    required String role, // student | admin | hod
    required String name,
  }) async {
    final ref = _db.collection('users').doc(uid);
    final doc = await ref.get();

    if (!doc.exists) {
      await ref.set({
        'uid': uid,
        'email': email,
        'name': name,
        'role': role,
        'createdAt': FieldValue.serverTimestamp(),
        'isActive': true,
      });
    }
  }
}
