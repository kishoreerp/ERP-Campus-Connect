import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/screens/principal_portal/Principal_profile_screen.dart';
import 'principal_home_screen.dart';
import 'principal_staff_screen.dart';
import 'principal_student_screen.dart';

class PrincipalPortalScreen extends StatefulWidget {
  final String username;

  const PrincipalPortalScreen({
    super.key,
    required this.username,
  });

  @override
  State<PrincipalPortalScreen> createState() =>
      _PrincipalPortalScreenState();
}

class _PrincipalPortalScreenState extends State<PrincipalPortalScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      PrincipalHomeScreen(username: widget.username),
      const PrincipalStaffScreen(),
      const PrincipalStudentScreen(),
      const PrincipalProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ✅ COMMON HEADER
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                height: 34,
                width: 34,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Text(
                  'SLEC',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Principal Portal',
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
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        elevation: 0,
        selectedLabelStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          color: Colors.indigo,
        ),
        unselectedLabelStyle: GoogleFonts.inter(color: Colors.grey),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: "Staff",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            label: "Student",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}