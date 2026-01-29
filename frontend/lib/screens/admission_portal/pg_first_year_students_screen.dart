import 'package:flutter/material.dart';
import 'student_details_pdf_view.dart';
import 'student_model.dart';

class PgFirstYearStudentsScreen extends StatelessWidget {
  const PgFirstYearStudentsScreen({super.key});

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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'PG Programs - 1st Year',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 2),
            Text(
              '4 Students',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),

      // ================= BODY =================
     body: ListView.builder(
  padding: const EdgeInsets.all(16),
  itemCount: pgFirstYearStudents.length,
  itemBuilder: (context, index) {
    final student = pgFirstYearStudents[index];
    return StudentCard(student: student);
  },
),

    );
  }
}

// ================= STUDENT CARD =================
class StudentCard extends StatelessWidget {
  final StudentModel student;

  const StudentCard({super.key, required this.student});

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
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(student.name,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                  Text(student.email,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.grey)),
                  Text(student.studentPhone,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
              Chip(
                label: Text(student.status),
                backgroundColor: Colors.green.shade100,
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              _info('Student ID', student.admissionNumber),
              const SizedBox(width: 12),
              _info('Roll Number', student.rollNumber),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: student.status,
                  items: const [
                    DropdownMenuItem(value: 'Active', child: Text('Active')),
                    DropdownMenuItem(value: 'Discontinued', child: Text('Discontinued')),
                    DropdownMenuItem(value: 'Transfer', child: Text('Transfer')),
                    DropdownMenuItem(value: 'Passed Out', child: Text('Passed Out')),
                  ],
                  onChanged: (_) {},
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                icon: const Icon(Icons.remove_red_eye),
                label: const Text('View Details'),
                onPressed: () {
               Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => StudentDetailsPdfView(student: 'student',
      name: 'Nikhil Bansal',
      email: 'nikhil.bansal@slec.edu.in',
      admissionNumber: 'ADM2024015',
      department: 'MBA',
      studentPhone: '+91-98765-43226',
      parentPhone: '+91-98765-32116',
      address: 'Whitefield, Bangalore - 560066',
    ),
  ),
);

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
          Text(value,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }
}
