// lib/screens/staff_portal/internal_assessment1_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InternalAssessment2Screen extends StatelessWidget {
const InternalAssessment2Screen({super.key});

  // sample subjects (you can replace with your real data)
  final List<_SubjectItem> subjects = const [
    _SubjectItem(title: 'Data Structures', code: 'CS501', year: '2nd Year'),
    _SubjectItem(title: 'Algorithms', code: 'CS502', year: '3rd Year'),
    _SubjectItem(title: 'Database Systems', code: 'CS503', year: 'Final Year'),
    _SubjectItem(title: 'Web Development', code: 'CS504', year: '1st Year'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black87),
        title: Text('Internal Assessment 2',
            style: GoogleFonts.inter(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: ListView.separated(
          itemCount: subjects.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final s = subjects[index];
            return _subjectCard(context, s);
          },
        ),
      ),
    );
  }

  Widget _subjectCard(BuildContext context, _SubjectItem s) {
    return InkWell(
      onTap: () {
        // open marks popup for this subject (maxMarks set to 50 like screenshot)
        _showMarksDialog(context, subject: s.title, code: s.code, year: s.year, maxMarks: 50);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.book_outlined, color: Colors.blue),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.title,
                        style: GoogleFonts.inter(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text('${s.code} • ${s.year}',
                        style: GoogleFonts.inter(color: Colors.grey[700], fontSize: 13)),
                  ]),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // MARKS DIALOG
  void _showMarksDialog(BuildContext context,
      {required String subject,
      required String code,
      required String year,
      required int maxMarks}) {
    // sample students list (45 items like screenshot)
    final List<_Student> students = List.generate(45, (i) {
      final idx = i + 1;
      final roll = idx <= 30
          ? 'CSE${idx.toString().padLeft(3, '0')}'
          : 'IT${(idx - 30).toString().padLeft(3, '0')}';
      final names = [
        'Aarav Kumar',
        'Advait Sharma',
        'Ananya Patel',
        'Arjun Reddy',
        'Diya Singh',
        'Ishaan Gupta',
        'Kavya Nair',
        'Krishna Iyer',
        'Meera Desai',
        'Nisha Joshi',
        'Pranav Mehta',
        'Riya Verma',
        'Rohan Das',
        'Pooja Joshi',
        'Rakesh Mehta',
        'Simran Verma',
        'Tarun Das',
        'Varun Agarwal',
        'Zoya Prasad',
        'Ganesh Iyer',
        'Harsha Nair',
        'Indra Desai',
        'Jayashree Joshi',
        'Karthik Mehta',
        'Latha Verma',
        'Ramesh Patel',
        'Savitri Agarwal',
        'Suresh Deshmukh',
        'Tulasi Khan',
        'Venkat Saxena',
        'Yasmin Prasad',
        'Aman Gupta',
        'Ritu Patel',
        'Sunil Kumar',
        'Nitin Sharma',
        'Tanya Roy',
        'Mukul Jain',
        'Nikhil S.',
        'Arpita Joshi',
        'Praful Rao',
        'Ramesh B.',
        'Meena L.',
        'Ajay P.'
      ];
      return _Student(
          name: names[i % names.length],
          roll: roll,
          marksController: TextEditingController(text: '0'));
    });

    // Show as dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: StatefulBuilder(builder: (context, setState) {
            // compute summary counters from fields
            int parsed(String txt) => int.tryParse(txt) ?? 0;

            int totalStudents() => students.length;
            int getPresentCount() {
              // consider present if marks field > 0
              int count = 0;
              for (var s in students) {
                final v = int.tryParse(s.marksController.text) ?? 0;
                if (v > 0) count++;
              }
              return count;
            }

            return Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              constraints: const BoxConstraints(maxHeight: 640),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Internal Assessment 2 - $subject',
                                  style: GoogleFonts.inter(
                                      fontSize: 16, fontWeight: FontWeight.w700)),
                              const SizedBox(height: 4),
                              Text('$code • $year • Maximum Marks: $maxMarks',
                                  style: GoogleFonts.inter(
                                      color: Colors.grey[700], fontSize: 13.5)),
                            ]),
                      ),
                      IconButton(
                        onPressed: () {
                          // close dialog and dispose controllers
                          for (var s in students) {
                            s.marksController.dispose();
                          }
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close, color: Colors.black54),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // summary box
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300)),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _summaryItem('Total Students', '${totalStudents()}', Colors.black87),
                          _summaryItem('Present', '${getPresentCount()}', Colors.green),
                          _summaryItem('Absent', '${totalStudents() - getPresentCount()}', Colors.redAccent),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _deptChip('CSE: 30 students'),
                          _deptChip('IT: ${totalStudents() - 30} students'),
                        ],
                      )
                    ]),
                  ),

                  const SizedBox(height: 12),
                  Text('Student List', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),

                  // list of students with input fields
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Scrollbar(
                        thumbVisibility: true,
                        radius: const Radius.circular(10),
                        thickness: 6,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: students.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 6),
                          itemBuilder: (context, index) {
                            final s = students[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey.shade200),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 36,
                                      child: Text('${index + 1}.', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(s.name, style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                                          const SizedBox(height: 4),
                                          Text(s.roll, style: GoogleFonts.inter(color: Colors.grey[700], fontSize: 13)),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    // marks input box
                                    SizedBox(
                                      width: 78,
                                      child: TextField(
                                        controller: s.marksController,
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.grey[100],
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                                        ),
                                        onChanged: (val) {
                                          // clamp to 0..maxMarks
                                          final parsed = int.tryParse(val) ?? 0;
                                          if (parsed < 0 || parsed > maxMarks) {
                                            // update to valid value and refresh summary
                                            s.marksController.text = parsed.clamp(0, maxMarks).toString();
                                            s.marksController.selection = TextSelection.fromPosition(TextPosition(offset: s.marksController.text.length));
                                          }
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // footer buttons
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // gather marks, simple validation & close
                            final Map<String, int> marksMap = {};
                            for (var s in students) {
                              marksMap[s.roll] = int.tryParse(s.marksController.text) ?? 0;
                            }

                            // dispose controllers
                            for (var s in students) {
                              s.marksController.dispose();
                            }

                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Marks saved (${marksMap.length} students)')),
                            );
                          },
                          icon: const Icon(Icons.save, color: Colors.white),
                          label: Text('Save Marks', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // placeholder: trigger download/export (implement real export if needed)
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Download marks sheet (placeholder)')),
                            );
                          },
                          icon: const Icon(Icons.download_outlined, color: Colors.black87),
                          label: Text('Download Marks Sheet', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: Colors.black87)),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            side: BorderSide(color: Colors.grey.shade300),
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  // small helper widgets
  Widget _summaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: GoogleFonts.inter(color: Colors.grey[700], fontSize: 13)),
        const SizedBox(height: 4),
        Text(value, style: GoogleFonts.inter(color: color, fontWeight: FontWeight.w700)),
      ],
    );
  }

  Widget _deptChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(text, style: GoogleFonts.inter(fontSize: 12.5, color: Colors.black87)),
    );
  }
}

class _SubjectItem {
  final String title;
  final String code;
  final String year;
  const _SubjectItem({required this.title, required this.code, required this.year});
}

class _Student {
  final String name;
  final String roll;
  final TextEditingController marksController;
  _Student({required this.name, required this.roll, required this.marksController});
}


