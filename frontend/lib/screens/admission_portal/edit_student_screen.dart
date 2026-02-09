import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditStudentScreen extends StatefulWidget {
  final String studentUid;

  const EditStudentScreen({super.key, required this.studentUid});

  @override
  State<EditStudentScreen> createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController parentPhoneCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController departmentCtrl = TextEditingController();


  String program = 'UG';
  String year = '1st Year';
  String department = '';
  String status = 'active';

  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadStudent();
  }

  Future<void> _loadStudent() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.studentUid)
        .get();

    final data = doc.data()!;
    nameCtrl.text = data['username'] ?? '';
    phoneCtrl.text = data['phone'] ?? '';
    parentPhoneCtrl.text = data['parentPhone'] ?? '';
    addressCtrl.text = data['address'] ?? '';

    program = data['program'] ?? 'UG';
    year = data['year'] ?? '1st Year';
      departmentCtrl.text = data['department'] ?? '';
    status = data['status'] ?? 'active';

    setState(() => loading = false);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.studentUid)
        .update({
      'username': nameCtrl.text.trim(),
      'phone': phoneCtrl.text.trim(),
      'parentPhone': parentPhoneCtrl.text.trim(),
      'address': addressCtrl.text.trim(),
      'program': program,
      'year': year,
      'department': departmentCtrl.text.trim(),

      'status': status,
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Student updated successfully')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
  elevation: 0,
  backgroundColor: Colors.white,
  title: const Text(
    'Edit Student',
    style: TextStyle(fontWeight: FontWeight.bold),
  ),
  actions: const [
    Padding(
      padding: EdgeInsets.only(right: 12),
      child: Icon(Icons.school, color: Colors.black),
    ),
  ],
),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child:ListView(
  children: [
    _textField('Student Name', nameCtrl),
    _textField('Phone', phoneCtrl),
    _textField('Parent Phone', parentPhoneCtrl, required: false),
    _textField('Address', addressCtrl, maxLines: 2, required: false),

    const SizedBox(height: 12),

    _dropdown(
      label: 'Program',
      value: program,
      items: const ['UG', 'PG'],
      onChanged: (v) => setState(() => program = v!),
    ),

    _dropdown(
      label: 'Year',
      value: year,
      items: const ['1st Year', '2nd Year', '3rd Year', 'Final Year'],
      onChanged: (v) => setState(() => year = v!),
    ),

    _textField('Department', departmentCtrl),

    _dropdown(
      label: 'Status',
      value: status,
      items: const ['active', 'discontinued', 'transfer', 'passed_out'],
      onChanged: (v) => setState(() => status = v!),
    ),

    const SizedBox(height: 100),
  ],
)


        ),
      ),
      bottomNavigationBar: Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.08),
        blurRadius: 10,
        offset: const Offset(0, -2),
      ),
    ],
  ),
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF2563EB),
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),
    onPressed: _save,
    child: const Text(
      'Save Changes',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),
),

    );
  }

 Widget _textField(
  String label,
  TextEditingController controller, {
  int maxLines = 1,
  bool required = true,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: required
          ? (v) => v == null || v.isEmpty ? 'Required field' : null
          : null,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}


  Widget _dropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items
            .map(
              (e) => DropdownMenuItem(value: e, child: Text(e)),
            )
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
  labelText: label,
  filled: true,
  fillColor: Colors.grey.shade100,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide.none,
  ),
),

      ),
    );
  }
  Widget _sectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8, top: 16),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    ),
  );
}

Widget _card({required Widget child}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade200),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: child,
  );
}

}
