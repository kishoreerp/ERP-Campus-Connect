import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ✅ IMPORT REUSABLE SCREEN
import 'year_departments_screen.dart';

// ✅ IMPORT MBA SPECIALIZATION SCREEN
import 'mba_specializations_screen.dart';

class TTStudentScreen extends StatelessWidget {
  const TTStudentScreen({super.key});

  // =====================
  // UG DEPARTMENTS
  // =====================
  static final List<Department> ugDepartments = [
    Department(name: 'Computer Science and Engineering', code: 'CSE'),
    Department(name: 'Information Technology', code: 'IT'),
    Department(name: 'Computer Science and Engineering (Cyber Security)', code: 'CSE-CS'),
    Department(name: 'Artificial Intelligence and Data Science', code: 'AI&DS'),
    Department(name: 'Electronics and Communication Engineering', code: 'ECE'),
  ];

  // =====================
  // PG (1st Year only)
  // =====================
  static final List<Department> pgDepartments = [
    Department(name: 'Master of Business Administration', code: 'MBA'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// APP BAR
      appBar: AppBar(
        backgroundColor: const Color(0xFF3D5AFE),
        elevation: 0,
        title: Text(
          'SLEC Timetable Admin',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '12/16/2025',
                style: GoogleFonts.inter(fontSize: 12),
              ),
            ),
          ),
        ],
      ),

      /// BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TITLE
            Text(
              'Student Timetable',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'View and manage student schedules',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 24),

            /// =====================
            /// UNDERGRADUATE
            /// =====================
            Text(
              'Undergraduate',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _YearCard(
                  title: '1st Year',
                  onTap: () => _openYear(context, '1st Year', ugDepartments),
                ),
                _YearCard(
                  title: '2nd Year',
                  onTap: () => _openYear(context, '2nd Year', ugDepartments),
                ),
                _YearCard(
                  title: '3rd Year',
                  onTap: () => _openYear(context, '3rd Year', ugDepartments),
                ),
                _YearCard(
                  title: 'Final Year',
                  onTap: () => _openYear(context, 'Final Year', ugDepartments),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// =====================
            /// POSTGRADUATE
            /// =====================
            Text(
              'Postgraduate',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                /// PG 1st Year → same as before
                _YearCard(
                  title: '1st Year',
                  isPostGraduate: true,
                  onTap: () => _openYear(
                    context,
                    'MBA 1st Year',
                    pgDepartments,
                  ),
                ),

                /// PG 2nd Year → MBA SPECIALIZATION
                _YearCard(
                  title: '2nd Year',
                  isPostGraduate: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MbaSpecializationsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// =====================
  /// OPEN YEAR (STUDENT FLOW)
  /// =====================
  static void _openYear(
    BuildContext context,
    String yearTitle,
    List<Department> departments,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => YearDepartmentsScreen(
          yearTitle: yearTitle,
          departments: departments,
          // ⚠️ isStaffFlow NOT passed → student flow
        ),
      ),
    );
  }
}

/// =====================
/// YEAR CARD WIDGET
/// =====================
class _YearCard extends StatelessWidget {
  final String title;
  final bool isPostGraduate;
  final VoidCallback onTap;

  const _YearCard({
    required this.title,
    required this.onTap,
    this.isPostGraduate = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school,
              size: 28,
              color: isPostGraduate
                  ? Colors.purpleAccent
                  : Colors.blueAccent,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
