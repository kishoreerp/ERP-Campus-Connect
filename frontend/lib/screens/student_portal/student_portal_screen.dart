import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'student_home_screen.dart';
import 'student_subjects_screen.dart';
import 'student_attendance_screen.dart';
import 'student_profile_screen.dart';

class StudentPortalScreen extends StatefulWidget {
  const StudentPortalScreen({super.key});

  @override
  State<StudentPortalScreen> createState() => _StudentPortalScreenState();
}

class _StudentPortalScreenState extends State<StudentPortalScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    StudentHomeScreen(),
    StudentSubjectsScreen(),
    StudentAttendanceScreen(),
    StudentProfileScreen(), // ✅ Removed dark mode params
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✅ Pure white background
      body: SafeArea(child: _pages[_selectedIndex]),

      // ✅ Clean, flat bottom navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        elevation: 0,
        selectedLabelStyle:
            GoogleFonts.inter(fontWeight: FontWeight.w600, color: Colors.deepPurple),
        unselectedLabelStyle:
            GoogleFonts.inter(color: Colors.grey),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined), label: "Subjects"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined), label: "Attendance"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }
}
