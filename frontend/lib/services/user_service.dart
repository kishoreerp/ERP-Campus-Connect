import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final _db = FirebaseFirestore.instance;

  /// Get user by UID
  Future<Map<String, dynamic>?> getUserByUid(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    return doc.exists ? doc.data() : null;
  }

  /// Get user by roll number (for roll login)
  Future<Map<String, dynamic>?> getUserByRoll(String rollNo) async {
    final snap = await _db
        .collection('users')
        .where('rollNo', isEqualTo: rollNo)
        .limit(1)
        .get();

    if (snap.docs.isEmpty) return null;
    return snap.docs.first.data();
  }
  Future<Map<String, dynamic>?> getUserByUsername(String username) async {
  final query = await FirebaseFirestore.instance
      .collection('users')
      .where('username', isEqualTo: username)
      .limit(1)
      .get();

  if (query.docs.isEmpty) return null;

  return query.docs.first.data();
}

}
