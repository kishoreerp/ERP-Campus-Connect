import 'package:flutter/material.dart';
import 'examcell_home_screen.dart';
import 'examcell_exam_screen.dart';
import 'examcell_result_screen.dart';
import 'settings_dialog.dart';
import '../slec_home_screen.dart';

class ExamCellProfileScreen extends StatelessWidget {
  const ExamCellProfileScreen({super.key});

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    const Text(
      'Profile',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    IconButton(
      icon: const Icon(Icons.settings, color: Colors.grey),
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (_) => const SettingsDialog(),
        );
      },
    ),
  ],
),


            const SizedBox(height: 12),

            // ---------- PROFILE CARD ----------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 34,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, size: 36, color: Colors.white),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Dr. Rajesh Kumar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Exam Cell Admin',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  SizedBox(height: 6),
                  Chip(
                    label: Text(
                      'EMP456',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.white24,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ---------- CONTACT INFO ----------
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Contact Information',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),

                  _InfoTile(
                    icon: Icons.email,
                    iconColor: Colors.blue,
                    title: 'Email',
                    value: 'rajesh.kumar@slec.edu.in',
                  ),
                  _InfoTile(
                    icon: Icons.phone,
                    iconColor: Colors.green,
                    title: 'Phone',
                    value: '+91 98765 43210',
                  ),
                  _InfoTile(
                    icon: Icons.apartment,
                    iconColor: Colors.purple,
                    title: 'Department',
                    value: 'Examination Cell',
                  ),
                  _InfoTile(
                    icon: Icons.calendar_month,
                    iconColor: Colors.orange,
                    title: 'Joined',
                    value: 'March 2020',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ---------- LOGOUT ----------
            OutlinedButton.icon(
             onPressed: () {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => const SlecHomeScreen()

    ),
    (route) => false, // ❗ clears all previous screenszzy
  );
},

              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
            
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),

      // ---------------- BOTTOM NAV ----------------
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, // PROFILE
        selectedItemColor: const Color(0xFF7C3AED),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 3) return;

          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ExamCellHomeScreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ExamCellExamScreen()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => const ExamCellResultScreen()),
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

// ================= INFO TILE =================
class _InfoTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: iconColor.withOpacity(0.15),
            child: Icon(icon, size: 18, color: iconColor),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 12)),
              Text(
                value,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
// login_screen.dart


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Login Screen',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}

