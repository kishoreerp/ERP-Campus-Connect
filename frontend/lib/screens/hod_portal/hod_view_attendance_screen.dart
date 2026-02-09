import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HODViewAttendanceScreen extends StatelessWidget {
  const HODViewAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "View Attendance",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              "Select a year to view subjects",
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),

      // ================= BODY =================
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _YearTile(title: "1st Year", students: "120 Students"),
          _YearTile(title: "2nd Year", students: "115 Students"),
          _YearTile(title: "3rd Year", students: "110 Students"),
          _YearTile(title: "Final Year", students: "105 Students"),
        ],
      ),
    );
  }
}

// =======================================================
// YEAR TILE
// =======================================================

class _YearTile extends StatelessWidget {
  final String title;
  final String students;

  const _YearTile({
    required this.title,
    required this.students,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          useRootNavigator: true,
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.45),
          builder: (_) => _SubjectsDialog(year: title),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F2FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.school, color: Colors.blue),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600)),
                Text(students,
                    style: GoogleFonts.inter(
                        fontSize: 12, color: Colors.grey)),
              ],
            ),
            const Spacer(),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

// =======================================================
// SUBJECT LIST DIALOG
// =======================================================

class _SubjectsDialog extends StatelessWidget {
  final String year;

  const _SubjectsDialog({required this.year});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$year - Subjects",
                  style: GoogleFonts.inter(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: const [
                  _SubjectTile("Data Structures", "CS201"),
                  _SubjectTile("Algorithms", "CS202"),
                  _SubjectTile("Database Systems", "CS301"),
                  _SubjectTile("Operating Systems", "CS302"),
                  _SubjectTile("Computer Networks", "CS401"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =======================================================
// SUBJECT TILE
// =======================================================

class _SubjectTile extends StatelessWidget {
  final String subject;
  final String code;

  const _SubjectTile(this.subject, this.code);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          useRootNavigator: true,
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.45),
          builder: (_) => _AttendanceDetailsDialog(
            subject: subject,
            code: code,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.book, color: Colors.purple),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(subject,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600)),
                  Text(code,
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

// =======================================================
// ATTENDANCE DETAILS DIALOG
// =======================================================

class _AttendanceDetailsDialog extends StatelessWidget {
  final String subject;
  final String code;

  const _AttendanceDetailsDialog({
    required this.subject,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 60),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(subject,
                        style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                    Text("$code - Attendance Details",
                        style: GoogleFonts.inter(
                            fontSize: 12, color: Colors.grey)),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 12),

            _row("Roll No", "Name", "Status", header: true),
            const Divider(),

            _row("SLEC2025001", "Aarav Sharma", "Present"),
            _row("SLEC2025002", "Priya Patel", "Present"),
            _row("SLEC2025003", "Rohan Kumar", "Present"),
            _row("SLEC2025004", "Ananya Singh", "Present"),
            _row("SLEC2024001", "Vikram Reddy", "Present"),
          ],
        ),
      ),
    );
  }

  Widget _row(String roll, String name, String status,
      {bool header = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              roll,
              style: GoogleFonts.inter(
                  fontWeight:
                      header ? FontWeight.w600 : FontWeight.w400),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              name,
              style: GoogleFonts.inter(
                  fontWeight:
                      header ? FontWeight.w600 : FontWeight.w400),
            ),
          ),
          Expanded(
            flex: 3,
            child: header
                ? Text(status,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600))
                : Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      status,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.green),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
