import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:printing/printing.dart';
import 'application_pdf_generator.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
final TextEditingController fatherOccupationCtrl = TextEditingController();
final TextEditingController motherNameCtrl = TextEditingController();
final TextEditingController motherMobileCtrl = TextEditingController();
final TextEditingController motherOccupationCtrl = TextEditingController();
final TextEditingController guardianNameCtrl = TextEditingController();
final TextEditingController guardianMobileCtrl = TextEditingController();
final TextEditingController guardianOccupationCtrl = TextEditingController();


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
PlatformFile? passportPhotoFile;
PlatformFile? digitalSignatureFile;
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

late final String formDate;
@override
void initState() {
  super.initState();

  final now = DateTime.now();
  formDate =
      "${now.day.toString().padLeft(2, '0')}-"
      "${now.month.toString().padLeft(2, '0')}-"
      "${now.year}";
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color.fromARGB(255, 250, 250, 250),
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
  if (!_validateCurrentStep()) return;

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
          _dobField(),
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
          _numberInput(
  'Aadhaar Number *',
  aadhaarCtrl,
  maxLength: 12,
  hint: '12 digit Aadhaar number',
),
          _emailInput(),
         _numberInput(
  'Phone Number *',
  phoneCtrl,
  maxLength: 10,
),
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
_numberInput('Father Mobile Number (Required if provided)', fatherMobileCtrl,maxLength: 10,),
_input('Father Occupation (Required if mobile provided)', fatherOccupationCtrl),

_input('Mother Name *', motherNameCtrl),
_numberInput('Mother Mobile Number (Required if provided)', motherMobileCtrl,maxLength: 10,),
_input('Mother Occupation (Required if mobile provided)', motherOccupationCtrl),

_input('Guardian Name (if applicable)', guardianNameCtrl),
_numberInput('Guardian Mobile Number (Optional)', guardianMobileCtrl,maxLength: 10,),
_input('Guardian Occupation (Optional)', guardianOccupationCtrl),
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
          _input(
  'Community Certificate Number *',
  communityCertNoCtrl,
  inputFormatters: [
    TNCertificateFormatter(),
    LengthLimitingTextInputFormatter(16),
  ],
),
          _input(
            'Annual Income (₹) *',
            annualIncomeCtrl,
            hint: 'Numbers only',
          ),
          _input('Income Certificate Number *', incomeCertNoCtrl,inputFormatters: [
              TNCertificateFormatter(),
               LengthLimitingTextInputFormatter(16),
              ],),
          _yesNoRadio(
            label: 'First Graduate *',
            value: isFirstGraduate,
            onChanged: (v) => setState(() => isFirstGraduate = v),
          ),
          if (isFirstGraduate)
            _input(
              'First Graduate Certificate Number *',
              firstGraduateCertNoCtrl,
              inputFormatters: [
              TNCertificateFormatter(),
               LengthLimitingTextInputFormatter(16),
              ],
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
              inputFormatters: [
              TNCertificateFormatter(),
               LengthLimitingTextInputFormatter(16),
              ],
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

  _ImagePicker(
  label: 'Passport Size Photo *',
  onFileSelected: (file) {
    setState(() {
      passportPhotoFile = file;
    });
  },
),
  _ImagePicker(
  label: 'Digital Signature *',
  onFileSelected: (file) {
    setState(() {
      digitalSignatureFile = file;
    });
  },
),

  const _FilePicker(label: '10th Mark Sheet *'),

  // Show 12th only when needed
  if (education == '12th' || show12thDetails)
    const _FilePicker(label: '12th Mark Sheet *'),

  // Show diploma/degree marksheet only if NOT 12th
  if (education != null && education != '12th')
    _FilePicker(label: '$education Marksheet *'),

  _FilePicker(label: 'Transfer Certificate *'),

 _FilePicker(
  label: 'Community Certificate *',
  onFileSelected: (file) {
    setState(() {
      communityCertFile = file;
    });
  },
),

  if (isFirstGraduate)
    _FilePicker(
      label: 'First Graduate Certificate *',
      onFileSelected: (file) {
        setState(() {
          firstGraduateCertFile = file;
        });
      },
    ),

 _FilePicker(
  label: 'Income Certificate *',
  onFileSelected: (file) {
    setState(() {
      incomeCertFile = file;
    });
  },
),

  if (hasNativityCert)
    _FilePicker(
      label: 'Nativity Certificate *',
      onFileSelected: (file) {
        setState(() {
          nativityCertFile = file;
        });
      },
    ),
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
    child: Container(
      padding: const EdgeInsets.all(24),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ====================== HEADER ======================
         Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [

    // Logo
    FutureBuilder<ByteData>(
      future: rootBundle.load('assets/images/college_logo.png'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(width: 90, height: 90);
        }

        return SizedBox(
          width: 90,
          height: 90,
          child: Image.memory(
            snapshot.data!.buffer.asUint8List(),
            fit: BoxFit.contain,
          ),
        );
      },
    ),

    const SizedBox(width: 2), // 👈 closer spacing

    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "ST. LOURDES ENGINEERING COLLEGE",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 170, 2, 2),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Approved by AICTE, New Delhi & Affiliated to Anna University, Chennai",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Thanir Arul Nagar, Perambalur - 621 212",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "044-24748071 | 8181861735 | 8900500600",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "www.slec.edu.in | info@slec.edu.in",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "ADMISSION APPLICATION FORM",
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    ),

    const SizedBox(width: 10),

    // Photo
    Container(
      width: 100,
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: passportPhotoFile != null
          ? Image.memory(
              passportPhotoFile!.bytes!,
              fit: BoxFit.cover,
            )
          : const Center(child: Text("Photo")),
    ),
  ],
),
          const SizedBox(height: 10),
          const Divider(thickness: 1),

          // ====================== PROGRAM ======================
          _professionalSection("Program Details", [
            _tableRow("Program", program),
            _tableRow("Degree", degree),
            _tableRow("Department", preferredCourse),
          ]),

          // ====================== PERSONAL ======================
          _professionalSection("Personal Information", [
            _tableRow("Full Name", fullNameCtrl.text),
            _tableRow("Date of Birth", dobCtrl.text),
            _tableRow("Gender", gender),
            _tableRow("Blood Group", bloodGroupCtrl.text),
            _tableRow("Aadhaar Number", aadhaarCtrl.text),
            _tableRow("Email Address", emailCtrl.text),
            _tableRow("Mobile Number", phoneCtrl.text),
          ]),

          // ====================== PARENTS ======================
          _professionalSection("Parents / Guardian Details", [
            _tableRow("Father Name", fatherNameCtrl.text),
            _tableRow("Father Mobile", fatherMobileCtrl.text),
            _tableRow("Father Occupation", fatherOccupationCtrl.text),
            _tableRow("Mother Name", motherNameCtrl.text),
            _tableRow("Mother Mobile", motherMobileCtrl.text),
            _tableRow("Mother Occupation", motherOccupationCtrl.text),
            _tableRow("Guardian Name", guardianNameCtrl.text),
            _tableRow("Guardian Mobile", guardianMobileCtrl.text),
            _tableRow("Guardian Occupation", guardianOccupationCtrl.text),
          ]),

          // ====================== ADDRESS ======================
          _professionalSection("Address", [
            _tableRow(
              "Permanent Address",
              "${doorNoCtrl.text}, ${streetCtrl.text}, "
              "${villageCtrl.text}, ${cityCtrl.text}, "
              "${districtCtrl.text}, ${stateCtrl.text} - ${pincodeCtrl.text}",
            ),
          ]),

          // ====================== ACADEMIC ======================
          _professionalSection("Academic Details", [
            _tableRow("Previous Education", education),
            _tableRow("10th School", school10Ctrl.text),
            _tableRow("10th Mark", mark10Ctrl.text),
            _tableRow("12th School", school12Ctrl.text),
            _tableRow("12th Mark", mark12Ctrl.text),
            _tableRow("College", collegeCtrl.text),
            _tableRow("University", universityCtrl.text),
            _tableRow("Degree Percentage", degreePercentCtrl.text),
          ]),

         
_professionalSection("Community & Certificates", [
  _tableRow("EMIS ID", emisIdCtrl.text),
  _tableRow("Religion", religionCtrl.text),
  _tableRow("Caste", casteCtrl.text),
  _tableRow("Community", communityCtrl.text),
  _tableRow("Community Certificate No", communityCertNoCtrl.text),
  _tableRow("Annual Income", annualIncomeCtrl.text),
  _tableRow("Income Certificate No", incomeCertNoCtrl.text),
  _tableRow("First Graduate", isFirstGraduate ? "Yes" : "No"),
  _tableRow("First Graduate Cert No", firstGraduateCertNoCtrl.text),
  _tableRow("Nativity Certificate", hasNativityCert ? "Yes" : "No"),
  _tableRow("Nativity Cert No", nativityCertNoCtrl.text),
]),
          // ====================== DECLARATION ======================
          Text(
            "Declaration",
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "I hereby declare that the information provided above is true "
            "and correct to the best of my knowledge.",
            style: GoogleFonts.inter(fontSize: 12),
          ),

          const SizedBox(height: 45),

          // ====================== SIGNATURE ======================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
  children: [
    digitalSignatureFile != null
        ? Image.memory(
            digitalSignatureFile!.bytes!,
            width: 120,
            height: 50,
          )
        : const Text("_____________________"),
    const SizedBox(height: 4),
    const Text("Applicant Signature"),
  ],
),
              Column(
  children: [
    Text(formDate),
    const SizedBox(height: 4),
    const Text("Date"),
  ],
),
            ],
          ),

          const SizedBox(height: 30),

          // ====================== BUTTONS ======================
          // SUBMIT BUTTON
SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: _submitApplication,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
    
    ),
    child: const Text(
      "Submit Application",
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
  ),
),
const SizedBox(height: 12),
SizedBox(
  width: double.infinity,
  child: ElevatedButton.icon(
    onPressed: _downloadPdf,
    icon: const Icon(Icons.download),
    label: const Text("Download PDF"),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
    ),
  ),
),

const SizedBox(height: 12),

// GO BACK BUTTON
SizedBox(
  width: double.infinity,
  child: OutlinedButton(
    onPressed: () {
      setState(() {
        currentStep = 3; // 👈 Go back to Document Upload step
      });
    },
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: Colors.black),
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    child: const Text(
      "Go Back & Edit",
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
),

        ],
      ),
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

Widget _professionalSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.only(bottom: 20),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          color: Colors.grey.shade200,
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ),
        ...children,
      ],
    ),
  );
}

Widget _tableRow(String label, String? value) {
  return Container(
    decoration: const BoxDecoration(
      border: Border(
        top: BorderSide(color: Colors.black),
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 180,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(color: Colors.black),
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              (value == null || value.isEmpty) ? "-" : value,
            ),
          ),
        ),
      ],
    ),
  );
}
Widget _emailInput() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Email Address *',
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 6),
      TextField(
        controller: emailCtrl,
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          final lower = value.toLowerCase();

          if (value != lower) {
            emailCtrl.value = TextEditingValue(
              text: lower,
              selection: TextSelection.collapsed(offset: lower.length),
            );
          }
        },
        decoration: InputDecoration(
          hintText: 'student@gmail.com',
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

Widget _numberInput(
  String label,
  TextEditingController controller, {
  required int maxLength,
  String? hint,
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
      TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly, // ✅ numbers only
          LengthLimitingTextInputFormatter(maxLength), // ✅ limit length
        ],
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey[100],
          counterText: "", // hides counter
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    ],
  );
}

Widget _dobField() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Date of Birth *',
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 6),
      TextField(
        controller: dobCtrl,
        readOnly: true, // 🔒 Prevent manual typing
        decoration: InputDecoration(
          hintText: 'Select Date',
          filled: true,
          fillColor: Colors.grey[100],
          suffixIcon: const Icon(Icons.calendar_today),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        onTap: () async {
  FocusScope.of(context).unfocus();

  await Future.delayed(const Duration(milliseconds: 150));

  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime(2005),
    firstDate: DateTime(1980),
    lastDate: DateTime.now(),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF2563EB),
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
          datePickerTheme: DatePickerThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        child: child!,
      );
    },
  );

  if (pickedDate != null) {
    setState(() {
      dobCtrl.text =
          "${pickedDate.day.toString().padLeft(2, '0')}-"
          "${pickedDate.month.toString().padLeft(2, '0')}-"
          "${pickedDate.year}";
    });
  }
},
      ),
    ],
  );
}

Widget _docRow(String label, String? value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          child: Text(
            "$label :",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            (value == null || value.isEmpty) ? "-" : value,
          ),
        ),
      ],
    ),
  );
}

Widget _sectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
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


Future<String?> uploadFileToStorage(
    PlatformFile? file,
    String folder,
) async {
  if (file == null || file.bytes == null) return null;

  final fileName =
      "${DateTime.now().millisecondsSinceEpoch}_${file.name}";

  final ref = FirebaseStorage.instance
      .ref()
      .child("admission_uploads/$folder/$fileName");

  await ref.putData(file.bytes!);

  return await ref.getDownloadURL();
}

  Future<bool> _isEmailAlreadyUsed(String email) async {
  final result = await FirebaseFirestore.instance
      .collection('admission_forms')
      .where('email', isEqualTo: email)
      .limit(1)
      .get();

  return result.docs.isNotEmpty;
}

bool _validateCurrentStep() {
    switch (currentStep) {

      case 0:
  if (program == null || degree == null || preferredCourse == null) {
    _showTopPopup('Please select Program, Degree and Course');
    return false;
  }

  if (fullNameCtrl.text.trim().isEmpty ||
      dobCtrl.text.trim().isEmpty ||
      gender == null ||
      emailCtrl.text.trim().isEmpty ||
      phoneCtrl.text.trim().isEmpty ||
      aadhaarCtrl.text.trim().isEmpty) {
    _showTopPopup('Please fill all personal details');
    return false;
  }

  // ✅ Aadhaar must be exactly 12 digits
  if (!RegExp(r'^\d{12}$').hasMatch(aadhaarCtrl.text.trim())) {
    _showTopPopup('Aadhaar number must be exactly 12 digits');
    return false;
  }

  // ✅ Student Mobile must be exactly 10 digits
  if (!RegExp(r'^\d{10}$').hasMatch(phoneCtrl.text.trim())) {
    _showTopPopup('Mobile number must be exactly 10 digits');
    return false;
  }

  // ✅ EMAIL VALIDATION HERE
  final email = emailCtrl.text.trim();
  final emailRegex = RegExp(
    r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$',
  );

  if (!emailRegex.hasMatch(email)) {
    _showTopPopup('Enter valid email format (example: student@gmail.com)');
    return false;
  }

  return true;

  case 3:

  if (passportPhotoFile == null) {
    _showTopPopup('Passport photo is required');
    return false;
  }

if (passportPhotoFile == null) {
  _showTopPopup('Passport photo is required');
  return false;
}

final ext = passportPhotoFile!.extension?.toLowerCase();
if (!['png', 'jpg', 'jpeg'].contains(ext)) {
  _showTopPopup('Passport photo must be PNG/JPG/JPEG');
  return false;
}

if (passportPhotoFile!.size > 20 * 1024) {
  _showTopPopup('Passport photo must be ≤ 20KB');
  return false;
}
  if (communityCertFile == null) {
    _showTopPopup('Community certificate is required');
    return false;
  }

  if (!validatePdf(communityCertFile)) {
    _showTopPopup('Community certificate must be PDF ≤ 20KB');
    return false;
  }

  if (incomeCertFile == null) {
    _showTopPopup('Income certificate is required');
    return false;
  }

  if (!validatePdf(incomeCertFile)) {
    _showTopPopup('Income certificate must be PDF ≤ 20KB');
    return false;
  }

  if (isFirstGraduate) {
    if (firstGraduateCertFile == null) {
      _showTopPopup('First Graduate certificate is required');
      return false;
    }

    if (!validatePdf(firstGraduateCertFile)) {
      _showTopPopup('First Graduate certificate must be PDF ≤ 20KB');
      return false;
    }
  }

  if (hasNativityCert) {
    if (nativityCertFile == null) {
      _showTopPopup('Nativity certificate is required');
      return false;
    }

    if (!validatePdf(nativityCertFile)) {
      _showTopPopup('Nativity certificate must be PDF ≤ 20KB');
      return false;
    }
  }

  return true;

      case 1:
  final fatherMobile = fatherMobileCtrl.text.trim();
  final motherMobile = motherMobileCtrl.text.trim();
  final guardianMobile = guardianMobileCtrl.text.trim();

  final fatherOccupation = fatherOccupationCtrl.text.trim();
  final motherOccupation = motherOccupationCtrl.text.trim();
  final guardianOccupation = guardianOccupationCtrl.text.trim();

  // 🔴 At least one parent/guardian name required
  if (fatherNameCtrl.text.trim().isEmpty &&
      motherNameCtrl.text.trim().isEmpty &&
      guardianNameCtrl.text.trim().isEmpty) {
    _showTopPopup('Enter at least one Parent/Guardian name');
    return false;
  }

  // 🔴 At least one contact number required
  if (fatherMobile.isEmpty &&
      motherMobile.isEmpty &&
      guardianMobile.isEmpty) {
    _showTopPopup('At least one contact number is required');
    return false;
  }

  // 🔴 Validate mobile lengths
  if (fatherMobile.isNotEmpty && fatherMobile.length != 10) {
    _showTopPopup('Father mobile must be 10 digits');
    return false;
  }

  if (motherMobile.isNotEmpty && motherMobile.length != 10) {
    _showTopPopup('Mother mobile must be 10 digits');
    return false;
  }

  if (guardianMobile.isNotEmpty && guardianMobile.length != 10) {
    _showTopPopup('Guardian mobile must be 10 digits');
    return false;
  }

  // 🔴 IMPORTANT: Occupation required if mobile provided
  if (fatherMobile.isNotEmpty && fatherOccupation.isEmpty) {
    _showTopPopup('Father occupation is required if father mobile is provided');
    return false;
  }

  if (motherMobile.isNotEmpty && motherOccupation.isEmpty) {
    _showTopPopup('Mother occupation is required if mother mobile is provided');
    return false;
  }

  if (guardianMobile.isNotEmpty && guardianOccupation.isEmpty) {
    _showTopPopup('Guardian occupation is required if guardian mobile is provided');
    return false;
  }

  // 🔴 Address validation
  if (doorNoCtrl.text.trim().isEmpty ||
      streetCtrl.text.trim().isEmpty ||
      villageCtrl.text.trim().isEmpty ||
      postCtrl.text.trim().isEmpty ||
      cityCtrl.text.trim().isEmpty ||
      talukCtrl.text.trim().isEmpty ||
      districtCtrl.text.trim().isEmpty ||
      stateCtrl.text.trim().isEmpty ||
      pincodeCtrl.text.trim().isEmpty) {
    _showTopPopup('Please fill all address fields');
    return false;
  }

  if (!RegExp(r'^\d{6}$').hasMatch(pincodeCtrl.text.trim())) {
    _showTopPopup('Enter valid 6-digit pincode');
    return false;
  }

  return true;

      case 2:
        if (education == null) {
          _showTopPopup('Please select previous education');
          return false;
        }
        return true;

      default:
        return true;
    }
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

// ✅ ADD THIS BLOCK HERE
final fatherMobile = fatherMobileCtrl.text.trim();
final motherMobile = motherMobileCtrl.text.trim();
final guardianMobile = guardianMobileCtrl.text.trim();

final fatherOccupation = fatherOccupationCtrl.text.trim();
final motherOccupation = motherOccupationCtrl.text.trim();
final guardianOccupation = guardianOccupationCtrl.text.trim();

// ✅ THEN your conditional validation


    if (fullNameCtrl.text.trim().isEmpty ||
    emailCtrl.text.trim().isEmpty ||
    phoneCtrl.text.trim().isEmpty ||
    gender == null ||
    program == null ||
    degree == null ||
    preferredCourse == null ||
    education == null) {
  _showTopPopup('Please fill all required fields');
  return;
}

    final fullAddress =
        '${doorNoCtrl.text}, ${streetCtrl.text}, ${villageCtrl.text}, '
        '${postCtrl.text}, ${cityCtrl.text}, ${talukCtrl.text}, '
        '${districtCtrl.text}, ${stateCtrl.text} - ${pincodeCtrl.text}';
if (!validatePdf(communityCertFile)) {
  _showTopPopup('Community certificate must be PDF ≤ 20KB');
  return;
}

if (isFirstGraduate && !validatePdf(firstGraduateCertFile)) {
  _showTopPopup('First Graduate certificate must be PDF ≤ 20KB');
  return;
}

if (!validatePdf(incomeCertFile)) {
  _showTopPopup('Income certificate must be PDF ≤ 20KB');
  return;
}

if (hasNativityCert && !validatePdf(nativityCertFile)) {
  _showTopPopup('Nativity certificate must be PDF ≤ 20KB');
  return;
}

if (!RegExp(r'^\d+$').hasMatch(annualIncomeCtrl.text)) {
  _showTopPopup('Annual income must contain numbers only');
  return;
}

// ================= FILE UPLOAD TO FIREBASE STORAGE =================
//final photoUrl =await uploadFileToStorage(passportPhotoFile, "photos");
//final signatureUrl =await uploadFileToStorage(digitalSignatureFile, "signatures");
//final communityUrl =await uploadFileToStorage(communityCertFile, "community");
//final incomeUrl =await uploadFileToStorage(incomeCertFile, "income");
//final firstGraduateUrl =await uploadFileToStorage(firstGraduateCertFile, "first_graduate");
//final nativityUrl =await uploadFileToStorage(nativityCertFile, "nativity");
//rules_version = '2';service firebase.storage {  match /b/{bucket}/o {match /{allPaths=**} { allow read, write: if true; }}}
  
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
'fatherOccupation': fatherOccupationCtrl.text.trim(),
'motherName': motherNameCtrl.text.trim(),
'motherMobile': motherMobileCtrl.text.trim(),
'motherOccupation': motherOccupationCtrl.text.trim(),
'guardianName': guardianNameCtrl.text.trim(),
'guardianMobile': guardianMobileCtrl.text.trim(),
'guardianOccupation': guardianOccupationCtrl.text.trim(),
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
//'photoUrl': photoUrl,
//'signatureUrl': signatureUrl,
//'communityCertUrl': communityUrl,
//'incomeCertUrl': incomeUrl,
//'firstGraduateCertUrl': firstGraduateUrl,
//'nativityCertUrl': nativityUrl,

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
void _showTopPopup(String message) {
  final overlay = Overlay.of(context);

  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 300),
          tween: Tween(begin: -50.0, end: 0.0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, value),
              child: child,
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.red.shade600,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                )
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.error_outline,
                    color: Colors.white),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    message,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 3), () {
    overlayEntry.remove();
  });
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
Future<void> _downloadPdf() async {

  // ✅ LOAD LOGO FROM ASSET
  final logoData =
      await rootBundle.load('assets/images/college_logo.png');
  final logoBytes = logoData.buffer.asUint8List();

  final fullAddress =
      '${doorNoCtrl.text}, ${streetCtrl.text}, ${villageCtrl.text}, '
      '${postCtrl.text}, ${cityCtrl.text}, ${talukCtrl.text}, '
      '${districtCtrl.text}, ${stateCtrl.text} - ${pincodeCtrl.text}';


  final pdfBytes = await ApplicationPdfGenerator.generate(
    data: {
  'program': program,
  'degree': degree,
  'department': preferredCourse,

  'fullName': fullNameCtrl.text,
  'dob': dobCtrl.text,
  'gender': gender,
  'bloodGroup': bloodGroupCtrl.text,
  'aadhaar': aadhaarCtrl.text,
  'email': emailCtrl.text,
  'phone': phoneCtrl.text,
  'address': fullAddress,

  'fatherName': fatherNameCtrl.text,
  'fatherMobile': fatherMobileCtrl.text,
  'fatherOccupation': fatherOccupationCtrl.text,
  'motherName': motherNameCtrl.text,
  'motherMobile': motherMobileCtrl.text,
  'motherOccupation': motherOccupationCtrl.text,
  'guardianName': guardianNameCtrl.text,
  'guardianMobile': guardianMobileCtrl.text,
  'guardianOccupation': guardianOccupationCtrl.text,

  'previousEducation': education,
  '10thMark': mark10Ctrl.text,
  '12thMark': mark12Ctrl.text,
  'degreePercentage': degreePercentCtrl.text,

  'emisId': emisIdCtrl.text,
  'religion': religionCtrl.text,
  'caste': casteCtrl.text,
  'community': communityCtrl.text,
  'communityCertNo': communityCertNoCtrl.text,
  'annualIncome': annualIncomeCtrl.text,
  'incomeCertNo': incomeCertNoCtrl.text,
  'isFirstGraduate': isFirstGraduate,
  'firstGraduateCertNo': firstGraduateCertNoCtrl.text,
  'hasNativityCert': hasNativityCert,
  'nativityCertNo': nativityCertNoCtrl.text,

  'formDate': formDate,
},
    photoBytes: passportPhotoFile?.bytes,
    signatureBytes: digitalSignatureFile?.bytes,
    logoBytes: logoBytes, // ✅ THIS WAS MISSING
  );


  await Printing.layoutPdf(
    onLayout: (format) async => pdfBytes,
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
  Function(String)? onChanged,
  List<TextInputFormatter>? inputFormatters,
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
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          hintText: hint ,
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
          final result = await FilePicker.platform.pickFiles(
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

class TNCertificateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
  ) {
    String text = newValue.text.toUpperCase();

    // Ensure it starts with TN-
    if (!text.startsWith('TN-')) {
      text = 'TN-' + text.replaceAll(RegExp(r'[^0-9]'), '');
    } else {
      text = 'TN-' + text.substring(3).replaceAll(RegExp(r'[^0-9]'), '');
    }

    // Limit to 13 digits after TN-
    if (text.length > 16) {
      text = text.substring(0, 16);
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
// ---------- File Picker UI (visual only) ----------

class _FilePicker extends StatefulWidget {
  final String label;
  final Function(PlatformFile?)? onFileSelected;

  const _FilePicker({
    required this.label,
    this.onFileSelected,
  });

  @override
  State<_FilePicker> createState() => _FilePickerState();
}

class _FilePickerState extends State<_FilePicker> {
  PlatformFile? selectedFile;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true,
    );

    if (result == null || result.files.isEmpty) return;

    final file = result.files.first;

    if (file.extension?.toLowerCase() != 'pdf') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Only PDF files allowed')),
      );
      return;
    }

    if (file.size > 20480) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File must be 20KB or less')),
      );
      return;
    }

    setState(() {
      selectedFile = file;
    });

    widget.onFileSelected?.call(file);
  }

  void _removeFile() {
    setState(() {
      selectedFile = null;
    });

    widget.onFileSelected?.call(null);
  }

void _viewFile() {
  if (selectedFile == null) return;

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PdfViewerPage(file: selectedFile!),
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    final isUploaded = selectedFile != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),

        Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isUploaded ? Colors.green : Colors.black,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isUploaded ? Icons.check_circle : Icons.upload_file,
                color: isUploaded ? Colors.green : Colors.black,
              ),
              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  isUploaded
                      ? selectedFile!.name
                      : 'Choose PDF (Max 20KB)',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: isUploaded ? Colors.green : Colors.black,
                    fontWeight:
                        isUploaded ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),

              if (!isUploaded)
                TextButton(
                  onPressed: _pickFile,
                  child: const Text("Upload"),
                ),

              if (isUploaded) ...[
                IconButton(
                  icon: const Icon(Icons.visibility),
                  onPressed: _viewFile,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: _removeFile,
                ),
              ],
            ],
          ),
        ),

        const SizedBox(height: 12),
      ],
    );
  }
}
class _ImagePicker extends StatefulWidget {
  final String label;
  final Function(PlatformFile?)? onFileSelected;

  const _ImagePicker({
    required this.label,
    this.onFileSelected,
  });

  @override
  State<_ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<_ImagePicker> {
  PlatformFile? selectedImage;

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
      withData: true,
    );

    if (result == null || result.files.isEmpty) return;

    final file = result.files.first;

    final ext = file.extension?.toLowerCase();

    if (!['png', 'jpg', 'jpeg'].contains(ext)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Only PNG/JPG/JPEG allowed')),
      );
      return;
    }

    if (file.size > 20 * 1024) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image must be 20KB or less')),
      );
      return;
    }

    setState(() {
      selectedImage = file;
    });

    widget.onFileSelected?.call(file);
  }

  void _removeImage() {
    setState(() {
      selectedImage = null;
    });

    widget.onFileSelected?.call(null);
  }

  @override
  Widget build(BuildContext context) {
    final isUploaded = selectedImage != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
            style: GoogleFonts.inter(
                fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(
              vertical: 14, horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(
                color: isUploaded ? Colors.green : Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                isUploaded
                    ? Icons.check_circle
                    : Icons.image,
                color:
                    isUploaded ? Colors.green : Colors.black,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isUploaded
                      ? selectedImage!.name
                      : 'Choose PNG/JPG (Max 20KB)',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (!isUploaded)
                TextButton(
                  onPressed: _pickImage,
                  child: const Text("Upload"),
                ),
              if (isUploaded)
                IconButton(
                  icon: const Icon(Icons.delete,
                      color: Colors.red),
                  onPressed: _removeImage,
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}class PdfViewerPage extends StatelessWidget {
  final PlatformFile file;

  const PdfViewerPage({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(file.name),
        backgroundColor: Colors.black,
      ),
      body: _buildPdf(),
    );
  }

  Widget _buildPdf() {
    // 🔥 IMPORTANT FIX FOR WEB
    if (kIsWeb) {
      if (file.bytes == null) {
        return const Center(child: Text("PDF data not available"));
      }

      return SfPdfViewer.memory(
        file.bytes!,
        key: UniqueKey(), // 👈 VERY IMPORTANT FIX
      );
    }

    // Mobile/Desktop
    if (file.path != null) {
      return SfPdfViewer.file(File(file.path!));
    }

    if (file.bytes != null) {
      return SfPdfViewer.memory(file.bytes!);
    }

    return const Center(child: Text("Unable to load PDF"));
  }
}