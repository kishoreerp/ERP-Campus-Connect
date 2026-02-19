import 'package:flutter/material.dart';

class NotificationsDialog extends StatelessWidget {
  const NotificationsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ---------------- HEADER ----------------
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'View and manage your notifications',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // ---------------- LIST ----------------
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _NotificationCard(
                    color: Colors.deepOrange,
                    icon: Icons.warning_amber_rounded,
                    title: 'Exam Schedule Updated',
                    desc:
                        'The exam schedule for Web Development has been rescheduled to Jan 28, 2025. Please update your records.',
                    time: '2 hours ago',
                  ),

                  _NotificationCard(
                    color: Colors.blue,
                    icon: Icons.check_circle_outline,
                    title: 'Results Uploaded Successfully',
                    desc:
                        'Database Systems exam results have been successfully uploaded to the system.',
                    time: '5 hours ago',
                  ),

                  _NotificationCard(
                    color: Colors.green,
                    icon: Icons.notifications_active,
                    title: 'New Exam Request',
                    desc:
                        'Faculty has submitted a request for scheduling a makeup exam for Machine Learning course.',
                    time: '1 day ago',
                  ),

                  _NotificationCard(
                    color: Colors.purple,
                    icon: Icons.assignment_turned_in,
                    title: 'Grading Completed',
                    desc:
                        'All answer scripts for Algorithms exam have been graded and verified.',
                    time: '2 days ago',
                  ),
                ],
              ),
            ),
          ),

          const Divider(height: 1),
        ],
      ),
    );
  }
}

// ================= CARD =================
class _NotificationCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String desc;
  final String time;

  const _NotificationCard({
    required this.color,
    required this.icon,
    required this.title,
    required this.desc,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border(
          left: BorderSide(color: color, width: 4),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 4),
                Text(desc,
                    style: const TextStyle(
                        fontSize: 12, color: Colors.black87)),
                const SizedBox(height: 6),
                Text(time,
                    style: TextStyle(
                        fontSize: 11,
                        color: color,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
