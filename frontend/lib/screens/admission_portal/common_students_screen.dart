import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'student_details_pdf_view.dart';

class CommonStudentsScreen extends StatelessWidget {
  final String program; // UG / PG
  final String year; 
  final String department;   // 1st Year / 2nd Year / Final Year

 const CommonStudentsScreen({
  super.key,
  required this.program,
  required this.year,
  required this.department,
});


  @override
Widget build(BuildContext context) {

  // ✅ DEBUG PRINTS (PASTE HERE)
  debugPrint('PROGRAM: $program');
  debugPrint('YEAR: $year');
  debugPrint('DEPARTMENT: $department');

  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$program - $year',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            department,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    ),


      // ✅ SAME QUERY – JUST DYNAMIC
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
    .collection('users')
    .where('role', isEqualTo: 'student')
    .where('program', isEqualTo: program)
    .where('year', isEqualTo: year)
    .where('department', isEqualTo: department)
    .where('status', isEqualTo: 'active')

    .snapshots(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No students found'));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;

              return StudentCard(
                uid: doc.id,
                name: data['username'] ?? '',
                email: data['email'] ?? '',
                phone: data['phone'] ?? '',
                studentId: data['studentId'] ?? '',
                rollNumber: data['rollNo'] ?? '',
                status: data['status'] ?? 'active',
              );
            }).toList(),
          );
        },
      ),
    );
  }
}



// ================= STUDENT CARD =================
class StudentCard extends StatelessWidget {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String studentId;
  final String rollNumber;
  final String status;

  const StudentCard({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.studentId,
    required this.rollNumber,
    required this.status,
  });

Color _statusColor(String status) {
  switch (status) {
    case 'active':
      return Colors.green;
    case 'discontinued':
    case 'transfer':
    case 'passed_out':
      return Colors.red;
    default:
      return Colors.grey;
  }
}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -------- HEADER --------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  Text(email,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.grey)),
                  Text(phone,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
              Container(
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  decoration: BoxDecoration(
    color: _statusColor(status).withOpacity(0.1),
    borderRadius: BorderRadius.circular(20),
  ),
  child: Text(
    status.toUpperCase(),
    style: TextStyle(
      fontSize: 12,
      color: _statusColor(status),
      fontWeight: FontWeight.w600,
    ),
  ),
),

            ],
          ),

          const SizedBox(height: 12),

          // -------- IDs --------
          Row(
            children: [
              _info('Student ID', studentId),
              const SizedBox(width: 12),
              _info('Roll Number', rollNumber),
            ],
          ),

          const SizedBox(height: 12),

          // -------- ACTIONS --------
          Row(
            children: [
              
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 72, 72, 73),
                ),
  icon: const Icon(Icons.remove_red_eye, size: 18),
  label: const Text('View Details'),
  
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StudentDetailsPdfView(
          studentUid: uid, // ✅ PASS REAL STUDENT UID
        ),
      ),
    );
  },
),

            ],
          ),
        ],
      ),
    );
  }

  Widget _info(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 11, color: Colors.grey)),
          const SizedBox(height: 2),
          Text(value,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }
}
