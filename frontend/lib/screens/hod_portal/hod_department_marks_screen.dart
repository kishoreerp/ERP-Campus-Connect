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

            _subjectCard(
              context,
              subject: "Data Structures",
              code: "CS201",
              year: "2nd Year",
            ),
            _subjectCard(
              context,
              subject: "Algorithms",
              code: "CS202",
              year: "3rd Year",
            ),
            _subjectCard(
              context,
              subject: "Database Systems",
              code: "CS301",
              year: "Final Year",
            ),
            _subjectCard(
              context,
              subject: "Operating Systems",
              code: "CS302",
              year: "3rd Year",
            ),
          ],
        ),
      ),
    );
  }

  // ================= SUBJECT CARD =================
  Widget _subjectCard(
    BuildContext context, {
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
  onPressed: () {
    _showSubjectDetailsPopup(
      context,
      subject: subject,
      code: code,
      year: year,
    );
  },
  icon: const Icon(
    Icons.remove_red_eye_outlined,
    size: 18,
  ),
  label: const Text("View"),
),
            ],
          ),

          const SizedBox(height: 12),

          // DOWNLOAD BUTTON
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                _showDownloadSuccessDialog(context);
              },
              icon: const Icon(Icons.download_outlined),
              label: const Text("Download"),
            ),
          ),
        ],
      ),
    );
  }

  // ================= DOWNLOAD SUCCESS DIALOG =================
  void _showDownloadSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 60,
            ),
            const SizedBox(height: 16),
            Text(
              "Download Successful!",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
void _showSubjectDetailsPopup(
  BuildContext context, {
  required String subject,
  required String code,
  required String year,
}) {
  final List<Map<String, String>> students = [
    {"name": "Arun", "ia1": "18", "ia2": "20", "model": "45"},
    {"name": "Priya", "ia1": "17", "ia2": "19", "model": "43"},
    {"name": "Karthik", "ia1": "20", "ia2": "18", "model": "48"},
    {"name": "Divya", "ia1": "16", "ia2": "17", "model": "40"},
    {"name": "Rahul", "ia1": "19", "ia2": "18", "model": "44"},
    {"name": "Sneha", "ia1": "15", "ia2": "16", "model": "38"},
    {"name": "Vikram", "ia1": "20", "ia2": "19", "model": "49"},
    {"name": "Anitha", "ia1": "18", "ia2": "17", "model": "42"},
    {"name": "Manoj", "ia1": "14", "ia2": "15", "model": "35"},
    {"name": "Keerthi", "ia1": "19", "ia2": "20", "model": "47"},
    {"name": "Suresh", "ia1": "16", "ia2": "18", "model": "41"},
    {"name": "Lakshmi", "ia1": "17", "ia2": "16", "model": "39"},
    {"name": "Sneha", "ia1": "15", "ia2": "16", "model": "38"},
    {"name": "Vikram", "ia1": "20", "ia2": "19", "model": "49"},
    {"name": "Anitha", "ia1": "18", "ia2": "17", "model": "42"},
    {"name": "Manoj", "ia1": "14", "ia2": "15", "model": "35"},
    {"name": "Keerthi", "ia1": "19", "ia2": "20", "model": "47"},
    {"name": "Suresh", "ia1": "16", "ia2": "18", "model": "41"},
    {"name": "Lakshmi", "ia1": "17", "ia2": "16", "model": "39"},
  ];

  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 500, // fixed height for scroll
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FD), // soft modern background
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔹 HEADER WITH CLOSE ICON
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    subject,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close,
                    size: 22,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            Text(
              "Subject Code: $code",
              style: GoogleFonts.inter(
                fontSize: 13,
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 16),

            /// 🔹 TABLE HEADER
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: const [
                  Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text("Name",
                            style:
                                TextStyle(fontWeight: FontWeight.w600)),
                      )),
                  Expanded(
                      child: Text("IA1",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontWeight: FontWeight.w600))),
                  Expanded(
                      child: Text("IA2",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontWeight: FontWeight.w600))),
                  Expanded(
                      child: Text("Model",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontWeight: FontWeight.w600))),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// 🔹 SCROLLABLE STUDENT LIST
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];

                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8),
                              child: Text(student["name"]!),
                            )),
                        Expanded(
                            child: Text(student["ia1"]!,
                                textAlign: TextAlign.center)),
                        Expanded(
                            child: Text(student["ia2"]!,
                                textAlign: TextAlign.center)),
                        Expanded(
                            child: Text(student["model"]!,
                                textAlign: TextAlign.center)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
  
}

Widget _studentRow(
  String name,
  String ia1,
  String ia2,
  String model,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Expanded(flex: 3, child: Text(name)),
        Expanded(child: Text(ia1, textAlign: TextAlign.center)),
        Expanded(child: Text(ia2, textAlign: TextAlign.center)),
        Expanded(child: Text(model, textAlign: TextAlign.center)),
      ],
    ),
  );
}


// ================= SUBJECT DETAILS SCREEN =================

class SubjectDetailsScreen extends StatelessWidget {
  final String subject;
  final String code;
  final String year;

  const SubjectDetailsScreen({
    super.key,
    required this.subject,
    required this.code,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subject),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subject,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text("Subject Code: $code"),
            Text("Year: $year"),
            const SizedBox(height: 20),
            const Text(
              "Here you can display subject marks, student list, statistics, etc.",
            ),
          ],
        ),
      ),
    );
  }
}