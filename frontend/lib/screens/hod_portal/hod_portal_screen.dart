import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'hod_home_screen.dart';
import 'hod_attendance_screen.dart';
import 'hod_marks_screen.dart';
import 'hod_profile_screen.dart';


class HODPortalScreen extends StatefulWidget {
  final String username;
  const HODPortalScreen({super.key, required this.username});


  @override
  State<HODPortalScreen> createState() => _HODPortalScreenState();
}


class _HODPortalScreenState extends State<HODPortalScreen> {
  int _selectedIndex = 0;


  late final List<Widget> _pages;


  @override
  void initState() {
    super.initState();
    _pages = [
      HODHomeScreen(username: widget.username),
      const HODAttendanceScreen(),
      const HODMarksScreen(),
      const HODProfileScreen(),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.purpleAccent,
        unselectedItemColor: Colors.grey,
        elevation: 0,
        selectedLabelStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          color: Colors.purpleAccent,
        ),
        unselectedLabelStyle: GoogleFonts.inter(color: Colors.grey),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.check_circle_outline), label: "Attendance"),
          BottomNavigationBarItem(
              icon: Icon(Icons.grade_outlined), label: "Marks"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }
}



