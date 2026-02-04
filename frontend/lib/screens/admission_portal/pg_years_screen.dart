import 'package:flutter/material.dart';
import 'pg_departments_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class PgYearsScreen extends StatelessWidget {
  const PgYearsScreen({super.key});

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
                  'PG Programs',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Select a year',
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

            _yearCard(
  context: context,
  title: '1st Year',
  program: 'PG',
  year: '1st Year',
),

_yearCard(
  context: context,
  title: '2nd Year',
  program: 'PG',
  year: '2nd Year',
),

          ],
        ),
      ),
    );
  }

  // ================= YEAR CARD =================
  Widget _yearCard({
  required BuildContext context,
  required String title,
  required String program,
  required String year,
}) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('users')
        .where('program', isEqualTo: program)
        .where('year', isEqualTo: year)
        .snapshots(),
    builder: (context, snapshot) {
      int studentCount = 0;

      if (snapshot.hasData) {
        studentCount = snapshot.data!.docs.length;
      }

      return InkWell(
        onTap: () {
   Navigator.push(
  context,
   MaterialPageRoute(
          builder: (_) => PgDepartmentsScreen(
            year: year, // ✅ PASS REAL YEAR
          ),
   ),
);


        },
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
                      '$studentCount Students',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      );
    },
  );
}

}