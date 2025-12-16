import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class StudentMarksScreen extends StatefulWidget {
  const StudentMarksScreen({super.key});


  @override
  State<StudentMarksScreen> createState() => _StudentMarksScreenState();
}


class _StudentMarksScreenState extends State<StudentMarksScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Academic Marks",
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "View your internal and university examination results",
              style: GoogleFonts.inter(color: Colors.grey[700], fontSize: 13),
            ),
            const SizedBox(height: 20),
            // Tabs
            Container(
  decoration: BoxDecoration(
    color: Colors.grey[200],
    borderRadius: BorderRadius.circular(10),
  ),
  child: TabBar(
    controller: _tabController,
    labelColor: Colors.deepPurple.shade800,
    unselectedLabelColor: Colors.black87,
    indicator: BoxDecoration(
      color: Colors.deepPurple.shade100, // ✅ light lavender background
      borderRadius: BorderRadius.circular(10),
    ),
    labelStyle: GoogleFonts.inter(
      fontWeight: FontWeight.w600,
      fontSize: 13.5,
    ),
    indicatorSize: TabBarIndicatorSize.tab, // ✅ makes the fill cover full tab
    tabs: const [
      Tab(text: "Internal Marks"),
      Tab(text: "University Result"),
    ],
  ),
),
            const SizedBox(height: 16),


            // Tab Views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildInternalMarks(),
                  _buildUniversityResult(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  // ---------------- INTERNAL MARKS TAB ----------------
  Widget _buildInternalMarks() {
    final marks = [
      ["Data Structures", "92/100","78/100","96/100"],
      ["Algorithms", "89/100","87/100","98/100"],
      ["Database Systems", "78/100","89/100","72/100"],
      ["Web Development", "87/100","98/100","70/100"],
      ["Software Engineering", "94/100","98/100","89/100"],
    ];


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row
        // Header Row (improved)
Container(
  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
  decoration: BoxDecoration(
    color: Colors.deepPurple.shade50,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.deepPurple.shade100),
  ),
  child: Row(
    children: [
      Expanded(
        flex: 3,
        child: Text(
          "Subject",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: Colors.deepPurple.shade800,
            fontSize: 13.5,
          ),
        ),
      ),
      Expanded(
        child: Center(
          child: Text(
            "IA1",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: Colors.deepPurple.shade800,
              fontSize: 13.5,
            ),
          ),
        ),
      ),
      Expanded(
        child: Center(
          child: Text(
            "IA2",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: Colors.deepPurple.shade800,
              fontSize: 13.5,
            ),
          ),
        ),
      ),
      Expanded(
        child: Center(
          child: Text(
            "Model",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: Colors.deepPurple.shade800,
              fontSize: 13.5,
            ),
          ),
        ),
      ),
    ],
  ),
),
        const SizedBox(height: 6),


        // Marks Table
        Expanded(
          child: ListView.builder(
            itemCount: marks.length,
            itemBuilder: (context, index) {
              final subject = marks[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(subject[0],
                          style: GoogleFonts.inter(fontSize: 13.5)),
                    ),
                    _markCell(subject[1]),
                    _markCell(subject[2]),
                    _markCell(subject[3], isModel: true),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),


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
    );
  }


 Widget _markCell(String text, {bool isModel = false}) {
  // Use same neutral tone for all marks
  final color = Colors.grey[800]!; // dark gray text
  return Expanded(
    child: Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade100, // ✅ soft light gray background
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 12.5,
          ),
        ),
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


    }



