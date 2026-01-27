import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StaffNotificationsScreen extends StatelessWidget {
  const StaffNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notifications',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            Text(
              'Stay updated with important announcements',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _NotificationTile(
            title: 'Attendance Report Due',
            subtitle:
                'Please submit attendance reports for all classes by today',
            time: '2 hours ago',
          ),
          _NotificationTile(
            title: 'Lab Equipment Request',
            subtitle: 'New lab equipment request form is now available',
            time: '5 hours ago',
          ),
          _NotificationTile(
            title: 'Exam Schedule Updated',
            subtitle:
                'Mid-term exam schedule has been updated. Check your schedule',
            time: '1 day ago',
          ),
          _NotificationTile(
            title: 'Student Query',
            subtitle:
                '3 students have submitted queries regarding assignments',
            time: '2 days ago',
          ),
        ],
      ),
    );
  }
}

// ---------------- NOTIFICATION TILE ----------------

class _NotificationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;

  const _NotificationTile({
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.notifications_outlined,
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  time,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
