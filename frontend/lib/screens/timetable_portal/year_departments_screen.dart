import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'timetable_grid_screen.dart';
import 'staff_list_screen.dart';
import 'data/timetable_data.dart';

class YearDepartmentsScreen extends StatelessWidget {
  final String yearTitle;
  final List<Department> departments;

  /// ⭐ This decides the flow
  /// false = Student → Timetable
  /// true  = Staff → Staff List
  final bool isStaffFlow;

  const YearDepartmentsScreen({
    super.key,
    required this.yearTitle,
    required this.departments,
    this.isStaffFlow = false, // ⭐ default = student flow
  });

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
            /// TITLE
            Text(
              yearTitle,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Select Department',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            /// DEPARTMENT LIST
            Expanded(
              child: ListView.builder(
                itemCount: departments.length,
                itemBuilder: (context, index) {
                  final dept = departments[index];
                  return _DepartmentTile(
                    title: dept.name,
                    code: dept.code,
                    yearTitle: yearTitle,
                    isStaffFlow: isStaffFlow,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// =====================
/// DEPARTMENT MODEL
/// =====================
class Department {
  final String name;
  final String code;

  const Department({
    required this.name,
    required this.code,
  });
}

/// =====================
/// DEPARTMENT TILE
/// =====================
class _DepartmentTile extends StatelessWidget {
  final String title;
  final String code;
  final String yearTitle;
  final bool isStaffFlow;

  const _DepartmentTile({
    required this.title,
    required this.code,
    required this.yearTitle,
    required this.isStaffFlow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          /// ⭐ THIS IS THE KEY LOGIC
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => isStaffFlow
                  ? StaffListScreen(
                      departmentName: title,
                      departmentCode: code,
                    )
                  : TimetableGridScreen(
                      title: title,
                      subtitle: '$yearTitle Timetable',
                      entries: cseFirstYearTimetable, // dummy for now
                    ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.menu_book,
                  color: Color(0xFF3D5AFE),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
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
                    const SizedBox(height: 2),
                    Text(
                      code,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
