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
      backgroundColor: Colors.white,
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

      Row(
        children: [
          _quickAction(
            context,
            Icons.calendar_month_outlined,
            "Academic Calendar",
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AcademicCalendarScreen(),
                ),
              );
            },
          ),
          const SizedBox(width: 12),
          _quickAction(
            context,
            Icons.menu_book_outlined,
            "Subject Schedule",
            () {},
          ),
        ],
      ),
    ],
  );
}
Widget _quickAction(
  BuildContext context,
  IconData icon,
  String title,
  VoidCallback onTap,
) {
  return Expanded(
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 28, color: Colors.black87),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    ),
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
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 6),

/// BACK BUTTON + TITLE
Row(
  children: [
    GestureDetector(
      onTap: () => Navigator.pop(context),
      child: const Icon(Icons.arrow_back),
    ),
    const SizedBox(width: 12),
    Text(
      'Academic Calendar',
      style: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
  ],
),

const SizedBox(height: 4),

Text(
  'View and manage academic calendar',
  style: GoogleFonts.inter(
    fontSize: 12,
    color: Colors.grey,
  ),
),

            const SizedBox(height: 20),

            /// =====================
            /// UNDERGRADUATE
            /// =====================
            Text(
              'Undergraduate',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),

            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _YearCard(
  title: '1st Year',
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AcademicSchedulingScreen(
          title: "UG 1st Year",
        ),
      ),
    );
  },
),
                _YearCard(
  title: '2nd Year',
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AcademicSchedulingScreen(
          title: "UG 2nd Year",
        ),
      ),
    );
  },
),
                _YearCard(
                  title: '3rd Year',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AcademicSchedulingScreen(
                          title: "UG 3rd Year",
                        ),
                      ),
                    );
                  },
                ),
                _YearCard(
                  title: '4th Year',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AcademicSchedulingScreen(
                          title: "UG 4th Year",
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 14),

            /// =====================
            /// POSTGRADUATE
            /// =====================
            Text(
              'Postgraduate',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),

            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _YearCard(
  title: '1st Year',
  isPostGraduate: true,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AcademicSchedulingScreen(
          title: "PG 1st Year",
        ),
      ),
    );
  },
),
                _YearCard(
                  title: '2nd Year',
                  isPostGraduate: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AcademicSchedulingScreen(
                          title: "PG 2nd Year",
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class _YearCard extends StatelessWidget {
  final String title;
  final bool isPostGraduate;
  final VoidCallback onTap;

  const _YearCard({
    required this.title,
    required this.onTap,
    this.isPostGraduate = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school,
              size: 28,
              color: isPostGraduate
                  ? Colors.purpleAccent
                  : Colors.blueAccent,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
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
        _ugYear(context, "4th Year"),
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
class AcademicSchedulingScreen extends StatefulWidget {
  final String title;

  const AcademicSchedulingScreen({super.key, required this.title});

  @override
  State<AcademicSchedulingScreen> createState() =>
      _AcademicSchedulingScreenState();
}

class _AcademicSchedulingScreenState
    extends State<AcademicSchedulingScreen> {

  int? semester;
  DateTime? startDate;
  DateTime? endDate;

  List<Map<String, dynamic>> holidays = [];
  List<Map<String, dynamic>> programs = [];

  int workingDays = 0;

  bool get isOdd =>
      semester != null && [1, 3, 5, 7].contains(semester);

  bool get isEven =>
      semester != null && [2, 4, 6, 8].contains(semester);

  Future<DateTime?> _pickDate(
      DateTime first, DateTime last) async {
    return await showDatePicker(
      context: context,
      firstDate: first,
      lastDate: last,
      initialDate: first,
    );
  }

  void _calculateWorkingDays() {
    if (startDate == null || endDate == null) return;

    int count = 0;

    for (DateTime date = startDate!;
        date.isBefore(endDate!.add(const Duration(days: 1)));
        date = date.add(const Duration(days: 1))) {

      if (date.weekday == DateTime.sunday) continue;

      bool isHoliday = holidays.any((h) {
        DateTime d = h["date"];
        return d.year == date.year &&
            d.month == date.month &&
            d.day == date.day;
      });

      if (!isHoliday) count++;
    }

    setState(() {
      workingDays = count;
    });
  }

  void _addEntry(bool isHoliday) async {
    if (startDate == null) return;

    TextEditingController controller =
        TextEditingController();
    DateTime? selectedDate;

    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title:
              Text(isHoliday ? "Add Holiday" : "Add Program"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () async {
                  final picked = await _pickDate(
                      startDate!,
                      endDate ?? DateTime(2035));
                  if (picked != null) {
                    selectedDate = picked;
                  }
                },
                child: const Text("Select Date"),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty &&
                    selectedDate != null) {

                  setState(() {
                    if (isHoliday) {
                      holidays.add({
                        "title": controller.text,
                        "date": selectedDate
                      });
                    } else {
                      programs.add({
                        "title": controller.text,
                        "date": selectedDate
                      });
                    }
                  });

                  Navigator.pop(context);
                }
              },
              child: const Text("Save"),
            )
          ],
        );
      },
    );

    _calculateWorkingDays();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
        title: Text(widget.title,
            style: GoogleFonts.inter()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              /// SEMESTER
              Text("Semester",
                  style: GoogleFonts.inter(
                      fontWeight:
                          FontWeight.w600)),
              const SizedBox(height: 8),

              DropdownButtonFormField<int>(
                decoration:
                    const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                value: semester,
                items: List.generate(
                  8,
                  (i) => DropdownMenuItem(
                    value: i + 1,
                    child: Text(
                        "Semester ${i + 1}"),
                  ),
                ),
                onChanged: (val) {
                  setState(() {
                    semester = val;
                  });
                },
              ),

              if (semester != null)
                Padding(
                  padding:
                      const EdgeInsets.only(
                          top: 8),
                  child: Text(
                    isOdd
                        ? "ODD Semester"
                        : "EVEN Semester",
                    style: GoogleFonts.inter(
                      fontWeight:
                          FontWeight.w600,
                      color: isOdd
                          ? Colors.blue
                          : Colors.purple,
                    ),
                  ),
                ),

              const SizedBox(height: 24),

              /// START DATE
              Text("Start Date",
                  style: GoogleFonts.inter(
                      fontWeight:
                          FontWeight.w600)),
              const SizedBox(height: 8),

              OutlinedButton(
                onPressed: () async {
                  final picked =
                      await _pickDate(
                          DateTime(2023),
                          DateTime(2035));
                  if (picked != null) {
                    setState(
                        () => startDate = picked);
                  }
                },
                child: Text(startDate == null
                    ? "Select Start Date"
                    : startDate!
                        .toString()
                        .split(' ')[0]),
              ),

              const SizedBox(height: 20),

              /// ADD HOLIDAY & PROGRAM
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        _addEntry(true),
                    child:
                        const Text("Add Holiday"),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () =>
                        _addEntry(false),
                    child:
                        const Text("Add Program"),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              ...holidays.map((e) => ListTile(
                    title: Text(
                        e["title"]),
                    subtitle: Text(
                        e["date"]
                            .toString()
                            .split(' ')[0]),
                  )),

              ...programs.map((e) => ListTile(
                    title: Text(
                        e["title"]),
                    subtitle: Text(
                        e["date"]
                            .toString()
                            .split(' ')[0]),
                  )),

              const SizedBox(height: 24),

              /// END DATE
              Text("End Date",
                  style: GoogleFonts.inter(
                      fontWeight:
                          FontWeight.w600)),
              const SizedBox(height: 8),

              OutlinedButton(
                onPressed: () async {
                  if (startDate == null)
                    return;

                  final picked =
                      await _pickDate(
                          startDate!,
                          DateTime(2035));
                  if (picked != null) {
                    setState(
                        () => endDate = picked);
                    _calculateWorkingDays();
                  }
                },
                child: Text(endDate == null
                    ? "Select End Date"
                    : endDate!
                        .toString()
                        .split(' ')[0]),
              ),

              const SizedBox(height: 20),

              if (workingDays > 0)
                Text(
                  "Working Days: $workingDays",
                  style: GoogleFonts.inter(
                      fontWeight:
                          FontWeight.w600),
                ),

              const SizedBox(height: 20),

              if (workingDays > 0)
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                          "Upload PDF"),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child:
                          ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                            "Upload Academic Calendar"),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
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

