import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'hod_university_results_download_screen.dart';

class HODUniversityResultsScreen extends StatelessWidget {
  const HODUniversityResultsScreen({super.key});

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
              "University Results",
              style: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              "Select a department",
              style:
                  GoogleFonts.inter(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),

      // ================= BODY =================
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _deptTile(
            context,
            title: "Computer Science Engineering",
            code: "CSE",
          ),
          _deptTile(
            context,
            title: "Information Technology",
            code: "IT",
          ),
          _deptTile(
            context,
            title: "Cyber Security",
            code: "CYBER",
          ),
          _deptTile(
            context,
            title: "Artificial Intelligence & Data Science",
            code: "AIDS",
          ),
          _deptTile(
            context,
            title: "Electronics & Communication Engineering",
            code: "ECE",
          ),
        ],
      ),
    );
  }

  // ================= DEPARTMENT TILE =================
  Widget _deptTile(
    BuildContext context, {
    required String title,
    required String code,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                UniversityResultsDownloadScreen(department: title),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Icon(Icons.school_outlined),
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
                  Text("Department Code: $code",
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
