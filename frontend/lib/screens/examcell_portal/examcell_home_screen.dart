import 'package:flutter/material.dart';

import 'announcements_dialog.dart';
import 'notifications_dialog.dart';



class ExamCellHomeScreen extends StatelessWidget {
  const ExamCellHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _welcomeCard(),
            const SizedBox(height: 20),
           _quickActionsCard(context),

          ],
        ),
      ),
     
    );
  }


  // ---------------- WELCOME CARD ----------------
  Widget _welcomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF8E2DE2),
            Color(0xFF4A00E0),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white.withOpacity(0.2),
            child: const Icon(Icons.school, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Welcome, Dr. Rajesh Kumar!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'EMP456 • Exam Cell Admin',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------- QUICK ACTIONS ----------------
Widget _quickActionsCard(BuildContext context) {
  return Container(
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
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 16),
        _actionTile(
          icon: Icons.campaign,
          title: 'Announcements',
          subtitle: 'View and create announcements',
          iconBg: Colors.blue,
          tileBg: const Color.fromARGB(255, 76, 133, 173),
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => const AnnouncementsDialog(),
            );
          },
        ),
        _actionTile(
  icon: Icons.notifications,
  title: 'Notifications',
  subtitle: 'Manage notifications',
  iconBg: Colors.purple,
  tileBg: const Color(0xFFF3E5F5),
  onTap: () {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const NotificationsDialog(),
    );
  },
),

      ],
    ),
  );
}


  Widget _actionTile({
  required IconData icon,
  required String title,
  required String subtitle,
  required Color iconBg,
  required Color tileBg,
  VoidCallback? onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(14),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: tileBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconBg,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}



  
}


