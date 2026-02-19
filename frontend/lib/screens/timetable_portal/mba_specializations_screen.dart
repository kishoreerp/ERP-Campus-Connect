import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'staff_list_screen.dart';
import 'timetable_grid_screen.dart';
class MbaSpecializationsScreen extends StatelessWidget {
  const MbaSpecializationsScreen({super.key});

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
              'Select Specialization',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 16),

            _specializationTile(
              context,
              title: 'Human Resources',
              code: 'HR',
            ),
            _specializationTile(
              context,
              title: 'Marketing',
              code: 'MARKETING',
            ),
            _specializationTile(
              context,
              title: 'Finance',
              code: 'FINANCE',
            ),
            _specializationTile(
              context,
              title: 'Tourism',
              code: 'TOURISM',
            ),
            _specializationTile(
              context,
              title: 'Supply Chain',
              code: 'SUPPLY_CHAIN',
            ),
            _specializationTile(
              context,
              title: 'Logistics',
              code: 'LOGISTICS',
            ),
          ],
        ),
      ),
    );
  }

  /// SPECIALIZATION TILE
  Widget _specializationTile(
    BuildContext context, {
    required String title,
    required String code,
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
            color: const Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.apartment,
            color: Colors.purple,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          title.toUpperCase(),
          style: GoogleFonts.inter(
            fontSize: 11,
            color: Colors.grey,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),

        /// ⭐ NAVIGATION
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TimetableGridScreen(
                title: 'MBA - $title',
                subtitle: code,
                entries: const [],
              ),
            ),
          );
        },
      ),
    );
  }
}
