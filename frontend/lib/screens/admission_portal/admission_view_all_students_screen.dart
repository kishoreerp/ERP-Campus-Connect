import 'package:flutter/material.dart';
import 'ug_years_screen.dart';
import 'pg_years_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class AdmissionViewAllStudentsScreen extends StatelessWidget {
  const AdmissionViewAllStudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
                  'View All Students',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Select program type',
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
StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance
      .collection('users')
      .where('role', isEqualTo: 'student')
      .where('program', isEqualTo: 'UG')
      .snapshots(),
  builder: (context, snapshot) {
    final count = snapshot.hasData ? snapshot.data!.docs.length : 0;

    return _programCard(
      title: 'UG Programs',
      subtitle: 'Undergraduate Students',
      count: '$count Students',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const UgYearsScreen(),
          ),
        );
      },
    );
  },
),


            const SizedBox(height: 16),

           StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance
      .collection('users')
      .where('role', isEqualTo: 'student')
      .where('program', isEqualTo: 'PG')
      .snapshots(),
  builder: (context, snapshot) {
    final count = snapshot.hasData ? snapshot.data!.docs.length : 0;

    return _programCard(
      title: 'PG Programs',
      subtitle: 'Postgraduate Students',
      count: '$count Students',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const PgYearsScreen(),
          ),
        );
      },
    );
  },
),

                // Navigate to PG students list
              
            
          ],
        ),
      ),
    );
  }

  // ================= PROGRAM CARD =================
  Widget _programCard({
    required String title,
    required String subtitle,
    required String count,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          color: Colors.white,
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
                    subtitle,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      count,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
