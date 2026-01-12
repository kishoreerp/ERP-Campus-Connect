import 'package:flutter/material.dart';

// IMPORT SCREENS (make sure paths are correct)
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
      /// ❗ Home screen NEEDS username
      TTHomeScreen(username: widget.username),

      /// ❗ Other screens are const
      const TTStudentScreen(),
      const TTStaffScreen(),
      const TimetableProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
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
