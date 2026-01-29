import 'package:flutter/material.dart';
import 'student_details_pdf_view.dart';

class UgSecondYearStudentsScreen extends StatelessWidget {
  const UgSecondYearStudentsScreen({super.key});

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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'UG Programs - 2nd Year',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 2),
            Text(
              '5 Students',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),

      // ================= BODY =================
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _StudentCard(
            name: 'Priya Singh',
            email: 'priya.singh@slec.edu.in',
            phone: '+91-98765-43211',
            studentId: 'SLEC20240002',
            rollNumber: 'IT2023002',
          ),
          _StudentCard(
            name: 'Anjali Verma',
            email: 'anjali.verma@slec.edu.in',
            phone: '+91-98765-43215',
            studentId: 'SLEC20240006',
            rollNumber: 'CSECS2023006',
          ),
          _StudentCard(
            name: 'Meera Iyer',
            email: 'meera.iyer@slec.edu.in',
            phone: '+91-98765-43219',
            studentId: 'SLEC20240010',
            rollNumber: 'AIDS2023010',
          ),
           _StudentCard(
            name:'Deepa Nair',
            email:'deepa.nair@slec.edu.in',
            phone:'+91-98765-43229',
            studentId:'SLEC20240020',
            rollNumber:'CSE2023020'
          ),
           _StudentCard(
            name:'Kavitha Menon',
            email:'kavitha.menon@slec.edu.in',
            phone:'+91-98765-43233',
            studentId:'SLEC20240024',
            rollNumber:'ECE2023024'
          ),
        ],
      ),
    );
  }
}

// ================= STUDENT CARD =================
class _StudentCard extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String studentId;
  final String rollNumber;

  const _StudentCard({
    required this.name,
    required this.email,
    required this.phone,
    required this.studentId,
    required this.rollNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -------- HEADER --------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    email,
                    style:
                        const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    phone,
                    style:
                        const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Active',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // -------- IDS --------
          Row(
            children: [
              _info('Student ID', studentId),
              const SizedBox(width: 12),
              _info('Roll Number', rollNumber),
            ],
          ),

          const SizedBox(height: 12),

          // -------- ACTIONS --------
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: 'Active',
                  items: const [
                     DropdownMenuItem(value: 'Active', child: Text('Active')),
                    DropdownMenuItem(value: 'Discontinued', child: Text('Discontinued')),
                    DropdownMenuItem(value: 'Transfer', child: Text('Transfer')),
                    DropdownMenuItem(value: 'Passed Out', child: Text('Passed Out')), 
                  ],
                  onChanged: (_) {},
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                icon: const Icon(Icons.remove_red_eye, size: 18),
                label: const Text('View Details'),
                onPressed: () {
                  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StudentDetailsPdfView(student:'student', 
         name: 'Pooja Sharma',
  email: 'pooja.sharma@slec.edu.in',
  admissionNumber: 'ADM2024014',
  department: 'MBA',
  studentPhone: '+91-98765-43223',
  parentPhone: '+91-97654-32114',
  address:
      'BTM Layout,\nBangalore, Karnataka - 560076',),
      ),
    );
                  // Navigate to student detail screen
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _info(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
