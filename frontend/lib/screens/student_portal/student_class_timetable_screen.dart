import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentClassTimetableScreen extends StatefulWidget {
  const StudentClassTimetableScreen({super.key});

  @override
  State<StudentClassTimetableScreen> createState() =>
      _StudentClassTimetableScreenState();
}

class _StudentClassTimetableScreenState
    extends State<StudentClassTimetableScreen> {
  final List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  int selectedIndex = 4; // Friday

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Class Timetable",
            style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Semester 5",
                    style: GoogleFonts.inter(
                        fontSize: 14, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 16),

            // Day selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(days.length, (index) {
                final isSelected = selectedIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => selectedIndex = index),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.deepPurple
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      days[index],
                      style: GoogleFonts.inter(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),
            _todayHeader("Friday"),
            const SizedBox(height: 12),

            _subjectCard("9:00 to 9:50", "Software Engineering", "CS505",
                "Dr. Michael Davis", "Integrated"),
            _subjectCard("9:50 to 10:40", "Database Systems", "CS503",
                "Dr. Lisa Wong", "Integrated"),
            _breakCard("Break Time", "10:40 - 11:00", Colors.orange.shade50),
            _subjectCard("11:00 to 11:50", "Web Development", "CS504",
                "Mr. James Brown", ""),
            _subjectCard("11:50 to 12:40", "Data Structures", "CS501",
                "Dr. Sarah Johnson", "Integrated"),
            _breakCard("Lunch Break", "12:40 - 1:30", Colors.green.shade50),
            _subjectCard("1:30 to 2:20", "Algorithms", "CS502",
                "Prof. David Lee", ""),
            _subjectCard("2:20 to 3:10", "SE Lab", "", "", "Lab"),

            const SizedBox(height: 20),
            _quickSummary(),
          ],
        ),
      ),
    );
  }

  Widget _todayHeader(String day) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Schedule for $day",
              style: GoogleFonts.inter(color: Colors.white, fontSize: 16)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text("Today",
                style: GoogleFonts.inter(
                    color: Colors.deepPurple,
                    fontSize: 13,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _subjectCard(String time, String subject, String code, String prof,
      String tag) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              time,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.blue.shade800,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subject,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600, fontSize: 15)),
                Text("$code • $prof",
                    style: GoogleFonts.inter(color: Colors.grey[700])),
                if (tag.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(tag,
                        style: GoogleFonts.inter(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w600,
                            fontSize: 11)),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _breakCard(String title, String time, Color bgColor) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          const Icon(Icons.free_breakfast_outlined, color: Colors.orange),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600, color: Colors.black87)),
              Text(time,
                  style: GoogleFonts.inter(color: Colors.grey[700], fontSize: 13)),
            ],
          )
        ],
      ),
    );
  }

  Widget _quickSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _summaryItem("5", "Classes"),
          _summaryItem("1", "Labs"),
          _summaryItem("5", "Total Subjects"),
        ],
      ),
    );
  }

  Widget _summaryItem(String count, String label) {
    return Column(
      children: [
        Text(count,
            style: GoogleFonts.inter(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
        Text(label,
            style: GoogleFonts.inter(color: Colors.grey[700], fontSize: 13)),
      ],
    );
  }
}
