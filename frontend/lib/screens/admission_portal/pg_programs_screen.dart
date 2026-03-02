import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'pg_department_students_screen.dart';


class PgProgramsScreen extends StatefulWidget {
  const PgProgramsScreen({super.key});


  @override
  State<PgProgramsScreen> createState() =>
      _PgProgramsScreenState();
}


class _PgProgramsScreenState
    extends State<PgProgramsScreen> {


  Stream<int> _getDepartmentCount(String department) {
    return FirebaseFirestore.instance
        .collection('admission_forms')
        .where('program', isEqualTo: 'PG')
        .where('department', isEqualTo: department)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }


  final List<Map<String, String>> departments = [
    {
      "title": "Master of Business Administration",
      "code": "MBA",
      "degree": "MBA"
    },
    {
      "title": "Computer Science and Engineering",
      "code": "ME CSE",
      "degree": "M.E"
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),


      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "PG Departments",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),


      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: departments.length,
        separatorBuilder: (_, __) =>
            const SizedBox(height: 14),
        itemBuilder: (context, index) {
          final dept = departments[index];


          return _deptCard(
            title: dept["title"]!,
            code: dept["code"]!,
            degree: dept["degree"]!,
          );
        },
      ),
    );
  }


  // ================= PROFESSIONAL CARD =================
  Widget _deptCard({
    required String title,
    required String code,
    required String degree,
  }) {


    IconData icon;
    Color iconColor;


    switch (code) {
      case "MBA":
        icon = Icons.business_center;
        iconColor = Colors.blue;
        break;
      case "ME CSE":
        icon = Icons.memory;
        iconColor = Colors.indigo;
        break;
      default:
        icon = Icons.school;
        iconColor = Colors.grey;
    }


    return StreamBuilder<int>(
      stream: _getDepartmentCount(title),
      builder: (context, snapshot) {
        final count = snapshot.data ?? 0;


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
                      PgDepartmentStudentsScreen(
                    departmentName: title,
                    program: "PG",
                  degree: degree,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Row(
                children: [


                  // LEFT: Colored Logo
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 20,
                      color: iconColor,
                    ),
                  ),


                  const SizedBox(width: 14),


                  // CENTER: Title + Code
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          code,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),


                  // RIGHT: Student Count
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    child: Text(
                      "$count Students",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}



