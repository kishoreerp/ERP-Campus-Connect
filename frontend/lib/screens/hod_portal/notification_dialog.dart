import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> showNotificationsDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (_) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Notifications",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Your recent notifications and alerts",
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),

                  _notificationItem(
                    title: "Faculty Meeting Reminder",
                    message:
                        "Department meeting scheduled for tomorrow at 3 PM",
                    time: "2 hours ago",
                  ),
                  _notificationItem(
                    title: "Budget Approval",
                    message:
                        "Department budget for Q2 has been approved",
                    time: "5 hours ago",
                  ),
                  _notificationItem(
                    title: "Student Complaint",
                    message:
                        "New student complaint requires your attention",
                    time: "1 day ago",
                  ),
                  _notificationItem(
                    title: "Infrastructure Request",
                    message:
                        "Lab equipment request submitted by Prof. Lee",
                    time: "2 days ago",
                  ),
                ],
              ),
            ),

            // CLOSE BUTTON
            Positioned(
              top: 8,
              right: 8,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, size: 20),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _notificationItem({
  required String title,
  required String message,
  required String time,
}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          message,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          time,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: Colors.grey[500],
          ),
        ),
      ],
    ),
  );
}
