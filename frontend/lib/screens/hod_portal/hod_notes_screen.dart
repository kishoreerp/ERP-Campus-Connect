import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'hod_subject_notes_screen.dart';

class HODNotesScreen extends StatelessWidget {
  const HODNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(24),
                    child: const Padding(
                      padding: EdgeInsets.all(6),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Notes",
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Select a subject to manage notes",
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // SUBJECT LIST
              _subjectTile(
                context,
                title: "Data Structures",
                subtitle: "CS201 • 2nd Year",
                count: "3 notes",
              ),
              _subjectTile(
                context,
                title: "Algorithms",
                subtitle: "CS202 • 3rd Year",
                count: "2 notes",
              ),
              _subjectTile(
                context,
                title: "Database Systems",
                subtitle: "CS301 • Final Year",
                count: "3 notes",
              ),
              _subjectTile(
                context,
                title: "Operating Systems",
                subtitle: "CS302 • 3rd Year",
                count: "1 note",
              ),
            ],
          ),
        ),
      ),
    );
  }

 Widget _subjectTile(
  BuildContext context, {
  required String title,
  required String subtitle,
  required String count,
}) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const HODSubjectNotesScreen(
            subjectName: "Data Structures",
            subjectCode: "CS201 • 2nd Year",
          ),
        ),
      );
    },
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.menu_book, color: Colors.blue),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              count,
              style: GoogleFonts.inter(fontSize: 11),
            ),
          ),

          const SizedBox(width: 6),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    ),
  );
}

}
