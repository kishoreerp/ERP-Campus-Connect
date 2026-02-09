import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HODDepartmentMarksScreen extends StatelessWidget {
  const HODDepartmentMarksScreen({super.key});

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
              "Department Marks",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              "View all subjects marks year-wise",
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),

      // ================= BODY =================
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ================= FILTER =================
            DropdownButtonFormField<String>(
              value: "All Years",
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              items: const [
                DropdownMenuItem(value: "All Years", child: Text("All Years")),
                DropdownMenuItem(value: "1st Year", child: Text("1st Year")),
                DropdownMenuItem(value: "2nd Year", child: Text("2nd Year")),
                DropdownMenuItem(value: "3rd Year", child: Text("3rd Year")),
                DropdownMenuItem(value: "Final Year", child: Text("Final Year")),
              ],
              onChanged: (value) {},
            ),

            const SizedBox(height: 16),

            // ================= SUBJECT CARDS =================
            _subjectCard(
              subject: "Data Structures",
              code: "CS201",
              year: "2nd Year",
            ),
            _subjectCard(
              subject: "Algorithms",
              code: "CS202",
              year: "3rd Year",
            ),
            _subjectCard(
              subject: "Database Systems",
              code: "CS301",
              year: "Final Year",
            ),
            _subjectCard(
              subject: "Operating Systems",
              code: "CS302",
              year: "3rd Year",
            ),
          ],
        ),
      ),
    );
  }

  // ===================================================================
  // ================= SUBJECT CARD ====================================
  // ===================================================================

  Widget _subjectCard({
    required String subject,
    required String code,
    required String year,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "$code • $year",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              // VIEW BUTTON
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.remove_red_eye_outlined, size: 18),
                label: const Text("View"),
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // DOWNLOAD BUTTON
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download_outlined),
              label: const Text("Download"),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
