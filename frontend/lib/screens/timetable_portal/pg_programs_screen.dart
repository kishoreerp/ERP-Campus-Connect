import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'staff_list_screen.dart';
import 'mba_specializations_screen.dart';

class PgProgramsScreen extends StatelessWidget {
  const PgProgramsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),

      /// APP BAR
      appBar: AppBar(
        backgroundColor: const Color(0xFF3D5AFE),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Postgraduate Programs',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '1/9/2026',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),

      /// BODY
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Program',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 16),

            /// MBA CARD
            _programTile(
              context,
              title: 'MBA',
              subtitle: 'Master of Business Administration',
              icon: Icons.workspace_premium,
              iconBg: const Color(0xFFF3E5F5),
              iconColor: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  /// PROGRAM TILE
  Widget _programTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ListTile(
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: Colors.grey,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),

        /// ⭐ CORRECT NAVIGATION
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const MbaSpecializationsScreen(),
            ),
          );
        },
      ),
    );
  }
}
