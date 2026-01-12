import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'timetable_grid_screen.dart';
import 'data/timetable_data.dart'; // dummy data for now

class StaffListScreen extends StatelessWidget {
  final String departmentName;
  final String departmentCode;

  const StaffListScreen({
    super.key,
    required this.departmentName,
    required this.departmentCode,
  });

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
          departmentName,
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
              'Select Staff Member',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 16),

            /// STAFF LIST (dummy for now)
            _staffTile(
              context,
              name: 'Dr. Sarah Johnson',
              workload: 'Worked: 18/24h',
            ),
            _staffTile(
              context,
              name: 'Prof. David Lee',
              workload: 'Worked: 20/24h',
            ),
          ],
        ),
      ),
    );
  }

  /// STAFF TILE
  Widget _staffTile(
    BuildContext context, {
    required String name,
    required String workload,
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
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.person,
            color: Colors.green,
          ),
        ),
        title: Text(
          name,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          workload,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: Colors.grey,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),

        /// ⭐ THIS IS THE KEY PART
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TimetableGridScreen(
                title: name, // Staff name
                subtitle: 'Staff Timetable',
                entries: cseFirstYearTimetable, // dummy data for now
              ),
            ),
          );
        },
      ),
    );
  }
}
