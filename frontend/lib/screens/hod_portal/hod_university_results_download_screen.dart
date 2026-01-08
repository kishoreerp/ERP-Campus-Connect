import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UniversityResultsDownloadScreen extends StatelessWidget {
  final String department;

  const UniversityResultsDownloadScreen({
    super.key,
    required this.department,
  });

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
              department,
              style: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              "Download all year university results",
              style:
                  GoogleFonts.inter(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),

      // ================= BODY =================
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ================= DOWNLOAD CARD =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blueAccent),
              ),
              child: Column(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.shade100,
                    ),
                    child: const Icon(Icons.download,
                        size: 32, color: Colors.blue),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "All Year University Results",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Download comprehensive university results for all years",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "$department • Academic Year 2024-25",
                    style: GoogleFonts.inter(
                        fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),

                  // DOWNLOAD BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding:
                            const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(Icons.download, color: Colors.white),
                      label: const Text(
                        "Download PDF - All Year Results",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text("University results downloaded"),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ================= INFO CARD =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Download Information",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  _info("Includes results for 1st, 2nd, 3rd, and Final Year"),
                  _info("Contains both Semester I and Semester II results"),
                  _info(
                      "Format: Detailed PDF with student-wise marks"),
                  _info("Department: $department"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _info(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline,
              size: 16, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text,
                style:
                    GoogleFonts.inter(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
