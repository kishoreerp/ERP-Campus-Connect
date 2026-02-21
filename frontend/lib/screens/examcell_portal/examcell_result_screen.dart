import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,home: ExamCellResultScreen(),);}
}

class InternalsYearScreen extends StatelessWidget {
  const InternalsYearScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
  backgroundColor: Colors.white,
  elevation: 0,
  iconTheme: const IconThemeData(color: Colors.black),
  title: const Text(
    "Internals",
    style: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  ),
),
      body: SingleChildScrollView(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      /// TOP HEADING
      const SizedBox(height: 1),
      const Text(
        "Select Year",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),

      const SizedBox(height: 2),

      const Text(
        "Choose the academic year to proceed",
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey,
        ),
      ),

      const SizedBox(height: 10),
       
            /// ======================
            /// UNDERGRADUATE
            /// ======================
            const Text(
              "Undergraduate",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _YearCard(title: "1st Year", onTap: () {
                  _openDepartment(context);
                }),
                _YearCard(title: "2nd Year", onTap: () {
                  _openDepartment(context);
                }),
                _YearCard(title: "3rd Year", onTap: () {
                  _openDepartment(context);
                }),
                _YearCard(title: "4th Year", onTap: () {
     _openDepartment(context);
                }),
              ],
            ),

            const SizedBox(height: 18),

            /// ======================
            /// POSTGRADUATE
            /// ======================
            const Text(
              "Postgraduate",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _YearCard(
                  title: "1st Year",
                  isPostGraduate: true,
                  onTap: () {
                    _openDepartment(context);
                  },
                ),
                _YearCard(
                  title: "2nd Year",
                  isPostGraduate: true,
                  onTap: () {
                    _openDepartment(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static void _openDepartment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const DepartmentSelectionScreen(),
      ),
    );
  }
}

class _YearCard extends StatelessWidget {
  final String title;
  final bool isPostGraduate;
  final VoidCallback onTap;

  const _YearCard({
    required this.title,
    required this.onTap,
    this.isPostGraduate = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school,
              size: 28,
              color: isPostGraduate
                  ? Colors.purpleAccent
                  : Colors.blueAccent,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/// =================================================
/// EXAM CELL RESULT SCREEN (UG & PG AT TOP)
/// =================================================
class ExamCellResultScreen extends StatelessWidget {
  const ExamCellResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // subtle grey background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 2),

              /// HEADER TITLE
              const Text(
                "Result Management",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 3),

              const Text(
                "Approve and upload results",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 18),

             /// INTERNALS CARD
              _buildMainOption(
                context,
                "Internals",
                Icons.assessment,
                false,
              ), 

              const SizedBox(height: 16),
/// UNIVERSITY RESULT CARD
              _buildMainOption(
                context,
                "University Results",
                Icons.picture_as_pdf,
                true,
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainOption(
      BuildContext context, String title, IconData icon, bool isUniversity) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => isUniversity
                ? const DepartmentSelectionScreen(isUniversity: true)
                : const InternalsYearScreen(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [

            /// ICON CONTAINER
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: Colors.blue,
                size: 22,
              ),
            ),

            const SizedBox(width: 16),

            /// TITLE
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
/// =================================================
/// DEPARTMENT
/// =================================================

class DepartmentSelectionScreen extends StatelessWidget {
  final bool isUniversity;
  const DepartmentSelectionScreen(
      {super.key, this.isUniversity = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Departments")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _dept(context, "Computer Science"),
            _dept(context, "Information Technology"),
            _dept(context, "AI & Data Science"),
            _dept(context, "Cyber Security"),
            _dept(context, "Electronics and Communication"),
          ],
        ),
      ),
    );
  }

  Widget _dept(BuildContext context, String title) {
    return InkWell(
      onTap: () {
        if (isUniversity) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    const UploadPdfScreen()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    const SubjectScreen()),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border:
              Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            const Icon(Icons.menu_book, color: Colors.blue),
            const SizedBox(width: 16),
            Expanded(
              child: Text(title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
            const Icon(Icons.arrow_forward_ios,
                size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

/// =================================================
/// UPLOAD PDF SCREEN
/// =================================================

class UploadPdfScreen extends StatelessWidget {
  const UploadPdfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload PDF")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Icon(Icons.picture_as_pdf,
                size: 80, color: Colors.red),
            const SizedBox(height: 20),
            const Text(
              "Upload University Result PDF",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Choose PDF"),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Upload"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/// =================================================
/// SUBJECT SCREEN
/// =================================================
class SubjectScreen extends StatelessWidget {
  const SubjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Subjects")),
      body: Column(
        children: [

          /// SUBJECT LIST
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _subject(context, "Data Structures"),
                    const SizedBox(height: 16),
                    _subject(context, "Operating Systems"),
                    const SizedBox(height: 16),
                    _subject(context, "DBMS"),
                    const SizedBox(height: 16),
                    _subject(context, "Computer Networks"),
                  ],
                ),
              ),
            ),
          ),

          /// APPROVE MARKS BUTTON (UNCHANGED)
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.visibility),
                label: const Text("Approve Marks"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ ONLY ONE SUBJECT METHOD
  Widget _subject(BuildContext context, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: 18, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.book,
              color: Colors.blue,
              size: 22,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          /// VIEW BUTTON (RIGHT SIDE)
          SizedBox(
            height: 34,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to student marks screen
              },
              child: const Text("View"),
            ),
          ),
        ],
      ),
    );
  }
}