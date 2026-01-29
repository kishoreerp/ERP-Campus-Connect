import 'package:flutter/material.dart';
import 'ug_programs_screen.dart';
import 'Pg_programs_screen.dart';
class AdmissionScreen extends StatelessWidget {
  const AdmissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

     

      // ================= BODY =================
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Admissions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Select program type to manage applications',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            _programCard(
              title: 'UG Programs',
              subtitle: 'Undergraduate Admissions',
              applications: '4 Applications',
               onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const UgDepartmentsScreen(),
      ),
    );
  },
            ),
            const SizedBox(height: 16),
            _programCard(
  title: 'PG Programs',
  subtitle: 'Postgraduate Admissions',
  applications: '2 Applications',
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const PgProgramsScreen(),
      ),
    );
  },
),

          ],
        ),
      ),
    );
  }

  // ================= PROGRAM CARD =================
  Widget _programCard({
  required String title,
  required String subtitle,
  required String applications,
  required VoidCallback onTap, 
}) {
  return InkWell(
    onTap: onTap, 
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
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                
                  subtitle,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    applications,
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