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

int currentStep = 0;

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


// Academic dynamic controllers

final TextEditingController school12Ctrl = TextEditingController();
final TextEditingController board12Ctrl = TextEditingController();
final TextEditingController year12Ctrl = TextEditingController();
final TextEditingController mark12Ctrl = TextEditingController();

final TextEditingController school10Ctrl = TextEditingController();
final TextEditingController board10Ctrl = TextEditingController();
final TextEditingController year10Ctrl = TextEditingController();
final TextEditingController mark10Ctrl = TextEditingController();

final TextEditingController collegeCtrl = TextEditingController();
final TextEditingController universityCtrl = TextEditingController();
final TextEditingController degreeYearCtrl = TextEditingController();
final TextEditingController degreePercentCtrl = TextEditingController();

PlatformFile? previousEducationFile;

bool isFirstGraduate = false;
bool hasNativityCert = false;
bool show12thDetails = false;
bool show10thDetails = false;

double percent12 = 0;
double percent10 = 0;


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
     body: Stepper(
  type: StepperType.vertical,
  currentStep: currentStep,
  onStepContinue: () {
    if (currentStep < 4) {
      setState(() => currentStep++);
    } else {
      _submitApplication();
    }
  },
  onStepCancel: () {
    if (currentStep > 0) {
      setState(() => currentStep--);
    }
  },
  controlsBuilder: (context, details) {

  // ❌ Hide buttons in Preview step
  if (currentStep == 4) {
    return const SizedBox(); 
  }

  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Row(
      children: [
        ElevatedButton(
          onPressed: details.onStepContinue,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Next',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(width: 12),
        if (currentStep > 0)
          TextButton(
            onPressed: details.onStepCancel,
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            child: const Text(
              'Back',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
      ],
    ),
  );
},


  steps: [
Step(
  title: const Text('Program & Personal Info'),
  isActive: currentStep >= 0,
  content: Column(
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
      const SizedBox(height: 1),
    ],
  ),
),
Step(
  title: const Text('Parents & Address'),
  isActive: currentStep >= 1,
  content: Column(
    children: [
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
      const SizedBox(height: 1),
    ],
  ),
),
Step(
  title: const Text('Academic Details'),
  isActive: currentStep >= 2,
  content: Column(
    children: [
      _section(
        title: 'Academic Information',
        subtitle: 'Provide your academic background',
        children: [
          // 🔽 Previous Education Dropdown
          _dropdown(
            label: 'Previous Education *',
            value: education,
            items: program == 'PG'
                ? [
                    '12th',
                    'Diploma',
                    'B.E',
                    'B.Tech',
                    'B.Sc',
                    'B.Com',
                    'BBA',
                    'Other Degree'
                  ]
                : ['12th', 'Diploma'],
            onChanged: (v) {
              setState(() {
                education = v;

                if (education == '12th') {
                  show12thDetails = true;
                  show10thDetails = true;
                } else {
                  show12thDetails = false;
                  show10thDetails = true;
                }
              });
            },
          ),
          const SizedBox(height: 15),

          // ==============================
          // ✅ CASE 1: IF 12TH SELECTED
          // ==============================
          if (education == '12th') ...[
            _input('12th School Name *', school12Ctrl),
            _input('12th Board *', board12Ctrl),
            _input('12th Year of Passing *', year12Ctrl),
            Row(
              children: [
                Expanded(
                  child: _input(
                    '12th Mark (Out of 600) *',
                    mark12Ctrl,
                    onChanged: (val) {
                      setState(() {
                        percent12 =
                            (double.tryParse(val) ?? 0) / 600 * 100;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    percent12 > 0
                        ? '${percent12.toStringAsFixed(2)} %'
                        : 'Percentage',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _input('10th School Name *', school10Ctrl),
            _input('10th Board *', board10Ctrl),
            _input('10th Year of Passing *', year10Ctrl),
            Row(
              children: [
                Expanded(
                  child: _input(
                    '10th Mark (Out of 500) *',
                    mark10Ctrl,
                    onChanged: (val) {
                      setState(() {
                        percent10 =
                            (double.tryParse(val) ?? 0) / 500 * 100;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    percent10 > 0
                        ? '${percent10.toStringAsFixed(2)} %'
                        : 'Percentage',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],

          // ==============================
          // ✅ CASE 2: OTHER THAN 12TH
          // ==============================
          if (education != null && education != '12th') ...[
            _input('$education Institution Name *', collegeCtrl),
            _input('University *', universityCtrl),
            _input('Year of Passing *', degreeYearCtrl),
            _input('Percentage / CGPA *', degreePercentCtrl),
            const SizedBox(height: 15),
            CheckboxListTile(
              value: show12thDetails,
              title: const Text("Add 12th Details"),
              onChanged: (v) {
                setState(() {
                  show12thDetails = v!;
                });
              },
            ),
            if (show12thDetails) ...[
              _input('12th School Name', school12Ctrl),
              _input('12th Board', board12Ctrl),
              _input('12th Year', year12Ctrl),
              Row(
  children: [
    Expanded(
      child: _input(
        '12th Mark (Out of 600)',
        mark12Ctrl,
        onChanged: (val) {
          setState(() {
            percent12 =
                (double.tryParse(val) ?? 0) / 600 * 100;
          });
        },
      ),
    ),
    const SizedBox(width: 10),
    Expanded(
      child: Text(
        percent12 > 0
            ? '${percent12.toStringAsFixed(2)} %'
            : 'Percentage',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  ],
),

            ],
            const SizedBox(height: 10),
            _input('10th School Name *', school10Ctrl),
            _input('10th Board *', board10Ctrl),
            _input('10th Year of Passing *', year10Ctrl),
            Row(
  children: [
    Expanded(
      child: _input(
        '10th Mark (Out of 500) *',
        mark10Ctrl,
        onChanged: (val) {
          setState(() {
            percent10 =
                (double.tryParse(val) ?? 0) / 500 * 100;
          });
        },
      ),
    ),
    const SizedBox(width: 10),
    Expanded(
      child: Text(
        percent10 > 0
            ? '${percent10.toStringAsFixed(2)} %'
            : 'Percentage',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  ],
),

          ],
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
      const SizedBox(height: 1),
    ],
  ),
),
Step(
  title: const Text('Document Upload'),
  isActive: currentStep >= 3,
  content: Column(
    children: [
      _section(
        title: 'Document Upload',
        subtitle: 'Upload required documents (PDF format, max 20kb each)',
        children: [

  const _FilePicker(label: 'Passport Size Photo *'),

  const _FilePicker(label: '10th Mark Sheet *'),

  // Show 12th only when needed
  if (education == '12th' || show12thDetails)
    const _FilePicker(label: '12th Mark Sheet *'),

  // Show diploma/degree marksheet only if NOT 12th
  if (education != null && education != '12th')
    _FilePicker(label: '$education Marksheet *'),

  const _FilePicker(label: 'Transfer Certificate *'),

  const _FilePicker(label: 'Community Certificate *'),

  if (isFirstGraduate)
    const _FilePicker(label: 'First Graduate Certificate *'),

  const _FilePicker(label: 'Income Certificate *'),

  if (hasNativityCert)
    const _FilePicker(label: 'Nativity Certificate *'),
],

      ),
      const SizedBox(height: 1),
    ],
  ),
),
Step(
  title: const Text('Preview'),
  isActive: currentStep >= 4,
  content: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        _previewSection("Program Details", [
          _previewItem("Program", program),
          _previewItem("Degree", degree),
          _previewItem("Course", preferredCourse),
        ]),

        _previewSection("Personal Information", [
          _previewItem("Full Name", fullNameCtrl.text),
          _previewItem("DOB", dobCtrl.text),
          _previewItem("Gender", gender),
          _previewItem("Blood Group", bloodGroupCtrl.text),
          _previewItem("Aadhaar", aadhaarCtrl.text),
          _previewItem("Email", emailCtrl.text),
          _previewItem("Phone", phoneCtrl.text),
        ]),

        _previewSection("Parents Information", [
          _previewItem("Father Name", fatherNameCtrl.text),
          _previewItem("Father Mobile", fatherMobileCtrl.text),
          _previewItem("Mother Name", motherNameCtrl.text),
          _previewItem("Mother Mobile", motherMobileCtrl.text),
          _previewItem("Guardian Name", guardianNameCtrl.text),
          _previewItem("Guardian Mobile", guardianMobileCtrl.text),
        ]),

        _previewSection("Address Details", [
          _previewItem("Door No", doorNoCtrl.text),
          _previewItem("Street", streetCtrl.text),
          _previewItem("Village", villageCtrl.text),
          _previewItem("Post", postCtrl.text),
          _previewItem("City", cityCtrl.text),
          _previewItem("Taluk", talukCtrl.text),
          _previewItem("District", districtCtrl.text),
          _previewItem("State", stateCtrl.text),
          _previewItem("Pincode", pincodeCtrl.text),
        ]),

        _previewSection("Academic Details", [
          _previewItem("Education", education),
          _previewItem("10th School", school10Ctrl.text),
          _previewItem("10th Mark", mark10Ctrl.text),
          _previewItem("12th School", school12Ctrl.text),
          _previewItem("12th Mark", mark12Ctrl.text),
          _previewItem("College", collegeCtrl.text),
          _previewItem("University", universityCtrl.text),
          _previewItem("Degree %", degreePercentCtrl.text),
        ]),

        _previewSection("Community Details", [
          _previewItem("Religion", religionCtrl.text),
          _previewItem("Caste", casteCtrl.text),
          _previewItem("Community", communityCtrl.text),
          _previewItem("Annual Income", annualIncomeCtrl.text),
          _previewItem("First Graduate", isFirstGraduate ? "Yes" : "No"),
          _previewItem("Nativity", hasNativityCert ? "Yes" : "No"),
        ]),

        const SizedBox(height: 25),

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

        const SizedBox(height: 15),
      ],
    ),
  ),
),

  ],),
    );
  }
  Widget _previewSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.only(bottom: 18),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _previewItem(String label, String? value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            (value == null || value.isEmpty) ? "-" : value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
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
      'previousEducation': education,

'12thSchool': school12Ctrl.text.trim(),
'12thBoard': board12Ctrl.text.trim(),
'12thYear': year12Ctrl.text.trim(),
'12thMark': mark12Ctrl.text.trim(),

'10thSchool': school10Ctrl.text.trim(),
'10thBoard': board10Ctrl.text.trim(),
'10thYear': year10Ctrl.text.trim(),
'10thMark': mark10Ctrl.text.trim(),

'collegeName': collegeCtrl.text.trim(),
'university': universityCtrl.text.trim(),
'degreeYear': degreeYearCtrl.text.trim(),
'degreePercentage': degreePercentCtrl.text.trim(),


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
  Function(String)? onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,
          style: GoogleFonts.inter(
              fontSize: 12, fontWeight: FontWeight.w600)),
      const SizedBox(height: 6),
      TextField(
        controller: controller,
        maxLines: maxLines,
        onChanged: onChanged,
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
    allowedExtensions: ['pdf'], // PDF ONLY
    withData: true,
  );

  if (result == null || result.files.isEmpty) return;

  final file = result.files.first;

  // Check file extension
  if (file.extension?.toLowerCase() != 'pdf') {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Only PDF files are allowed')),
    );
    return;
  }

  // Check file size (20KB = 20480 bytes)
  if (file.size > 20480) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('File must be 20KB or less')),
    );
    return;
  }

  setState(() {
    fileName = file.name;
  });
}


 @override
Widget build(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        widget.label,
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.black, // BLACK TEXT
        ),
      ),
      const SizedBox(height: 6),
      InkWell(
        onTap: _pickFile,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white, // WHITE BACKGROUND
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black, // BLACK BORDER
              width: 1,
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.upload_file,
                color: Colors.black, // BLACK ICON
              ),
              const SizedBox(width: 8),
              const Text(
                'Choose PDF',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Expanded(
                child: Text(
                  fileName,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black, // BLACK FILE NAME
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}

}