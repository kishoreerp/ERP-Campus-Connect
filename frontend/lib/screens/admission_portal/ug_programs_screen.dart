import 'package:flutter/material.dart';
import 'admission_student_detail_screen.dart';


class UgDepartmentsScreen extends StatelessWidget {
  const UgDepartmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
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
                  'UG Departments',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Select department to view students',
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
            const SizedBox(height: 10),

            _deptCard(
              title: 'Information Technology',
              code: 'IT',
              students: '4 Students',
               onTap: () {
    Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const AdmissionStudentDetailScreen(
      name: 'Rahul Sharma',
      email: 'rahul.sharma@slecedu.in',
      department: 'Information Technology',
      year: '1st Year',
      admissionNumber: 'ADM2024001',
      studentPhone: '+91-98765-43210',
      parentPhone: '+91-97654-32100',
    ),
  ),
);

  },
            ),
            _deptCard(
              title: 'Computer Science Engineering (Cyber Security)',
              code: 'CSE_CS',
              students: '4 Students',
              onTap: () {
    Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const AdmissionStudentDetailScreen(
      name: 'Vikram Reddy',
      email: 'vikram.reddy@slecedu.in',
      department: 'CSE (Cyber Security)',
      year: '1st Year',
      admissionNumber: 'ADM2024005',
      studentPhone: '+91-98765-43214',
      parentPhone: '+91-97654-32104',
    ),
  ),
);


  },
            ),
            _deptCard(
              title: 'Artificial Intelligence Data Science',
              code: 'AI_DS',
              students: '4 Students',
              onTap: () {
   Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const AdmissionStudentDetailScreen(
      name: 'Arjun Menon',
      email: 'arjun.menon@slecedu.in',
      department: 'Artificial Intelligence & Data Science',
      year: '1st Year',
      admissionNumber: 'ADM2024009',
      studentPhone: '+91-98765-43218',
      parentPhone: '+91-97654-32108',
    ),
  ),
);


  },
            ),
            _deptCard(
              title: 'Computer Science Engineering',
              code: 'CSE',
              students: '4 Students',
               onTap: () {
 Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const AdmissionStudentDetailScreen(
      name: 'Vikram Reddy',
      email: 'vikram.reddy@slecedu.in',
      department: 'Computer Science Engineering',
      year: '1st Year',
      admissionNumber: 'ADM2024005',
      studentPhone: '+91-98765-43214',
      parentPhone: '+91-97654-32104',
    ),
  ),
);


  },
            
            ),
            _deptCard(
              title: 'Electronics and Communication Engineering',
              code: 'ECE',
              students: '4 Students',
               onTap: () {
  Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const AdmissionStudentDetailScreen(
      name: 'Suresh Kumar',
      email: 'suresh.kumar@slecedu.in',
      department: 'Electronics & Communication Engineering',
      year: '1st Year',
      admissionNumber: 'ADM2024023',
      studentPhone: '+91-98765-43232',
      parentPhone: '+91-97654-32122',
    ),
  ),
);


  },
            ),

          ],
        ),
      ),
    );
  }

  // ================= DEPARTMENT CARD =================
  Widget _deptCard({
    required String title,
    required String code,
    required String students,
    required VoidCallback onTap,
  }) {
    return InkWell(
    onTap: onTap, // ✅ USE IT
    borderRadius: BorderRadius.circular(16),
    child: Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  code,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              students,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    ),
  );
}
}
