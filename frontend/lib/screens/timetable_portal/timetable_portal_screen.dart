import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// IMPORT SCREENS
import 'timetable_home_screen.dart';
import 'timetable_student_screen.dart';
import 'timetable_staff_screen.dart';
import 'timetable_profile_screen.dart';

class TimetablePortalScreen extends StatefulWidget {
  final String username;

  const TimetablePortalScreen({
    super.key,
    required this.username,
  });

  @override
  State<TimetablePortalScreen> createState() =>
      _TimetablePortalScreenState();
}

class _TimetablePortalScreenState extends State<TimetablePortalScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
     super.initState();
     _pages = [
      TTHomeScreen(username: widget.username),
       const TTStudentScreen(),
      const TTStaffScreen(),
      const TimetableProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ✅ COMMON HEADER (SAME AS STAFF / EXAM / HOD)
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Image.asset(
                'assets/slec_logo.png',
                height: 34,
                width: 34,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.school, color: Colors.blueAccent),
              ),
              const SizedBox(width: 10),
              Text(
                'Timetable Portal',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),

      body: SafeArea(child: _pages[_selectedIndex]),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        elevation: 0,
        selectedLabelStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          color: Colors.blueAccent,
        ),
        unselectedLabelStyle: GoogleFonts.inter(color: Colors.grey),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            label: 'Student',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'Staff',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
