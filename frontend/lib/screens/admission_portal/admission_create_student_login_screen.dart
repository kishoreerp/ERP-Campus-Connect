import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';




class AdmissionCreateStudentLoginScreen extends StatefulWidget {
  const AdmissionCreateStudentLoginScreen({super.key});

  @override
  State<AdmissionCreateStudentLoginScreen> createState() =>
      _AdmissionCreateStudentLoginScreenState();
}

class _AdmissionCreateStudentLoginScreenState
    extends State<AdmissionCreateStudentLoginScreen> {

      String _generateTempPassword() {
  return 'Slec@${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
}


        // 🔑 Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController rollController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

String? _selectedRegulation;

final List<String> _regulations = [
  '2017',
  '2021',
  '2025',
];




  String? _selectedDepartment;
  String? _selectedYear;

  final List<String> _departments = [
    'Information Technology',
    'Computer Science Engineering',
    'CSE (Cyber Security)',
    'AI & Data Science',
    'Electronics And Communication',
    'MBA',
    'ME CSE'
  ];

  final List<String> _years = [
    '1st Year',
    '2nd Year',
    '3rd Year',
    'Final Year',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 12,
        title: Row(
          children: [
            
            
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Student Login ID',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Enter student details to generate login credentials',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),


      // ================= BODY =================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const SizedBox(height: 4),
            const Text(
              'student details ',
              style: TextStyle(color: Color.fromARGB(255, 176, 176, 176)),
            ),
            

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                 _inputField(
  'Student Name *',
  'Enter student name',
  controller: nameController,
  
),
_inputField(
  'Email Address *',
  'student@slec.edu.in',
  controller: emailController,
),
_inputField(
  'Phone Number *',
  '+91-XXXXX-XXXXX',
  controller: phoneController,
),


                  _dropdownField(
                    label: 'Department *',
                    hint: 'Select department',
                    value: _selectedDepartment,
                    items: _departments,
                    onChanged: (val) =>
                        setState(() => _selectedDepartment = val),
                  ),

                  _dropdownField(
                    label: 'Year *',
                    hint: 'Select year',
                    value: _selectedYear,
                    items: _years,
                    onChanged: (val) =>
                        setState(() => _selectedYear = val),
                  ),
                  _dropdownField(
                     label: 'Regulation *',
                     hint: 'Select regulation',
                      value: _selectedRegulation,
  items: _regulations,
  onChanged: (val) =>
      setState(() => _selectedRegulation = val),
),


                  _inputField(
  'Roll Number *',
  'Enter roll number',
  controller: rollController,
),
_inputField(
  'Address',
  'Enter student address',
  controller: addressController,
),



                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.person_add),
                      label: const Text(
                        'Create Student Login ID',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade400,
                        foregroundColor: const Color.fromARGB(255, 22, 22, 22),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _createStudentLogin,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= INPUT FIELD =================
  Widget _inputField(
  String label,
  String hint, {
  String? helper,
  TextEditingController? controller,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextField(
  controller: controller,
  obscureText: label.contains('Password'),

          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        if (helper != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              helper,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ),
      ],
    ),
  );
}

  // ================= DROPDOWN FIELD =================
  Widget _dropdownField({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: value,
            hint: Text(hint),
            items: items
                .map(
                  (item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ),
                )
                .toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
Future<void> _createStudentLogin() async {
  try {
    if (nameController.text.isEmpty ||
    emailController.text.isEmpty ||
    rollController.text.isEmpty ||
    _selectedDepartment == null ||
    _selectedYear == null ||
    _selectedRegulation == null) {
  throw 'Please fill all required fields';
}


    final email = emailController.text.trim();
    final tempPassword = _generateTempPassword();

    // 🔐 Create SECOND Firebase App (so admin stays logged in)
    FirebaseApp secondaryApp = await Firebase.initializeApp(
  name: 'Secondary-${DateTime.now().millisecondsSinceEpoch}',
  options: Firebase.app().options,
);


    FirebaseAuth secondaryAuth =
        FirebaseAuth.instanceFor(app: secondaryApp);

    // 1️⃣ CREATE AUTH USER (THIS MAKES IT APPEAR IN AUTHENTICATION)
    UserCredential cred =
        await secondaryAuth.createUserWithEmailAndPassword(
      email: email,
      password: tempPassword,
    );

    final uid = cred.user!.uid;

   // Decide program automatically
String program =
    _selectedDepartment == 'MBA' || _selectedDepartment == 'ME CSE'
        ? 'PG'
        : 'UG';

await FirebaseFirestore.instance.collection('users').doc(uid).set({
  'studentId': 'SLEC${DateTime.now().year}${rollController.text.trim()}',
  'username': nameController.text.trim(),
  'email': email,
  'phone': phoneController.text.trim(),
  'rollNo': rollController.text.trim(),
  'department': _selectedDepartment,
  'program': program,
  'year': _selectedYear,
  'regulation': _selectedRegulation,
  'role': 'student',
  'address': addressController.text.trim(),

  // Academic defaults
  'cgpa': 0.0,
  'attendance': 0,
  'semester': '',
  'subjects': 0,
  'arrears': 0,

  // Access control
  'status': 'active',

  'createdAt': Timestamp.now(),
});



    // 3️⃣ SEND PASSWORD SET EMAIL
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

    // 4️⃣ CLEAN UP SECOND APP
    await secondaryAuth.signOut();
    await secondaryApp.delete();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Student login created. Password setup email sent.',
        ),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.toString())),
    );
  }
}


}
