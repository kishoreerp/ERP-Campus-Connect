import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'admission_home_screen.dart';
import 'admission_student_screen.dart';
import 'admission_screen.dart';
import 'admission_profile_screen.dart';

class AdmissionPortalScreen extends StatefulWidget {
  final String username;

  const AdmissionPortalScreen({
    super.key,
    required this.username,
  });

  @override
  State<AdmissionPortalScreen> createState() =>
      _AdmissionPortalScreenState();
}

class _AdmissionPortalScreenState extends State<AdmissionPortalScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = const [
      AdmissionHomeScreen(),
      AdmissionScreen(),
      AdmissionStudentScreen(),
      AdmissionProfileScreen(),
      Center(child: Text('Profile')), // replace later if needed
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ✅ COMMON HEADER (SAME AS STAFF)
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
                    const Icon(Icons.school, color: Colors.green),
              ),
              const SizedBox(width: 10),
              Text(
                'Admission Portal',
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
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        elevation: 0,
        selectedLabelStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          color: Colors.green,
        ),
        unselectedLabelStyle: GoogleFonts.inter(color: Colors.grey),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.school_outlined), label: 'Admission'),
          BottomNavigationBarItem(
              icon: Icon(Icons.group_outlined), label: 'Student'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
