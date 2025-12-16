import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentExamTimetableScreen extends StatelessWidget {
  const StudentExamTimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Exam Timetable",
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
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
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Semester 5",
                    style: GoogleFonts.inter(
                        fontSize: 14, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 16),

            // Exam title header card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("End Semester Examinations",
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text("October 2025",
                      style: GoogleFonts.inter(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Exams List
            _examCard("15", "Data Structures", "CS501",
                "Monday, October 15, 2025", "9:00 AM – 12:00 PM (3 hours)"),
            _examCard("17", "Algorithms", "CS502",
                "Wednesday, October 17, 2025", "9:00 AM – 12:00 PM (3 hours)"),
            _examCard("19", "Database Systems", "CS503",
                "Friday, October 19, 2025", "9:00 AM – 12:00 PM (3 hours)"),
            _examCard("21", "Web Development", "CS504",
                "Sunday, October 21, 2025", "9:00 AM – 12:00 PM (3 hours)"),
            _examCard("23", "Software Engineering", "CS505",
                "Tuesday, October 23, 2025", "9:00 AM – 12:00 PM (3 hours)"),

            const SizedBox(height: 20),

            // Important Instructions
            Text("Important Instructions",
                style: GoogleFonts.inter(
                    fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _bulletText("Report to exam hall 15 minutes before exam time"),
                  _bulletText("Bring your ID card and hall ticket"),
                  _bulletText(
                      "Electronic devices are not allowed in the exam hall"),
                  _bulletText(
                      "Read all instructions on the question paper carefully"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _examCard(String date, String subject, String code, String day,
      String time) {
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
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Date box
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                date,
                style: GoogleFonts.inter(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Exam details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subject,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600, fontSize: 15)),
                Text(code,
                    style: GoogleFonts.inter(
                        color: Colors.grey[700], fontSize: 13)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined,
                        size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(day,
                        style: GoogleFonts.inter(
                            color: Colors.grey[700], fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.access_time_outlined,
                        size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(time,
                        style: GoogleFonts.inter(
                            color: Colors.grey[700], fontSize: 13)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bulletText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ",
              style: TextStyle(fontSize: 16, color: Colors.black87)),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                color: Colors.grey[800],
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
