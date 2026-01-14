import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'examcell_home_screen.dart';
import 'examcell_exam_screen.dart';
import 'examcell_result_screen.dart';
import 'examcell_profile_screen.dart';

class ExamCellPortalScreen extends StatefulWidget {
  const ExamCellPortalScreen({super.key, required username});

  @override
  State<ExamCellPortalScreen> createState() => _ExamCellPortalScreenState();
}

class _ExamCellPortalScreenState extends State<ExamCellPortalScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = const [
      ExamCellHomeScreen(),
      ExamCellExamScreen(),
      ExamCellResultScreen(),
      ExamCellProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ✅ COMMON HEADER (same as Staff Portal)
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
                    const Icon(Icons.school, color: Colors.orangeAccent),
              ),
              const SizedBox(width: 10),
              Text(
                'Exam Cell Portal',
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
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.grey,
        elevation: 0,
        selectedLabelStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          color: Colors.orangeAccent,
        ),
        unselectedLabelStyle: GoogleFonts.inter(color: Colors.grey),
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
