import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HODMarksEntryScreen extends StatelessWidget {
  const HODMarksEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

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
            Text("Marks Entry",
                style: GoogleFonts.inter(
                    fontSize: 16, fontWeight: FontWeight.w600)),
            Text("Enter marks for your handling subjects",
                style: GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _subjectTile(context,
                subject: "Data Structures",
                code: "CS201",
                year: "2nd Year"),
            _subjectTile(context,
                subject: "Algorithms",
                code: "CS202",
                year: "3rd Year"),
            _subjectTile(context,
                subject: "Database Systems",
                code: "CS301",
                year: "Final Year"),
            _subjectTile(context,
                subject: "Operating Systems",
                code: "CS302",
                year: "3rd Year"),
          ],
        ),
      ),
    );
  }

  Widget _subjectTile(BuildContext context,
      {required String subject,
      required String code,
      required String year}) {
    return InkWell(
      onTap: () => _openMarksPopup(context, subject),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.menu_book, color: Colors.blue),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(subject,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600)),
                  Text("$code • $year",
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

  void _openMarksPopup(BuildContext context, String subject) {
    String selectedExam = "Select exam type";
    bool showExamList = false;

    final examTypes = [
      "Internal Assessment 1",
      "Internal Assessment 2",
      "Model Exam",
      "Assignment"
    ];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("$subject - Marks Entry",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600)),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    Text("Enter or edit marks for students",
                        style: GoogleFonts.inter(
                            fontSize: 12, color: Colors.grey)),
                    const SizedBox(height: 14),

                    // ===== EXAM TYPE SELECTOR (FIXED) =====
                    InkWell(
                      onTap: () =>
                          setState(() => showExamList = !showExamList),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text(selectedExam,
                                style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: selectedExam ==
                                            "Select exam type"
                                        ? Colors.grey
                                        : Colors.black)),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),

                    if (showExamList) ...[
                      const SizedBox(height: 6),
                      Container(
                        height: 160, // ✅ list stays inside popup
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Colors.grey.shade300),
                        ),
                        child: ListView.builder(
                          itemCount: examTypes.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              dense: true,
                              title: Text(examTypes[index],
                                  style: GoogleFonts.inter(fontSize: 13)),
                              onTap: () {
                                setState(() {
                                  selectedExam = examTypes[index];
                                  showExamList = false;
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],

                    const SizedBox(height: 16),

                    _studentRow("Student 1"),
                    _studentRow("Student 2"),
                    _studentRow("Student 3"),

                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding:
                              const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        icon:
                            const Icon(Icons.upload, color: Colors.white),
                        label: const Text("Upload to Student Portal",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Marks uploaded successfully")),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  Widget _studentRow(String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(child: Text(name)),
          SizedBox(
            width: 80,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Marks",
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
