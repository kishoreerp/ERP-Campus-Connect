import 'package:flutter/material.dart';
import 'student_model.dart';
import 'student_details_pdf_view.dart';


class UgFirstYearStudentsScreen extends StatelessWidget {
  const UgFirstYearStudentsScreen({super.key});

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
              'UG Programs - 1st Year',
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
            name: 'Rahul Sharma',
            email: 'rahul.sharma@slec.edu.in',
            phone: '+91-98765-43210',
            studentId: 'SLEC20240001',
            rollNumber: 'IT2024001',
          ),
          _StudentCard(
            name: 'Vikram Reddy',
            email: 'vikram.reddy@slec.edu.in',
            phone: '+91-98765-43214',
            studentId: 'SLEC20240005',
            rollNumber: 'CSECS2024005',
          ),
          _StudentCard(
            name: 'Arjun Menon',
            email: 'arjun.menon@slec.edu.in',
            phone: '+91-98765-43218',
            studentId: 'SLEC20240009',
            rollNumber: 'AIDS2024009',
          ),
          _StudentCard(
            name:'Ravi Shankar',
            email:'shankar@slec.edu.in',
            phone:'+91-98765-43228',
            studentId:'SLEC20240019',
            rollNumber:'CSE2024019',
          ),
           _StudentCard(
            name:'Suresh Kumar',
            email:'suresh.kumar@slec.edu.in',
            phone:'+91-98765-43232',
            studentId:'SLEC20240023',
            rollNumber:'ECE2024023'
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
                  Text(email,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.grey)),
                  Text(phone,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.grey)),
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

          // -------- IDs --------
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
          Text(title,
              style: const TextStyle(fontSize: 11, color: Colors.grey)),
          const SizedBox(height: 2),
          Text(value,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }
}
