import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Internal_assessment_1_screen.dart';
import 'internal_assessment2_screen.dart';
import 'model_exam_screen.dart';
import 'university_result_department_screen.dart';

class StaffMarksScreen extends StatelessWidget {
  const StaffMarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
  automaticallyImplyLeading: false, // ✅ removes back button
  backgroundColor: Colors.grey[50],
  elevation: 0,
  centerTitle: false,

  title: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Academic Records',
        style: GoogleFonts.inter(
          fontSize: 16,           // 🔽 reduced size
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      Text(
        'Select assessment type to manage marks',
        style: GoogleFonts.inter(
          fontSize: 13,
          color: Colors.grey[700],
        ),
      ),
    ],
  ),
),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            _buildOptionCard(
              context,
              icon: Icons.menu_book_rounded,
              iconColor: Colors.blue,
              bgColor: Colors.blue.shade50,
              title: "Internal Assessment 1",
              subtitle: "Enter and manage IA1 marks for your subjects",
              onTap: () {
                 Navigator.push(
                context,
                 MaterialPageRoute(
                 builder: (_) => const InternalAssessment1Screen(),
                ),
               );
              },
            ),
            _buildOptionCard(
              context,
              icon: Icons.menu_book_outlined,
              iconColor: Colors.purple,
              bgColor: Colors.purple.shade50,
              title: "Internal Assessment 2",
              subtitle: "Enter and manage IA2 marks for your subjects",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const InternalAssessment2Screen()
                    ),
                );


              },
            ),
            _buildOptionCard(
              context,
              icon: Icons.assignment_rounded,
              iconColor: Colors.green,
              bgColor: Colors.green.shade50,
              title: "Model Examination",
              subtitle: "Enter and manage Model Exam marks",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ModelExamScreen()
                    ),
                );
              },
            ),
            _buildOptionCard(
              context,
              icon: Icons.download_rounded,
              iconColor: Colors.orange,
              bgColor: Colors.orange.shade50,
              title: "University Result Download",
              subtitle: "View and download university exam results",
              onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const UniversityResultDepartmentScreen(),
    ),
  );
},

            ),
          ],
        ),
      ),
    );
  }

  // --------------------- CARD WIDGET ---------------------
  Widget _buildOptionCard(BuildContext context,
      {required IconData icon,
      required Color iconColor,
      required Color bgColor,
      required String title,
      required String subtitle,
      required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        title: Text(title,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w600, color: Colors.black)),
        subtitle: Text(subtitle,
            style: GoogleFonts.inter(color: Colors.grey[700], fontSize: 13)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded,
            color: Colors.black45, size: 16),
      ),
    );
  }
}

// --------------------- PLACEHOLDER PAGE ---------------------
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[50],
        title: Text(title,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w700, color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Text("🚧 $title Screen Coming Soon 🚧",
            style: GoogleFonts.inter(
                fontSize: 15, 
                fontWeight: FontWeight.w600,
                color: Colors.grey[700])),
      ),
    );
  }
}



