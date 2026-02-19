import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'staff_list_screen.dart';
import 'mba_specializations_screen.dart';

class PgProgramsScreen extends StatelessWidget {
  const PgProgramsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: const Color(0xFFF6F7FB),
  appBar: AppBar(
    elevation: 0,
    backgroundColor: const Color(0xFFF6F7FB),
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    titleSpacing: 0,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Computer Science',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '4 Staff Members',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
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
