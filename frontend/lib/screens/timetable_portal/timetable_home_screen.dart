import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TTHomeScreen(username: "Prof. John Smith"),
    );
  }
}

////////////////////////////////////////////////////////////
/// HOME SCREEN
////////////////////////////////////////////////////////////

class TTHomeScreen extends StatelessWidget {
  final String username;

  const TTHomeScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildQuickActions(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 26,
            backgroundColor: Colors.white,
            child: Icon(Icons.person_outline,
                color: Colors.blueAccent, size: 30),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, $username!',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'TT12345 • Time Table Admin',
                style: GoogleFonts.inter(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ////////////////////////////////////////////////////////////
  /// QUICK ACTIONS (ERROR-FREE VERSION)
  ////////////////////////////////////////////////////////////

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Actions",
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),

        /// Academic Calendar
        _ProgramCard(
          icon: Icons.calendar_month,
          iconColor: Colors.purple,
          backgroundColor: const Color(0xFFF3E8FF),
          title: "Academic Calendar",
          subtitle: "View and manage academic events",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const AcademicCalendarScreen()),
            );
          },
        ),

        const SizedBox(height: 16),

        /// Subject Schedule
        _ProgramCard(
          icon: Icons.menu_book,
          iconColor: Colors.orange,
          backgroundColor: const Color(0xFFFFF3E0),
          title: "Subject Schedule",
          subtitle: "Manage subject schedules",
          onTap: () {},
        ),
      ],
    );
  }
}

////////////////////////////////////////////////////////////
/// ACADEMIC CALENDAR PAGE
////////////////////////////////////////////////////////////

class AcademicCalendarScreen extends StatelessWidget {
  const AcademicCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _BaseScaffold(
      title: "Academic Calendar",
      subtitle: "Select program type",
      children: [
        _ProgramCard(
          icon: Icons.school,
          iconColor: Colors.blue,
          backgroundColor: const Color(0xFFE3F2FD),
          title: "Under Graduate (UG)",
          subtitle: "View UG calendar",
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const UGCalendarScreen()));
          },
        ),
        const SizedBox(height: 16),
        _ProgramCard(
          icon: Icons.school,
          iconColor: Colors.purple,
          backgroundColor: const Color(0xFFF3E8FF),
          title: "Post Graduate (PG)",
          subtitle: "View PG calendar",
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const PGCalendarScreen()));
          },
        ),
      ],
    );
  }
}

////////////////////////////////////////////////////////////
/// UG YEAR PAGE
////////////////////////////////////////////////////////////

class UGCalendarScreen extends StatelessWidget {
  const UGCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _BaseScaffold(
      title: "UG Academic Calendar",
      subtitle: "Select year",
      children: [
        _ugYear(context, "1st Year"),
        _ugYear(context, "2nd Year"),
        _ugYear(context, "3rd Year"),
        _ugYear(context, "Final Year"),
      ],
    );
  }

  Widget _ugYear(BuildContext context, String year) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: _ProgramCard(
        icon: Icons.calendar_month,
        iconColor: Colors.green,
        backgroundColor: const Color(0xFFE8F5E9),
        title: year,
        subtitle: "View $year calendar",
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => DepartmentScreen(title: "UG $year")));
        },
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// DEPARTMENT PAGE (FOR UG YEARS)
////////////////////////////////////////////////////////////

class DepartmentScreen extends StatelessWidget {
  final String title;

  const DepartmentScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return _BaseScaffold(
      title: title,
      subtitle: "Select department",
      children: const [
        DepartmentCard("Computer Science", "CSC Department",
            Colors.blue, Color(0xFFE3F2FD)),
        DepartmentCard("Information Technology", "IT Department",
            Colors.green, Color(0xFFE8F5E9)),
        DepartmentCard("Cyber Security", "Cyber Department",
            Colors.red, Color(0xFFFFEBEE)),
        DepartmentCard("AI & Data Science", "AIDS Department",
            Colors.deepPurple, Color(0xFFF3E8FF)),
        DepartmentCard("Electronics & Communication", "ECE Department",
            Colors.orange, Color(0xFFFFF3E0)),
      ],
    );
  }
}

class DepartmentCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color iconColor;
  final Color bgColor;

  const DepartmentCard(
      this.title, this.subtitle, this.iconColor, this.bgColor,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: _ProgramCard(
        icon: Icons.menu_book,
        iconColor: iconColor,
        backgroundColor: bgColor,
        title: title,
        subtitle: subtitle,
        onTap: () {},
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// PG PROGRAM PAGE
////////////////////////////////////////////////////////////

class PGCalendarScreen extends StatelessWidget {
  const PGCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _BaseScaffold(
      title: "PG Academic Calendar",
      subtitle: "Select program",
      children: [
        _ProgramCard(
          icon: Icons.school,
          iconColor: Colors.purple,
          backgroundColor: const Color(0xFFF3E8FF),
          title: "MBA",
          subtitle: "Master of Business Administration",
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const PGYearScreen(title: "MBA Academic Calendar")));
          },
        ),
        const SizedBox(height: 16),
        _ProgramCard(
          icon: Icons.school,
          iconColor: Colors.blue,
          backgroundColor: const Color(0xFFE3F2FD),
          title: "M.E",
          subtitle: "Master of Engineering",
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const PGYearScreen(title: "ME Academic Calendar")));
          },
        ),
      ],
    );
  }
}

////////////////////////////////////////////////////////////
/// PG YEAR PAGE (MBA & ME)
////////////////////////////////////////////////////////////

class PGYearScreen extends StatelessWidget {
  final String title;

  const PGYearScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return _BaseScaffold(
      title: title,
      subtitle: "Select year",
      children: const [
        YearCard("1st Year"),
        YearCard("2nd Year"),
      ],
    );
  }
}

class YearCard extends StatelessWidget {
  final String year;

  const YearCard(this.year, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: _ProgramCard(
        icon: Icons.calendar_month,
        iconColor: Colors.green,
        backgroundColor: const Color(0xFFE8F5E9),
        title: year,
        subtitle: "View $year calendar",
        onTap: () {},
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// BASE SCAFFOLD
////////////////////////////////////////////////////////////

class _BaseScaffold extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;

  const _BaseScaffold({
    required this.title,
    required this.subtitle,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                      Text(subtitle,
                          style: GoogleFonts.inter(
                              fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(children: children),
              ),
            )
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// REUSABLE CARD
////////////////////////////////////////////////////////////

class _ProgramCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ProgramCard({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: GoogleFonts.inter(
                          fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
