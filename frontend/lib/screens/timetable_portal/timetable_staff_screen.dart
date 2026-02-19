import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'year_departments_screen.dart';
import 'pg_programs_screen.dart';

class TTStaffScreen extends StatelessWidget {
  const TTStaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),

     

      /// BODY
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TITLE
            Text(
              'Staff Timetable',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'View and manage staff schedules',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 24),

            /// CARDS
            Row(
              children: [
                Expanded(
                  child: _categoryCard(
                    title: 'UG',
                    subtitle: 'Undergraduate',
                    icon: Icons.school,
                    iconBg: const Color(0xFFE8F5E9),
                    iconColor: Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => YearDepartmentsScreen(
                            yearTitle: 'Undergraduate',
                            isStaffFlow: true, // ⭐ IMPORTANT
                            departments: const [
                              Department(name: 'Computer Science', code: 'CSE'),
                              Department(name: 'Information Technology', code: 'IT'),
                              Department(name: 'Cyber Security', code: 'CSL'),
                              Department(
                                  name: 'Artificial Intelligence & Data Science',
                                  code: 'AI&DS'),
                              Department(
                                  name: 'Electronics & Communication',
                                  code: 'ECE'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _categoryCard(
                    title: 'PG',
                    subtitle: 'Postgraduate',
                    icon: Icons.workspace_premium,
                    iconBg: const Color(0xFFF3E5F5),
                    iconColor: Colors.purple,
                    onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const PgProgramsScreen(),
    ),
  );
},


                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// CATEGORY CARD (UG / PG)
  Widget _categoryCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 28,
                color: iconColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
