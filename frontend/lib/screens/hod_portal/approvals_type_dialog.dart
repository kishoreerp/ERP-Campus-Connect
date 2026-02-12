import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'staff_pending_screen.dart';
import 'staff_approved_screen.dart';
import 'student_approved_screen.dart';
import 'student_pending_screen.dart';

Future<void> showApprovalsTypeDialog(BuildContext context,
    {required bool isStaff}) {
  return showDialog(
    context: context,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Approvals",
                style: GoogleFonts.inter(
                    fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text(
              "Choose approval type to view",
              style: GoogleFonts.inter(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 18),

            _option(
              icon: Icons.pending_actions,
              title: "Pending Approval",
              subtitle: "Review pending requests",
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const StaffPendingScreen()),
                );
              },
            ),

            const SizedBox(height: 12),

            _option(
              icon: Icons.verified_outlined,
              title: "Approved",
              subtitle: "View approved requests",
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const StaffApprovedScreen()),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}
Widget _option({
  required IconData icon,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
  Color iconColor = Colors.black,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
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
