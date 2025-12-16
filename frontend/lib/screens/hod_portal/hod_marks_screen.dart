

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class HODMarksScreen extends StatelessWidget {
  const HODMarksScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TITLE
              Text(
                "Marks Management",
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),


              /// SUBTITLE
              Text(
                "Manage marks entry, department marks and university results",
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),


              const SizedBox(height: 24),


              /// --- MARKS ENTRY TILE ---
              _marksTile(
                icon: Icons.edit_outlined,
                iconColor: Colors.blueAccent,
                iconBG: Colors.blueAccent.withOpacity(0.15),
                title: "Marks Entry",
                subtitle: "Enter and edit marks for your subjects",
                onTap: () {
                  // Navigate to marks entry screen
                },
              ),
              const SizedBox(height: 14),


              /// --- DEPARTMENT MARKS TILE ---
              _marksTile(
                icon: Icons.visibility_outlined,
                iconColor: Colors.purpleAccent,
                iconBG: Colors.purpleAccent.withOpacity(0.15),
                title: "Department Marks",
                subtitle: "View all department subjects marks year-wise",
                onTap: () {
                  // Navigate to department marks screen
                },
              ),
              const SizedBox(height: 14),


              /// --- UNIVERSITY RESULTS TILE ---
              _marksTile(
                icon: Icons.emoji_events_outlined,
                iconColor: Colors.green,
                iconBG: Colors.green.withOpacity(0.15),
                title: "University Results",
                subtitle: "View and download university results",
                onTap: () {
                  // Navigate to university results screen
                },
              ),
            ],
          ),
        ),
      ),
    );
  }


  // ===================== TILE COMPONENT =====================
  Widget _marksTile({
    required IconData icon,
    required Color iconColor,
    required Color iconBG,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            /// ICON
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconBG,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(width: 16),


            /// TITLE + SUBTITLE
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),


            /// ARROW
            Icon(Icons.chevron_right, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}







