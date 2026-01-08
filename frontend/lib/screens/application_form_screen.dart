import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicationFormScreen extends StatefulWidget {
  const ApplicationFormScreen({super.key});

  @override
  State<ApplicationFormScreen> createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends State<ApplicationFormScreen> {
  String? gender;
  String? course;
  String? education;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Application Form',
                style: GoogleFonts.inter(
                    fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black)),
            const SizedBox(height: 2),
            Text('Fill all details carefully',
                style: GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _section(
              title: 'Personal Information',
              subtitle: 'Provide your personal details',
              children: [
                _input('First Name *'),
                _input('Last Name *'),
                _input('Email Address *'),
                _input('Phone Number *'),
                _input('Date of Birth *', hint: 'dd-mm-yyyy'),
                _dropdown(
                  label: 'Gender *',
                  value: gender,
                  items: const ['Male', 'Female', 'Other'],
                  onChanged: (v) => setState(() => gender = v),
                ),
                _input('Address *', maxLines: 3),
                _input('State *'),
                _input('Pincode *'),
              ],
            ),

            const SizedBox(height: 16),

            _section(
              title: 'Academic Information',
              subtitle: 'Provide your academic background',
              children: [
                _dropdown(
                  label: 'Preferred Course *',
                  value: course,
                  items: const [
                    'Computer Science & Engineering',
                    'Electronics & Communication',
                    'Mechanical Engineering',
                    'Civil Engineering',
                  ],
                  onChanged: (v) => setState(() => course = v),
                ),
                _dropdown(
                  label: 'Previous Education *',
                  value: education,
                  items: const ['12th', 'Diploma'],
                  onChanged: (v) => setState(() => education = v),
                ),
                _input('Board / University *'),
                _input('Year of Passing *'),
                _input('Percentage / CGPA *'),
              ],
            ),

            const SizedBox(height: 16),

            _section(
              title: 'Document Upload',
              subtitle: 'Upload required documents (PDF format, max 2MB each)',
              
              children: const [
                _FilePicker(label: 'Passport Size Photo *'),
                _FilePicker(label: '10th Mark sheet *'),
                _FilePicker(label: '12th Mark sheet *'),
                _FilePicker(label: 'Transfer Certificate'),
              ],
            ),

            const SizedBox(height: 22),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Application Submitted')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Submit Application',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              'By submitting this application, you agree to our\nterms and conditions.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Helpers ----------

  Widget _section({
    required String title,
    required String subtitle,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700, fontSize: 14)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 12),
          ...children.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: e,
              )),
        ],
      ),
    );
  }

  Widget _input(String label, {String? hint, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.inter(
                fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _dropdown({
    required String label,
    required List<String> items,
    required String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.inter(
                fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          items: items
              .map((e) =>
                  DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

// ---------- File Picker UI (visual only) ----------
class _FilePicker extends StatefulWidget {
  final String label;
  const _FilePicker({required this.label});

  @override
  State<_FilePicker> createState() => _FilePickerState();
}

class _FilePickerState extends State<_FilePicker> {
  String fileName = 'No file chosen';

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      withData: true,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        fileName = result.files.first.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: _pickFile,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.upload_file, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Choose file',
                  style: GoogleFonts.inter(fontSize: 13),
                ),
                const Spacer(),
                Expanded(
                  child: Text(
                    fileName,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}