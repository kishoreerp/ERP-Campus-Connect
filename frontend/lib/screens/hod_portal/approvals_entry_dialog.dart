import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'approvals_type_dialog.dart';

Future<void> showApprovalsEntryDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Pending Approval",
                style: GoogleFonts.inter(
                    fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text(
              "Select user type to view pending approvals",
              style: GoogleFonts.inter(fontSize: 13, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),

            _option(
              icon: Icons.person_outline,
              title: "Staff",
              subtitle: "View staff pending approvals",
              onTap: () {
                Navigator.pop(context);
                showApprovalsTypeDialog(context, isStaff: true);
              },
            ),

            const SizedBox(height: 12),

            _option(
              icon: Icons.school_outlined,
              title: "Student",
              subtitle: "View student pending approvals",
              onTap: () {
                Navigator.pop(context);
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
          Icon(icon, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: GoogleFonts.inter(
                        fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
