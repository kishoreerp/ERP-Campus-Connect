import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'staff_announcement_subject_screen.dart';

class StaffAnnouncementScreen extends StatelessWidget {
  const StaffAnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Announcements',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            Text(
              'Select a subject to make announcements',
              style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _subjectTile(
              context,
              title: 'Data Structures',
              code: 'CS501',
              year: '2nd Year',
              count: '2 announcements',
            ),
            _subjectTile(
              context,
              title: 'Algorithms',
              code: 'CS502',
              year: '3rd Year',
              count: '1 announcement',
            ),
            _subjectTile(
              context,
              title: 'Database Systems',
              code: 'CS503',
              year: 'Final Year',
              count: '2 announcements',
            ),
            _subjectTile(
              context,
              title: 'Web Development',
              code: 'CS504',
              year: '1st Year',
              count: '1 announcement',
            ),
          ],
        ),
      ),
    );
  }

  Widget _subjectTile(
    BuildContext context, {
    required String title,
    required String code,
    required String year,
    required String count,
  }) {
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
              builder: (_) => StaffAnnouncementSubjectScreen(
                subject: title,
                code: code,
                year: year,
              ),
            ),
          );
        },
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.campaign, color: Colors.purple),
        ),
        title: Text(title,
            style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        subtitle: Text('$code • $year',
            style: GoogleFonts.inter(fontSize: 13)),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(count,
              style: GoogleFonts.inter(fontSize: 12)),
        ),
      ),
    );
  }
}
