import 'package:flutter/material.dart';

import 'examcell_home_screen.dart';
import 'examcell_exam_screen.dart';
import 'examcell_result_screen.dart';
import 'examcell_profile_screen.dart';

class ExamCellPortalScreen extends StatefulWidget {
  const ExamCellPortalScreen({super.key});

  @override
  State<ExamCellPortalScreen> createState() => _ExamCellPortalScreenState();
}

class _ExamCellPortalScreenState extends State<ExamCellPortalScreen> {
  int _selectedIndex = 1; // Exam tab default

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = const [
      ExamCellHomeScreen(),
      ExamCellExamScreen(), // your rewritten Exam UI
      ExamCellResultScreen(),
      ExamCellProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // ✅ SAME PATTERN AS STAFF PORTAL
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index != _selectedIndex) {
            setState(() => _selectedIndex = index);
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        selectedItemColor: const Color(0xFF2563EB),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined), label: 'Exam'),
          BottomNavigationBarItem(
              icon: Icon(Icons.description_outlined), label: 'Result'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
