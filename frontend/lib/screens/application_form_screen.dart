import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ApplicationFormScreen extends StatefulWidget {
  const ApplicationFormScreen({super.key});



  @override
  State<ApplicationFormScreen> createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends State<ApplicationFormScreen> {
  String? gender;
  String? course;
  String? education;

  final TextEditingController firstNameCtrl = TextEditingController();
final TextEditingController lastNameCtrl = TextEditingController();
final TextEditingController emailCtrl = TextEditingController();
final TextEditingController phoneCtrl = TextEditingController();
final TextEditingController dobCtrl = TextEditingController();
final TextEditingController addressCtrl = TextEditingController();
final TextEditingController stateCtrl = TextEditingController();
final TextEditingController pincodeCtrl = TextEditingController();

final TextEditingController boardCtrl = TextEditingController();
final TextEditingController yearCtrl = TextEditingController();
final TextEditingController percentageCtrl = TextEditingController();

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
                _input('First Name *', firstNameCtrl),
                _input('Last Name *', lastNameCtrl),
                _input('Email Address *', emailCtrl),
                _input('Phone Number *', phoneCtrl),
                _input('Date of Birth *', dobCtrl, hint: 'dd-mm-yyyy'),
                _dropdown(
                  label: 'Gender *',
                  value: gender,
                  items: const ['Male', 'Female', 'Other'],
                  onChanged: (v) => setState(() => gender = v),
                ),
                _input('Address *', addressCtrl, maxLines: 3),
                _input('State *', stateCtrl),
                _input('Pincode *', pincodeCtrl),
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
               _input('Board / University *', boardCtrl),
               _input('Year of Passing *', yearCtrl),
               _input('Percentage / CGPA *', percentageCtrl),

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
  onPressed: _submitApplication,
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
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
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
  
  Future<void> _submitApplication() async {
  try {
    if (firstNameCtrl.text.isEmpty ||
        lastNameCtrl.text.isEmpty ||
        emailCtrl.text.isEmpty ||
        phoneCtrl.text.isEmpty ||
        gender == null ||
        course == null ||
        education == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    await FirebaseFirestore.instance
        .collection('admission_forms')
        .add({
      'firstName': firstNameCtrl.text.trim(),
      'lastName': lastNameCtrl.text.trim(),
      'email': emailCtrl.text.trim(),
      'phone': phoneCtrl.text.trim(),
      'dob': dobCtrl.text.trim(),
      'gender': gender,
      'address': addressCtrl.text.trim(),
      'state': stateCtrl.text.trim(),
      'pincode': pincodeCtrl.text.trim(),

      'course': course,
      'education': education,
      'board': boardCtrl.text.trim(),
      'passingYear': yearCtrl.text.trim(),
      'percentage': percentageCtrl.text.trim(),

      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Application submitted successfully'),
      ),
    );

    Navigator.pop(context);
  } catch (e) {
    debugPrint('SUBMIT ERROR: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
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

Widget _input(
  String label,
  TextEditingController controller, {
  String? hint,
  int maxLines = 1,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,
          style: GoogleFonts.inter(
              fontSize: 12, fontWeight: FontWeight.w600)),
      const SizedBox(height: 6),
      TextField(
        controller: controller, // ✅ FIX
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
    final result = await FilePicker.pickFiles(
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