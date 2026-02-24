import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/services/marks_service.dart';

class StudentMarksScreen extends StatefulWidget {
  const StudentMarksScreen({super.key});

  @override
  State<StudentMarksScreen> createState() => _StudentMarksScreenState();
}

class _StudentMarksScreenState extends State<StudentMarksScreen> {
  int selectedTab = 0;
  bool loading = true;

  Map<String, Map<String, int>> marksData = {};
  String? studentYear;

  @override
  void initState() {
    super.initState();
    _loadStudentAndMarks();
  }

  Future<void> _loadStudentAndMarks() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        setState(() => loading = false);
        return;
      }

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (!userDoc.exists) {
        setState(() => loading = false);
        return;
      }

      final userData = userDoc.data()!;

      final String studentRegNo =
          (userData['rollNo'] ?? '').toString().trim();

      studentYear =
          (userData['year'] ?? '').toString().trim();

      if (studentRegNo.isEmpty || studentYear == null || studentYear!.isEmpty) {
        setState(() => loading = false);
        return;
      }

      final rawData = await MarksService.instance.getStudentMarks(
        regNo: studentRegNo,
        studentYear: studentYear!,
      );

      final Map<String, Map<String, int>> fixedData = {};

      rawData.forEach((subject, exams) {
        final Map<String, int> normalized = {
          'IA1': 0,
          'IA2': 0,
          'MODEL': 0,
        };

        exams.forEach((exam, mark) {
          final key = exam.toUpperCase().trim();
          if (normalized.containsKey(key)) {
            normalized[key] = mark;
          }
        });

        fixedData[subject] = normalized;
      });

      setState(() {
        marksData = fixedData;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 18, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Academic Marks',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'View your internal and university examination results',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      _tabButton('Internal Marks', 0),
                      const SizedBox(width: 12),
                      _tabButton('University Result', 1),
                    ],
                  ),

                  const SizedBox(height: 14),

                  if (selectedTab == 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE4D9F7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Subject',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                'IA1',
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                'IA2',
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                'Model',
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  if (selectedTab == 0) const SizedBox(height: 8),

                  Expanded(
                    child: selectedTab == 0
                        ? ListView(
                            children: marksData.entries.map((e) {
                              final subject = e.key;
                              final m = e.value;

                              return Container(
                                margin:
                                    const EdgeInsets.only(bottom: 8),
                                padding:
                                    const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(0.05),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        subject,
                                        style: GoogleFonts.inter(
                                          fontWeight:
                                              FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    _markChip(m['IA1']),
                                    _markChip(m['IA2']),
                                    _markChip(m['MODEL']),
                                  ],
                                ),
                              );
                            }).toList(),
                          )
                        : _buildUniversityResult(),
                  ),

                  const SizedBox(height: 12),

                  if (selectedTab == 0)
                          // Info Box
        Container(
  width: double.infinity,
  padding: const EdgeInsets.all(14),
  decoration: BoxDecoration(
    color: Colors.grey.shade100,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Colors.grey.shade300),
  ),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(Icons.info_outline, color: Colors.grey[700], size: 20),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          "• IA1 & IA2 are out of 50 marks each\n"
          "• Model Exam is out of 100 marks\n"
          "• Pass mark for IA: 20/50, Model: 35/100",
          style: GoogleFonts.inter(
            fontSize: 12.5,
            color: Colors.grey[800],
            height: 1.5,
          ),
        ),
      ),
    ],
  ),
),
                ],
              ),
            ),
    );
  }
  // ---------------- UNIVERSITY RESULT TAB ----------------
Widget _buildUniversityResult() {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),


        // File icon and name
        Icon(Icons.picture_as_pdf_outlined,
            color: Colors.deepPurple.shade400, size: 80),
        const SizedBox(height: 12),
        Text(
          "University_Result_Sem5.pdf",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Colors.black87,
          ),
        ),
        Text("CS21B001",
            style: GoogleFonts.inter(color: Colors.grey[700], fontSize: 13)),
        const SizedBox(height: 20),


        // View & Download buttons (new design)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // View button
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.visibility_outlined, size: 18),
              label: Text("View",
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple.shade700)),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.deepPurple.shade200),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Colors.deepPurple.shade50,
              ),
            ),
            const SizedBox(width: 12),


            // Download button
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download_outlined, size: 18),
              label: Text(
                "Download",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple.shade400,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),


        const SizedBox(height: 40),


        // Subtle info text at the bottom
        Text(
          "You can view or download your official university mark statement.",
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 12.5,
            color: Colors.grey[700],
            height: 1.4,
          ),
        ),


        const SizedBox(height: 30),
      ],
    ),
  );
}


    
  Widget _tabButton(String text, int index) {
    final selected = selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () =>
            setState(() => selectedTab = index),
        child: Container(
          padding:
              const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFFD6C7F0)
                : Colors.grey[200],
            borderRadius:
                BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: selected
                  ? Colors.deepPurple
                  : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Widget _markChip(int? value) {
    return Expanded(
      child: Center(
        child: Container(
          padding:
              const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius:
                BorderRadius.circular(8),
          ),
          child: Text(
            value != null
                ? '$value/100'
                : '-',
            style: GoogleFonts.inter(
              fontSize: 12.5,
            ),
          ),
        ),
      ),
    );
  }
}