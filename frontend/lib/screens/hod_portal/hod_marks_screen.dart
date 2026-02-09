import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'hod_marks_entry_screen.dart';
import 'hod_department_marks_screen.dart';


class HODMarksScreen extends StatelessWidget {
  const HODMarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Marks Management",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              "Manage marks entry, department marks and university results",
              style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),

      // ================= BODY =================
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _marksCard(
              icon: Icons.edit_outlined,
              iconBg: const Color(0xFFE8F2FF),
              iconColor: Colors.blue,
              title: "Marks Entry",
              subtitle: "Enter and edit marks for your subjects",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HODMarksEntryScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _marksCard(
  icon: Icons.remove_red_eye_outlined,
  iconBg: const Color(0xFFF3E8FF),
  iconColor: Colors.purple,
  title: "Department Marks",
  subtitle: "View all department subjects marks year-wise",
  onTap: () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HODDepartmentMarksScreen(),
      ),
    );
  },
),

            const SizedBox(height: 12),
            _marksCard(
              icon: Icons.emoji_events_outlined,
              iconBg: const Color(0xFFE9FFF1),
              iconColor: Colors.green,
              title: "University Results",
              subtitle: "View and download university results",
              onTap: () {Navigator.pushNamed(context, '/hod-university-results');},
              
            ),
          ],
        ),
      ),
    );
  }

  Widget _marksCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600)),
                  Text(subtitle,
                      style: GoogleFonts.inter(
                          fontSize: 12, color: Colors.grey)),
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
