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
  String? program;   // UG / PG
String? degree;    // B.E / B.Tech / M.E / MBA
String? preferredCourse;


  final TextEditingController firstNameCtrl = TextEditingController();
final TextEditingController lastNameCtrl = TextEditingController();
final TextEditingController emailCtrl = TextEditingController();
final TextEditingController phoneCtrl = TextEditingController();
final TextEditingController dobCtrl = TextEditingController();
final TextEditingController addressCtrl = TextEditingController();
final TextEditingController stateCtrl = TextEditingController();
final TextEditingController pincodeCtrl = TextEditingController();
final TextEditingController fullNameCtrl = TextEditingController();
final TextEditingController bloodGroupCtrl = TextEditingController();
final TextEditingController aadhaarCtrl = TextEditingController();
final TextEditingController fatherNameCtrl = TextEditingController();
final TextEditingController fatherMobileCtrl = TextEditingController();
final TextEditingController motherNameCtrl = TextEditingController();
final TextEditingController motherMobileCtrl = TextEditingController();
final TextEditingController guardianNameCtrl = TextEditingController();
final TextEditingController guardianMobileCtrl = TextEditingController();


// Address split controllers
final TextEditingController doorNoCtrl = TextEditingController();
final TextEditingController streetCtrl = TextEditingController();
final TextEditingController villageCtrl = TextEditingController();
final TextEditingController postCtrl = TextEditingController();
final TextEditingController cityCtrl = TextEditingController();
final TextEditingController talukCtrl = TextEditingController();
final TextEditingController districtCtrl = TextEditingController();


final TextEditingController boardCtrl = TextEditingController();
final TextEditingController yearCtrl = TextEditingController();
final TextEditingController percentageCtrl = TextEditingController();
final TextEditingController emisIdCtrl = TextEditingController();
final TextEditingController religionCtrl = TextEditingController();
final TextEditingController casteCtrl = TextEditingController();
final TextEditingController communityCtrl = TextEditingController();
final TextEditingController communityCertNoCtrl = TextEditingController();

final TextEditingController firstGraduateCertNoCtrl = TextEditingController();

final TextEditingController annualIncomeCtrl = TextEditingController();
final TextEditingController incomeCertNoCtrl = TextEditingController();

final TextEditingController nativityCertNoCtrl = TextEditingController();

bool isFirstGraduate = false;
bool hasNativityCert = false;

PlatformFile? communityCertFile;
PlatformFile? firstGraduateCertFile;
PlatformFile? incomeCertFile;
PlatformFile? nativityCertFile;


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
  title: 'Program Selection',
  subtitle: 'Choose program and course',
  children: [
    // PROGRAM
    _dropdown(
      label: 'Program *',
      value: program,
      items: const ['UG', 'PG'],
      onChanged: (v) {
        setState(() {
          program = v;
          degree = null;
          preferredCourse = null;
        });
      },
    ),

    // DEGREE
    if (program != null)
      _dropdown(
        label: 'Degree *',
        value: degree,
        items: program == 'UG'
            ? ['B.E', 'B.Tech']
            : ['M.E', 'MBA'],
        onChanged: (v) {
          setState(() {
            degree = v;
            preferredCourse = null;
          });
        },
      ),

    // COURSE
    if (program != null && degree != null)
      _dropdown(
        label: 'Preferred Course *',
        value: preferredCourse,
        items: courseMap[program]![degree]!,
        onChanged: (v) => setState(() => preferredCourse = v),
      ),
  ],
),
const SizedBox(height: 12),
            _section(
  title: 'Personal Information',
  subtitle: 'Provide applicant personal details',
  children: [
    _input('Name of the Applicant *', fullNameCtrl),

    _input('Date of Birth *', dobCtrl, hint: 'dd-mm-yyyy'),

    _dropdown(
      label: 'Gender *',
      value: gender,
      items: const ['Male', 'Female', 'Other'],
      onChanged: (v) => setState(() => gender = v),
    ),

    _dropdown(
      label: 'Blood Group *',
      value: bloodGroupCtrl.text.isEmpty ? null : bloodGroupCtrl.text,
      items: const ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'],
      onChanged: (v) => bloodGroupCtrl.text = v ?? '',
    ),

    _input(
      'Aadhaar Number *',
      aadhaarCtrl,
      hint: '12 digit Aadhaar number',
    ),

    _input('Email Address *', emailCtrl),
    _input('Phone Number *', phoneCtrl),
  ],
),
const SizedBox(height: 12),
_section(
  title: 'Parents / Guardian Information',
  subtitle: 'Provide parent or guardian contact details',
  children: [
    _input('Father Name *', fatherNameCtrl),
    _input('Father Mobile Number *', fatherMobileCtrl),

    _input('Mother Name *', motherNameCtrl),
    _input('Mother Mobile Number *', motherMobileCtrl),

    _input('Guardian Name (if applicable)', guardianNameCtrl),
    _input('Guardian Mobile Number', guardianMobileCtrl),
  ],
),
const SizedBox(height: 12),
_section(
  title: 'Address Information',
  subtitle: 'Permanent residential address',
  children: [
    _input('Door No *', doorNoCtrl),
    _input('Street / Road *', streetCtrl),
    _input('Village / Town *', villageCtrl),
    _input('Post *', postCtrl),
    _input('City *', cityCtrl),
    _input('Taluk *', talukCtrl),
    _input('District *', districtCtrl),
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
  title: 'Community & Certificate Details',
  subtitle: 'Scholarship and government certificate information',
  children: [
    _input('EMIS ID *', emisIdCtrl),
    _input('Religion *', religionCtrl),
    _input('Caste *', casteCtrl),
    _input('Community *', communityCtrl),

    _input('Community Certificate Number *', communityCertNoCtrl),

    
    _input(
      'Annual Income (₹) *',
      annualIncomeCtrl,
      hint: 'Numbers only',
    ),

    _input('Income Certificate Number *', incomeCertNoCtrl),
    
_yesNoRadio(
  label: 'First Graduate *',
  value: isFirstGraduate,
  onChanged: (v) => setState(() => isFirstGraduate = v),
),


if (isFirstGraduate)
  _input(
    'First Graduate Certificate Number *',
    firstGraduateCertNoCtrl,
  ),

_yesNoRadio(
  label: 'Nativity Certificate *',
  value: hasNativityCert,
  onChanged: (v) => setState(() => hasNativityCert = v),
),


if (hasNativityCert)
  _input(
    'Nativity Certificate Number *',
    nativityCertNoCtrl,
  ),
  ],
),

            const SizedBox(height: 16),

            _section(
              title: 'Document Upload',
              subtitle: 'Upload required documents (PDF format, max 2MB each)',
              
              children: [
  _filePicker(
    label: 'Community Certificate (PDF ≤ 20KB)',
    onSelected: (file) => communityCertFile = file,
  ),

  if (isFirstGraduate)
    _filePicker(
      label: 'First Graduate Certificate (PDF ≤ 20KB)',
      onSelected: (file) => firstGraduateCertFile = file,
    ),

  _filePicker(
    label: 'Income Certificate (PDF ≤ 20KB)',
    onSelected: (file) => incomeCertFile = file,
  ),

  if (hasNativityCert)
    _filePicker(
      label: 'Nativity Certificate (PDF ≤ 20KB)',
      onSelected: (file) => nativityCertFile = file,
    ),

  _FilePicker(label: 'Passport Size Photo *'),
  _FilePicker(label: '10th Mark Sheet *'),
  _FilePicker(label: '12th Mark Sheet *'),
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

  Future<bool> _isEmailAlreadyUsed(String email) async {
  final result = await FirebaseFirestore.instance
      .collection('admission_forms')
      .where('email', isEqualTo: email)
      .limit(1)
      .get();

  return result.docs.isNotEmpty;
}



  Future<void> _submitApplication() async {
  try {if (program == null || degree == null || preferredCourse == null) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Please select Program, Degree and Course')),
  );
  return;
}
// Aadhaar validation
if (!RegExp(r'^\d{12}$').hasMatch(aadhaarCtrl.text)) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Enter valid 12-digit Aadhaar number')),
  );
  return;
}

// Email already used check
final emailUsed = await _isEmailAlreadyUsed(emailCtrl.text.trim());
if (emailUsed) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Email already used')),
  );
  return;
}

if (fatherMobileCtrl.text.length != 10 ||
    motherMobileCtrl.text.length != 10) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Enter valid 10-digit parent mobile numbers')),
  );
  return;
}

if (guardianNameCtrl.text.isNotEmpty &&
    guardianMobileCtrl.text.length != 10) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
        content: Text('Enter valid 10-digit guardian mobile number')),
  );
  return;
}


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

    final fullAddress =
        '${doorNoCtrl.text}, ${streetCtrl.text}, ${villageCtrl.text}, '
        '${postCtrl.text}, ${cityCtrl.text}, ${talukCtrl.text}, '
        '${districtCtrl.text}, ${stateCtrl.text} - ${pincodeCtrl.text}';
if (!validatePdf(communityCertFile)) {
  _showError('Community certificate must be PDF ≤ 20KB');
  return;
}

if (isFirstGraduate && !validatePdf(firstGraduateCertFile)) {
  _showError('First Graduate certificate must be PDF ≤ 20KB');
  return;
}

if (!validatePdf(incomeCertFile)) {
  _showError('Income certificate must be PDF ≤ 20KB');
  return;
}

if (hasNativityCert && !validatePdf(nativityCertFile)) {
  _showError('Nativity certificate must be PDF ≤ 20KB');
  return;
}

if (!RegExp(r'^\d+$').hasMatch(annualIncomeCtrl.text)) {
  _showError('Annual income must contain numbers only');
  return;
}


    await FirebaseFirestore.instance
        .collection('admission_forms')
        .add({
          'program': program,
'degree': degree,
'department': preferredCourse,

      'fullName': fullNameCtrl.text.trim(),
'dob': dobCtrl.text.trim(),
'gender': gender,
'bloodGroup': bloodGroupCtrl.text,
'aadhaar': aadhaarCtrl.text.trim(),
'email': emailCtrl.text.trim(),
'phone': phoneCtrl.text.trim(),
'address': fullAddress,
'fatherName': fatherNameCtrl.text.trim(),
'fatherMobile': fatherMobileCtrl.text.trim(),
'motherName': motherNameCtrl.text.trim(),
'motherMobile': motherMobileCtrl.text.trim(),
'guardianName': guardianNameCtrl.text.trim(),
'guardianMobile': guardianMobileCtrl.text.trim(),
'emisId': emisIdCtrl.text.trim(),
'religion': religionCtrl.text.trim(),
'caste': casteCtrl.text.trim(),
'community': communityCtrl.text.trim(),
'communityCertNo': communityCertNoCtrl.text.trim(),

'isFirstGraduate': isFirstGraduate,
'firstGraduateCertNo': firstGraduateCertNoCtrl.text.trim(),

'annualIncome': annualIncomeCtrl.text.trim(),
'incomeCertNo': incomeCertNoCtrl.text.trim(),

'hasNativityCert': hasNativityCert,
'nativityCertNo': nativityCertNoCtrl.text.trim(),


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
bool validatePdf(PlatformFile? file) {
  if (file == null) return false;
  if (file.extension != 'pdf') return false;
  if (file.size > 20 * 1024) return false; // 20KB
  return true;
}

void _showError(String msg) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(msg)));
}

final Map<String, Map<String, List<String>>> courseMap = {
  'UG': {
    'B.E': [
      'Computer Science and Engineering',
      'Computer Science and Engineering (Cyber Security)',
      'Electronics and Communication Engineering',
    ],
    'B.Tech': [
      'Information Technology',
      'Artificial Intelligence and Data Science',
    ],
  },
  'PG': {
    'M.E': [
      'Computer Science and Engineering',
    ],
    'MBA': [
      'Master of Business Administration',
    ],
  },
};

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

Widget _yesNoRadio({
  required String label,
  required bool value,
  required ValueChanged<bool> onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 6),
      Row(
        children: [
          Expanded(
            child: RadioListTile<bool>(
              title: const Text('Yes'),
              value: true,
              groupValue: value,
              onChanged: (v) => onChanged(true),
              dense: true,
            ),
          ),
          Expanded(
            child: RadioListTile<bool>(
              title: const Text('No'),
              value: false,
              groupValue: value,
              onChanged: (v) => onChanged(false),
              dense: true,
            ),
          ),
        ],
      ),
    ],
  );
}


Widget _filePicker({
  required String label,
  required Function(PlatformFile file) onSelected,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,
          style: GoogleFonts.inter(
              fontSize: 12, fontWeight: FontWeight.w600)),
      const SizedBox(height: 6),
      OutlinedButton.icon(
        icon: const Icon(Icons.upload_file),
        label: const Text('Choose PDF'),
        onPressed: () async {
          final result = await FilePicker.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['pdf'],
            withData: true,
          );

          if (result != null && result.files.isNotEmpty) {
            onSelected(result.files.first);
          }
        },
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
      Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 6),
      DropdownButtonFormField<String>(
        isExpanded: true, // ✅ VERY IMPORTANT (FIXES YELLOW BOX)
        value: value,
        items: items
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  overflow: TextOverflow.ellipsis, // ✅ SAFETY
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    ],
  );
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