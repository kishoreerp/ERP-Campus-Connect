import 'package:flutter/material.dart';

import 'admission_home_screen.dart';
import 'admission_student_screen.dart';
import 'admission_screen.dart';

class AdmissionPortalScreen extends StatefulWidget {
  const AdmissionPortalScreen({super.key, required username});

  @override
  State<AdmissionPortalScreen> createState() =>
      _AdmissionPortalScreenState();
}

class _AdmissionPortalScreenState extends State<AdmissionPortalScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    AdmissionHomeScreen(), 
    AdmissionScreen(),
    AdmissionStudentScreen(),
    Center(child: Text('Profile')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedIndex]),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF2563EB),
        unselectedItemColor: Colors.grey,
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
