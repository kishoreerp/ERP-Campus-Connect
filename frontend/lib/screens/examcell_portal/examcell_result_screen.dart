import 'package:flutter/material.dart';
import 'examcell_home_screen.dart';
import 'examcell_portal_screen.dart';
import 'examcell_profile_screen.dart';
import 'result_details_dialog.dart';
import 'edit_result_dialog.dart';
import 'export_results_dialog.dart';
import 'import_results_dialog.dart';

class ExamCellResultScreen extends StatelessWidget {
  const ExamCellResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // ---------------- APP BAR ----------------
      appBar: AppBar(
         automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        titleSpacing: 16,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Exam Cell Admin',
              style: TextStyle(
                color: Color(0xFF7C3AED),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'SLEC Admin Portal',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Color(0xFF7C3AED),
              child: Icon(Icons.person, color: Colors.white),
            ),
          ),
        ],
      ),

      // ---------------- BODY ----------------
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Results Management',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            const Text(
              'View and publish exam results',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // -------- EXPORT / IMPORT --------
           // -------- EXPORT / IMPORT --------
Row(
  children: [
    Expanded(
      child: OutlinedButton.icon(
        icon: const Icon(Icons.download),
        label: const Text('Export'),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const ExportResultsDialog(),
          );
        },
      ),
    ),
    const SizedBox(width: 12),
    Expanded(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.upload),
        label: const Text('Import'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const ImportResultsDialog(),
          );
        },
      ),
    ),
  ],
),

            const SizedBox(height: 20),

            // -------- RESULT LIST --------
            Expanded(
              child: ListView(
                children: const [
                  _ResultCard(
                    name: 'Alice Johnson',
                    roll: 'CS001',
                    score: '85/100',
                    grade: 'A',
                    exam: 'Database Systems',
                  ),
                  _ResultCard(
                    name: 'Bob Smith',
                    roll: 'CS002',
                    score: '78/100',
                    grade: 'B+',
                    exam: 'Database Systems',
                  ),
                  _ResultCard(
                    name: 'Carol Davis',
                    roll: 'CS003',
                    score: '92/100',
                    grade: 'A+',
                    exam: 'Database Systems',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // ---------------- BOTTOM NAV ----------------
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // RESULT selected
        selectedItemColor: const Color(0xFF7C3AED),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ExamCellHomeScreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (_) => const ExamCellPortalScreen(),
  ),
);

          }
           else if (index == 2) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const ExamCellResultScreen(),
      ),
    );
  }
         else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ExamCellProfileScreen()),
      );
    }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Exam'),
          BottomNavigationBarItem(icon: Icon(Icons.description), label: 'Result'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// ================= RESULT CARD =================
class _ResultCard extends StatelessWidget {
  final String name;
  final String roll;
  final String score;
  final String grade;
  final String exam;

  const _ResultCard({
    required this.name,
    required this.roll,
    required this.score,
    required this.grade,
    required this.exam,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name + Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(roll, style: const TextStyle(color: Colors.grey)),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'PASS',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Score / Grade / Exam
          Row(
            children: [
              _infoBox('Score', score, const Color(0xFFE3F2FD)),
              const SizedBox(width: 10),
              _infoBox('Grade', grade, const Color(0xFFF3E5F5)),
              const SizedBox(width: 10),
              _infoBox('Exam', exam, const Color(0xFFE8F5E9)),
            ],
          ),

          const SizedBox(height: 16),

          // Buttons
          Row(
  children: [
    Expanded(
      child: OutlinedButton.icon(
        icon: const Icon(Icons.remove_red_eye),
        label: const Text('Details'),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const ResultDetailsDialog(),
          );
        },
      ),
    ),
    const SizedBox(width: 12),
    Expanded(
      child: OutlinedButton.icon(
        icon: const Icon(Icons.edit),
        label: const Text('Edit'),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const EditResultDialog(),
          );
        },
      ),
    ),
  ],
),

        ],
      ),
    );
  }

  static Widget _infoBox(String title, String value, Color bg) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(title,
                style: const TextStyle(fontSize: 12, color: Colors.black54)),
            const SizedBox(height: 4),
            Text(value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
