import 'package:flutter/material.dart';
import 'admission_create_student_login_screen.dart';
import 'admission_view_all_students_screen.dart';

class AdmissionStudentScreen extends StatelessWidget {
  const AdmissionStudentScreen({super.key});

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
              'Student Management',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Manage student accounts and IDs',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

           _actionCard(
  icon: Icons.person_add_alt_1,
  title: 'Create Student Login ID',
  subtitle: 'Generate login credentials for new students',
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AdmissionCreateStudentLoginScreen(),
      ),
    );
  },
),

            const SizedBox(height: 16),
         _actionCard(
  icon: Icons.groups,
  title: 'View All Students',
  subtitle: 'Browse enrolled students',
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AdmissionViewAllStudentsScreen(),
      ),
    );
  },
),


          ],
        ),
      ),
    );
  }

  // ================= ACTION CARD =================
  Widget _actionCard({
    required IconData icon,
    required String title,
    required String subtitle,
     VoidCallback? onTap,
  }) {
    return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(16),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFFEFF6FF),
            child: Icon(icon, color: const Color(0xFF2563EB)),
          ),
          const SizedBox(width: 14),
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
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
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
