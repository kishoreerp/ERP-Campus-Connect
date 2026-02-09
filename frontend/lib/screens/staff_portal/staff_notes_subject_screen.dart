import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';


class StaffNotesSubjectScreen extends StatefulWidget {
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
  State<StaffNotesSubjectScreen> createState() =>
      _StaffNotesSubjectScreenState();
}


class _StaffNotesSubjectScreenState
    extends State<StaffNotesSubjectScreen> {


  /// TEMP NOTES LIST
  List<Map<String, String>> notes = [
    {
      'title': 'Unit 1 - Arrays.pdf',
      'info': '1.2 MB • 2024-01-10',
    },
    {
      'title': 'Unit 2 - Stacks.pdf',
      'info': '980 KB • 2024-01-12',
    },
    {
      'title': 'Unit 3 - Trees.pdf',
      'info': '1.8 MB • 2024-01-15',
    },
  ];


  /// FILE PICKER (OLD SAFE API)
  Future<void> _pickFile() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'ppt', 'pptx'],
    );


    if (result != null) {
      final fileName = result.files.single.name;


      setState(() {
        notes.add({
          'title': fileName,
          'info': 'New file • Today',
        });
      });


      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Uploaded: $fileName')),
      );
    }
  }


  /// DOWNLOAD (DUMMY)
  void _downloadFile(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloading $title')),
    );
  }


  /// DELETE CONFIRMATION
  void _deleteFile(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                notes.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }


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
              widget.subject,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            Text(
              '${widget.code} • ${widget.year}',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            /// UPLOAD BOX
            InkWell(
              onTap: _pickFile,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.upload_file,
                        size: 36, color: Colors.blue),
                    const SizedBox(height: 8),
                    Text(
                      'Upload New Note',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'PDF, DOC, PPT (Max 2MB)',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),


            const SizedBox(height: 20),


            Text(
              'Uploaded Notes',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),


            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return _noteTile(
                    title: notes[index]['title']!,
                    subtitle: notes[index]['info']!,
                    onDownload: () =>
                        _downloadFile(notes[index]['title']!),
                    onDelete: () => _deleteFile(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _noteTile({
    required String title,
    required String subtitle,
    required VoidCallback onDownload,
    required VoidCallback onDelete,
  }) {
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
                Text(
                  title,
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: onDownload,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}