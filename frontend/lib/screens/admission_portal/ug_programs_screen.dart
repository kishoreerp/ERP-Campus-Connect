import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ug_department_students_screen.dart';


class UgDepartmentsScreen extends StatefulWidget {
  const UgDepartmentsScreen({super.key});


  @override
  State<UgDepartmentsScreen> createState() =>
      _UgDepartmentsScreenState();
}


class _UgDepartmentsScreenState
    extends State<UgDepartmentsScreen> {


  Stream<int> _getDepartmentCount(String department) {
    return FirebaseFirestore.instance
        .collection('admission_forms')
        .where('program', isEqualTo: 'UG')
        .where('department', isEqualTo: department)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }


  final List<Map<String, String>> departments = [
    {
      "title": "Information Technology",
      "code": "IT",
      "degree": "B.Tech",
    },
    {
      "title": "Computer Science Engineering (Cyber Security)",
      "code": "CSE_CS",
      "degree": "B.E"
    },
    {
      "title": "Artificial Intelligence & Data Science",
      "code": "AI_DS",
      "degree": "B.Tech",
    },
    {
      "title": "Computer Science and Engineering",
      "code": "CSE",
      "degree": "B.E"
    },
    {
      "title": "Electronics and Communication Engineering",
      "code": "ECE",
      "degree": "B.E"
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color.fromARGB(255, 248, 249, 250),


      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "UG Departments",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
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


  Widget _deptCard({
  required String title,
  required String code,
  required String degree,
}) {
  IconData icon;
  Color iconColor;


  // Icon + Color mapping
  switch (code) {
    case "IT":
      icon = Icons.computer;
      iconColor = Colors.blue;
      break;
    case "CSE_CS":
      icon = Icons.security;
      iconColor = Colors.deepPurple;
      break;
    case "AI_DS":
      icon = Icons.psychology;
      iconColor = Colors.teal;
      break;
    case "CSE":
      icon = Icons.memory;
      iconColor = Colors.indigo;
      break;
    case "ECE":
      icon = Icons.electrical_services;
      iconColor = Colors.orange;
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
                builder: (_) => UgDepartmentStudentsScreen(
                  departmentName: title,
                  program: "UG",
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


                // RIGHT: Student Count with Text
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
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



