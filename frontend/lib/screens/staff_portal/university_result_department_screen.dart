import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'university_result_download_screen.dart';

class UniversityResultDepartmentScreen extends StatelessWidget {
  const UniversityResultDepartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[50],
        leading: const BackButton(color: Colors.black),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("University Results",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700, color: Colors.black)),
            Text("Select a department",
                style: GoogleFonts.inter(
                    fontSize: 13, color: Colors.grey[700])),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _deptTile(context, "IT", "IT Department", Icons.computer),
            _deptTile(context, "CSE", "CSE Department", Icons.memory),
            _deptTile(context, "CSE (Cyber Security)", "CSE-CS Department", Icons.security),
            _deptTile(context, "AIDS", "AIDS Department", Icons.psychology),
            _deptTile(context, "ECE", "ECE Department", Icons.settings_input_antenna),
          ],
        ),
      ),
    );
  }

  Widget _deptTile(BuildContext context, String title, String subtitle, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ListTile(
        onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => UniversityResultDownloadScreen(
        department: title,
      ),
    ),
  );
},

        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.blue),
        ),
        title: Text(title,
            style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle,
            style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[700])),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
