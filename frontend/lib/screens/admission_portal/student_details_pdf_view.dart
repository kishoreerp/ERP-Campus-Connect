import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class StudentDetailsPdfView extends StatelessWidget {
  final String studentUid;

  const StudentDetailsPdfView({
    super.key,
    required this.studentUid,
  });

 @override
Widget build(BuildContext context) {
  return StreamBuilder<DocumentSnapshot>(
    stream: FirebaseFirestore.instance
        .collection('users')
        .doc(studentUid)
        .snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      final data = snapshot.data!.data() as Map<String, dynamic>;

      return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.6),
        body: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['username'],
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(data['email']),
                  const SizedBox(height: 16),

                  _info('Student ID', data['studentId']),
                  _info('Roll No', data['rollNo']),
                  _info('Department', data['department']),
                  _info('Year', data['year']),
                  _info('Phone', data['phone']),
                  _info('Address', data['address'] ?? 'Not provided'),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}


  // ================= HELPERS =================

  Widget _sectionCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _rowInfo(
      String leftTitle, String leftValue, String rightTitle, String rightValue) {
    return Row(
      children: [
        Expanded(child: _info(leftTitle, leftValue)),
        const SizedBox(width: 12),
        Expanded(child: _info(rightTitle, rightValue)),
      ],
    );
  }

  Widget _singleInfo(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _info(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
