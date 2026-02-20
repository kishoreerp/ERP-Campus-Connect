import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

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
                style:
                    GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
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
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => NewMarksDialog(subject: subject),
        );
      },
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
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(subject,
                      style: GoogleFonts.inter(
                          fontWeight:
                              FontWeight.w600)),
                  Text("$code • $year",
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.grey)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right,
                color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// NEW MARKS DIALOG
////////////////////////////////////////////////////////////

class NewMarksDialog extends StatefulWidget {
  final String subject;

  const NewMarksDialog({super.key, required this.subject});

  @override
  State<NewMarksDialog> createState() => _NewMarksDialogState();
}

class _NewMarksDialogState extends State<NewMarksDialog> {

  final int totalStudents = 45;

  late List<TextEditingController> controllers;

  int presentCount = 0;
  int absentCount = 45;

  bool showExamList = false;
  String selectedExam = "Internal Assessment 1";

  final List<String> examOptions = [
    "Internal Assessment 1",
    "Internal Assessment 2",
    "Model",
  ];

  final names = [
    'Aarav Kumar','Advait Sharma','Ananya Patel','Arjun Reddy',
    'Diya Singh','Ishaan Gupta','Kavya Nair','Krishna Iyer',
    'Meera Desai','Nisha Joshi','Pranav Mehta','Riya Verma',
    'Rohan Das','Pooja Joshi','Rakesh Mehta','Simran Verma',
    'Tarun Das','Varun Agarwal','Zoya Prasad','Ganesh Iyer',
    'Harsha Nair','Indra Desai','Jayashree Joshi','Karthik Mehta',
    'Latha Verma','Ramesh Patel','Savitri Agarwal','Suresh Deshmukh',
    'Tulasi Khan','Venkat Saxena','Yasmin Prasad','Aman Gupta',
    'Ritu Patel','Sunil Kumar','Nitin Sharma','Tanya Roy',
    'Mukul Jain','Nikhil S.','Arpita Joshi','Praful Rao',
    'Ramesh B.','Meena L.','Vijay P.'
  ];

  @override
  void initState() {
    super.initState();
    controllers = List.generate(
      totalStudents,
      (index) => TextEditingController(),
    );
  }
void updateAttendance() {
  int present = 0;

  for (var controller in controllers) {
    final value = int.tryParse(controller.text) ?? 0;

    if (value >= 1 && value <= 50) {
      present++;
    }
  }

  setState(() {
    presentCount = present;
    absentCount = totalStudents - present;
  });
}

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 650,
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            /// HEADER
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showExamList = !showExamList;
                          });
                        },
                        child: Row(
                          children: [
                            Text(selectedExam,
                                style: GoogleFonts.inter(
                                    fontWeight:
                                        FontWeight.w600)),
                            const Icon(
                                Icons.arrow_drop_down),
                          ],
                        ),
                      ),

                      if (showExamList)
                        Column(
                          children: examOptions
                              .map((exam) =>
                                  ListTile(
                                    title:
                                        Text(exam),
                                    onTap: () {
                                      setState(() {
                                        selectedExam =
                                            exam;
                                        showExamList =
                                            false;
                                      });
                                    },
                                  ))
                              .toList(),
                        ),

                      const SizedBox(height: 6),

                      Text(widget.subject,
                          style:
                              GoogleFonts.inter(
                                  fontSize: 13,
                                  color:
                                      Colors.grey)),
                    ],
                  ),
                ),
                IconButton(
                  icon:
                      const Icon(Icons.close),
                  onPressed: () =>
                      Navigator.pop(context),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// SUMMARY
            Container(
              padding:
                  const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color:
                    Colors.grey.shade100,
                borderRadius:
                    BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceAround,
                children: [
                  SummaryItem(
                      title:
                          "Total Students",
                      value: totalStudents
                          .toString(),
                      color:
                          Colors.black),
                  SummaryItem(
                      title: "Present",
                      value:
                          presentCount
                              .toString(),
                      color:
                          Colors.green),
                  SummaryItem(
                      title: "Absent",
                      value:
                          absentCount
                              .toString(),
                      color:
                          Colors.red),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Text("Student List",
                style: GoogleFonts.inter(
                    fontWeight:
                        FontWeight.w600)),

            const SizedBox(height: 10),

            /// STUDENT LIST
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                child: ListView.builder(
                  itemCount:
                      totalStudents,
                  itemBuilder:
                      (context, index) {
                    return Container(
                      margin:
                          const EdgeInsets
                                  .only(
                              bottom: 10),
                      padding:
                          const EdgeInsets
                              .all(12),
                      decoration:
                          BoxDecoration(
                        borderRadius:
                            BorderRadius
                                .circular(
                                    12),
                        border: Border.all(
                            color: Colors
                                .grey
                                .shade200),
                      ),
                      child: Row(
                        children: [
                          Text(
                              "${index + 1}."),
                          const SizedBox(
                              width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                              children: [
                                Text(
                                  names[index %
                                      names
                                          .length],
                                  style: GoogleFonts
                                      .inter(
                                          fontWeight:
                                              FontWeight
                                                  .w500),
                                ),
                                Text(
                                  "CSE${(index + 1).toString().padLeft(3, '0')}",
                                  style: GoogleFonts
                                      .inter(
                                          fontSize:
                                              12,
                                          color: Colors
                                              .grey),
                                ),
                              ],
                            ),
                          ),
      SizedBox(
  width: 60,
  child: TextField(
    controller: controllers[index],
    keyboardType: TextInputType.number,
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(2),
    ],
    onChanged: (value) {
      int mark = int.tryParse(value) ?? 0;

      // restrict between 0–50
      if (mark > 50) {
        controllers[index].text = "50";
        controllers[index].selection = TextSelection.fromPosition(
          TextPosition(offset: controllers[index].text.length),
        );
      }

      updateAttendance();
    },
    textAlign: TextAlign.center,
    decoration: InputDecoration(
      hintText: "0",
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    ),
  ),
),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// SAVE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton
                    .styleFrom(
                  backgroundColor:
                      Colors.black,
                ),
                icon: const Icon(
                    Icons.save,
                    color: Colors.white),
                label: const Text(
                    "Save Marks",
                    style: TextStyle(
                        color: Colors
                            .white)),
                onPressed: () {
                  Navigator.pop(
                      context);
                  ScaffoldMessenger.of(
                          context)
                      .showSnackBar(
                    const SnackBar(
                        content: Text(
                            "Marks Saved Successfully")),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            /// DOWNLOAD BUTTON
            SizedBox(
              width: double.infinity,
              child:
                  OutlinedButton.icon(
                icon: const Icon(
                    Icons.download),
                label: const Text(
                    "Download Marks Sheet"),
                onPressed: () {
                  Navigator.pop(
                      context);
                  ScaffoldMessenger.of(
                          context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                          "Marksheet downloaded successfully"),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// SUMMARY ITEM
////////////////////////////////////////////////////////////

class SummaryItem extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const SummaryItem({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title,
            style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value,
            style: GoogleFonts.inter(
                fontWeight:
                    FontWeight.w600,
                color: color)),
      ],
    );
  }
}
