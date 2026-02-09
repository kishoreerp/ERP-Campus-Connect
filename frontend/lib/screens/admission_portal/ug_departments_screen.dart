import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'common_students_screen.dart';

class UgDepartmentsScreen extends StatelessWidget {
  final String year;

  const UgDepartmentsScreen({
    super.key,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 12,
        title: Row(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'UG Departments',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Select department to view students',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      // ================= BODY =================
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            const SizedBox(height: 5),

            _deptCard(
              context,
              title: 'Information Technology',
              code: 'IT',
              department: 'Information Technology',
            ),

            _deptCard(
              context,
              title: 'Computer Science Engineering (Cyber Security)',
              code: 'CSE_CS',
              department: 'Computer Science Engineering (Cyber Security)',
            ),

            _deptCard(
              context,
              title: 'Artificial Intelligence Data Science',
              code: 'AI_DS',
              department: 'Artificial Intelligence Data Science',
            ),

            _deptCard(
              context,
              title: 'Computer Science Engineering',
              code: 'CSE',
              department: 'Computer Science Engineering',
            ),

            _deptCard(
              context,
              title: 'Electronics and Communication Engineering',
              code: 'ECE',
              department: 'Electronics and Communication Engineering',
            ),
          ],
        ),
      ),
    );
  }

  // ================= DEPARTMENT CARD (WITH FIRESTORE COUNT) =================
  Widget _deptCard(
    BuildContext context, {
    required String title,
    required String code,
    required String department,
  }) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'student')
          .where('program', isEqualTo: 'UG')
          .where('year', isEqualTo: year)
          .where('department', isEqualTo: department)
          .snapshots(),
      builder: (context, snapshot) {
        final count = snapshot.hasData ? snapshot.data!.docs.length : 0;

        return InkWell(
          onTap: () => _openStudents(context, department),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        code,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$count Students',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
        );
      },
    );
  }

  // ================= NAVIGATION =================
  void _openStudents(BuildContext context, String department) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CommonStudentsScreen(
          program: 'UG',
          year: year,
          department: department,
        ),
      ),
    );
  }
}
