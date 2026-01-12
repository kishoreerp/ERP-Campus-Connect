import 'package:flutter/material.dart';

class AnnouncementsDialog extends StatelessWidget {
  const AnnouncementsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
     child: SingleChildScrollView(
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
                        'Announcements',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'View all announcements and create new ones',
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

          // ---------------- CONTENT ----------------
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recent Announcements',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),

                _announcementCard(
                  iconColor: Colors.blue,
                  bgColor: const Color(0xFFE3F2FD),
                  title: 'Mid-Semester Exam Schedule Released',
                  description:
                      'The mid-semester examination schedule has been finalized and published. All students are requested to check their exam dates and venues.',
                  date: 'Posted on Dec 15, 2025',
                ),

                const SizedBox(height: 12),

                _announcementCard(
                  iconColor: Colors.green,
                  bgColor: const Color(0xFFE8F5E9),
                  title: 'Exam Hall Guidelines Updated',
                  description:
                      'New guidelines for examination halls have been implemented. Please review the updated protocols before the exam day.',
                  date: 'Posted on Dec 12, 2025',
                ),

                const SizedBox(height: 12),

                _announcementCard(
                  iconColor: Colors.purple,
                  bgColor: const Color(0xFFF3E5F5),
                  title: 'Result Publishing Timeline',
                  description:
                      'Final examination results will be published within 15 days of the last exam date. Students will be notified via email.',
                  date: 'Posted on Dec 10, 2025',
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // ---------------- FOOTER ----------------
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Close'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // future: create announcement screen
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Create Announcement'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
     )
    );
    
  }

  // ---------------- ANNOUNCEMENT CARD ----------------
  static Widget _announcementCard({
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String description,
    required String date,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: iconColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: iconColor,
                child: const Icon(Icons.notifications, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 8),
          Text(
            date,
            style: TextStyle(
              fontSize: 12,
              color: iconColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
