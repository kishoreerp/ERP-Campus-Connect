import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'admission_student_detail_screen.dart';


class PgDepartmentStudentsScreen extends StatelessWidget {
  final String departmentName;
  final String program;   // PG
  final String degree;    // MBA / M.E etc


  const PgDepartmentStudentsScreen({
    super.key,
    required this.departmentName,
    required this.program,
    required this.degree,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),


      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$program - $degree",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              departmentName,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),


      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('admission_forms')
            .where('program', isEqualTo: program)
            .where('department', isEqualTo: departmentName)
            .snapshots(),
        builder: (context, snapshot) {


          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }


          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No Applications Found",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            );
          }


          final students = snapshot.data!.docs;


          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: students.length,
            separatorBuilder: (_, __) =>
                const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final doc = students[index];
              final data =
                  doc.data() as Map<String, dynamic>;


              final String name = data['name'] ?? '';
              final String email = data['email'] ?? '';
              final String status =
                  data['status'] ?? 'Pending';


              return _studentCard(
                context,
                doc.id,
                data,
                name,
                email,
                status,
              );
            },
          );
        },
      ),
    );
  }


  Widget _studentCard(
    BuildContext context,
    String documentId,
    Map<String, dynamic> data,
    String name,
    String email,
    String status,
  ) {
    Color statusColor;


    switch (status.toLowerCase()) {
      case 'approved':
        statusColor = Colors.green;
        break;
      case 'rejected':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.orange;
    }


    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      elevation: 1.5,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  AdmissionStudentDetailScreen(
                documentId: documentId,
                studentData: data,
                departmentName: departmentName,
                  program: "PG",
                  degree: degree,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          child: Row(
            children: [


              // LEFT: Avatar
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey.shade200,
                child: Text(
                  name.isNotEmpty
                      ? name[0].toUpperCase()
                      : '?',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),


              const SizedBox(width: 14),


              // CENTER: Name + Email
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),


              // RIGHT: Status Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



