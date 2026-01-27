 import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StaffNotesSubjectScreen extends StatelessWidget {
  final String subject;
  final String code;
  final String year;

  const StaffNotesSubjectScreen({
    super.key,
    required this.subject,
    required this.code,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subject,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    color: Colors.black)),
            Text('$code • $year',
                style: GoogleFonts.inter(
                    fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Upload box (UI only)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: Colors.grey.shade300,
                    style: BorderStyle.solid),
              ),
              child: Column(
                children: [
                  const Icon(Icons.upload_file,
                      size: 36, color: Colors.blue),
                  const SizedBox(height: 8),
                  Text('Upload New Note',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text('PDF, DOC, PPT (Max 2MB)',
                      style: GoogleFonts.inter(
                          fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Text('Uploaded Notes',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),

            _noteTile('Unit 1 - Arrays.pdf', '1.2 MB • 2024-01-10'),
            _noteTile('Unit 2 - Stacks.pdf', '980 KB • 2024-01-12'),
            _noteTile('Unit 3 - Trees.pdf', '1.8 MB • 2024-01-15'),
          ],
        ),
      ),
    );
  }

  Widget _noteTile(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          const Icon(Icons.picture_as_pdf, color: Colors.red),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: GoogleFonts.inter(
                        fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          const Icon(Icons.download, size: 20),
          const SizedBox(width: 8),
          const Icon(Icons.delete_outline,
              size: 20, color: Colors.red),
        ],
      ),
    );
  }
}