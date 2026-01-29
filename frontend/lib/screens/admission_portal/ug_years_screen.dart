import 'package:flutter/material.dart';
import 'ug_first_year_students_screen.dart';
import 'ug_Second_year_students_screen.dart';
import 'ug_Third_year_students_screen.dart';
import 'ug_final_year_students_screen.dart';




class UgYearsScreen extends StatelessWidget {
  const UgYearsScreen({super.key});

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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF2563EB),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'SLEC',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Admission Admin',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Admin Panel',
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
            const Text(
              'UG Programs',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Select a year',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            _yearCard(
              title: '1st Year',
              count: '5 Students',
              onTap: () {  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const UgFirstYearStudentsScreen(),
    ),
  );
                // Navigate to 1st year student list
              },
            ),

            _yearCard(
              title: '2nd Year',
              count: '5 Students',
              onTap: () {
                 Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const UgSecondYearStudentsScreen(),
    ),
  );
              },
            ),

            _yearCard(
              title: '3rd Year',
              count: '5 Students',
              onTap: () {
                 Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const UgThirdYearStudentsScreen(),
    ),
  );
              },
            ),

            _yearCard(
              title: 'Final Year',
              count: '5 Students',
              onTap: () {
                 Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const  UgFinalYearStudentsScreen(),
    ),
  );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ================= YEAR CARD =================
  Widget _yearCard({
    required String title,
    required String count,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
                    count,
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
  }
}
