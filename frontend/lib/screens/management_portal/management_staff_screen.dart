import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'department_staff_list_screen.dart';




class ManagementStaffScreen extends StatelessWidget {
  const ManagementStaffScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 249, 250, 250),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


           


              


              // ================= TITLE =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Staff Management",
                      style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                 
                ],
              ),
                  const SizedBox(height: 8),


              // ================= STATS =================
              Row(
                children: [
                  statCard("156", "TEACHING STAFF"),
                  const SizedBox(width: 12),
                  statCard("42", "NON-TEACHING"),
                ],
              ),


              const SizedBox(height: 12),


              // ================= TEACHING =================
              Text("TEACHING STAFF BY DEPT",
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700)),


              const SizedBox(height: 5),


              deptTile(context,
                  title: "Computer Science",
                  hod: "HOD: Dr. Rajesh Kumar",
                  count: "28 Faculty",
                  staffList: cseStaff),


              deptTile(context,
                  title: "Electronics & Communication",
                  hod: "HOD: Dr. Priya Sharma",
                  count: "24 Faculty",
                  staffList: eceStaff),


              deptTile(context,
                  title: "Mechanical Engineering",
                  hod: "HOD: Dr. Vijay Patel",
                  count: "22 Faculty",
                  staffList: mechStaff),


              deptTile(context,
                  title: "Information Technology",
                  hod: "HOD: Dr. Anita Desai",
                  count: "18 Faculty",
                  staffList: itStaff),


              deptTile(context,
                  title: "Cyber Security",
                  hod: "HOD: Dr. Suresh Reddy",
                  count: "16 Faculty",
                  staffList: cyberStaff),


              deptTile(context,
                  title: "Artificial Intelligence & Data Science",
                  hod: "HOD: Dr. Karthik Iyer",
                  count: "14 Faculty",
                  staffList: aiStaff),


              deptTile(context,
                  title: "MBA",
                  hod: "HOD: Dr. Meera Singh",
                  count: "12 Faculty",
                  staffList: mbaStaff),


              const SizedBox(height: 24),


              // ================= NON TEACHING =================
               Text("NON-TEACHING STAFF",
                  style: GoogleFonts.inter(fontWeight: FontWeight.w700)),


              const SizedBox(height: 12),


              deptTile(context,
                  title: "Administrative Staff",
                  hod: "",
                  count: "3 Staff",
                  staffList: adminStaff),


              deptTile(context,
                  title: "Lab Technicians",
                  hod: "",
                  count: "3 Staff",
                  staffList: labStaff),


              deptTile(context,
                  title: "Library Staff",
                  hod: "",
                  count: "2 Staff",
                  staffList: libraryStaff),


              deptTile(context,
                  title: "Maintenance Staff",
                  hod: "",
                  count: "2 Staff",
                  staffList: maintenanceStaff),
            ],
          ),
        ),
      ),
    );
  }
}


Widget deptTile(
  BuildContext context, {
  required String title,
  required String hod,
  required String count,
  required List<Map<String, dynamic>> staffList,
}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DepartmentStaffListScreen(
            departmentName: title,
            staffList: staffList,
          ),
        ),
      );
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(hod,
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(count),
          )
        ],
      ),
    ),
  );
}




//////////////////////////////////////////////////////////
// SMALL WIDGETS
//////////////////////////////////////////////////////////


Widget badge(String text) {
  return Container(
    padding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(text, style: GoogleFonts.inter(fontSize: 12)),
  );
}


Widget statCard(String value, String label) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(value,
              style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(label,
              style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.grey)),
        ],
      ),
    ),
  );
}


//////////////////////////////////////////////////////////
// DEPARTMENT TILE
//////////////////////////////////////////////////////////
Widget dept(
  BuildContext context, {
  required String title,
  required String hod,
  required String count,
  required List<Map<String, dynamic>> staffList,
}) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DepartmentStaffListScreen(
            departmentName: title,
            staffList: staffList,
          ),
        ),
      );
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [


          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                hod,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),


          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(count),
          )


        ],
      ),
    ),
  );
}




//////////////////////////////////////////////////////////
// NON-TEACHING TILE
//////////////////////////////////////////////////////////


Widget nonTeachingTile(String title, String count) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w600)),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(count),
        )
      ],
    ),
  );
}


//////////////////////////////////////////////////////////
// STAFF DATA
//////////////////////////////////////////////////////////


final cseStaff = [
  {"name":"Dr. Rajesh Kumar","role":"Professor & HOD","email":"rajesh@slec.edu.in","phone":"+91 98765 11111","present":true},
  {"name":"Dr. Arun Sharma","role":"Associate Professor","email":"arun@slec.edu.in","phone":"+91 98765 11112","present":true},
  {"name":"Prof. Kavitha Reddy","role":"Assistant Professor","email":"kavitha@slec.edu.in","phone":"+91 98765 11113","present":true},
  {"name":"Dr. Suresh Patel","role":"Associate Professor","email":"suresh@slec.edu.in","phone":"+91 98765 11114","present":false},
];


final eceStaff = [
  {"name":"Dr. Priya Sharma","role":"Professor & HOD","email":"priya@slec.edu.in","phone":"+91 98765 22221","present":true},
  {"name":"Prof. Ramesh Iyer","role":"Associate Professor","email":"ramesh@slec.edu.in","phone":"+91 98765 22222","present":true},
  {"name":"Dr. Anjali Menon","role":"Assistant Professor","email":"anjali@slec.edu.in","phone":"+91 98765 22223","present":true},
];


final mechStaff = [
  {"name":"Dr. Vijay Patel","role":"Professor & HOD","email":"vijay@slec.edu.in","phone":"+91 98765 33331","present":true},
  {"name":"Prof. Deepak Singh","role":"Associate Professor","email":"deepak@slec.edu.in","phone":"+91 98765 33332","present":false},
  {"name":"Dr. Lakshmi Rao","role":"Assistant Professor","email":"lakshmi@slec.edu.in","phone":"+91 98765 33333","present":true},
];


final itStaff = [
  {"name":"Dr. Anita Desai","role":"Professor & HOD","email":"anita@slec.edu.in","phone":"+91 98765 44441","present":true},
  {"name":"Prof. Mohan Kumar","role":"Associate Professor","email":"mohan@slec.edu.in","phone":"+91 98765 44442","present":true},
  {"name":"Dr. Pooja Verma","role":"Assistant Professor","email":"pooja@slec.edu.in","phone":"+91 98765 44443","present":true},
];


final cyberStaff = [
  {"name":"Dr. Suresh Reddy","role":"Professor & HOD","email":"suresh@slec.edu.in","phone":"+91 98765 55551","present":true},
  {"name":"Prof. Sneha Krishnan","role":"Associate Professor","email":"sneha@slec.edu.in","phone":"+91 98765 55552","present":false},
  {"name":"Dr. Vikram Gupta","role":"Assistant Professor","email":"vikram@slec.edu.in","phone":"+91 98765 55553","present":true},
];


final aiStaff = [
  {"name":"Dr. Karthik Iyer","role":"Professor & HOD","email":"karthik@slec.edu.in","phone":"+91 98765 66661","present":true},
  {"name":"Prof. Rekha Nair","role":"Associate Professor","email":"rekha@slec.edu.in","phone":"+91 98765 66662","present":true},
  {"name":"Dr. Arjun Bhat","role":"Assistant Professor","email":"arjun@slec.edu.in","phone":"+91 98765 66663","present":true},
];


final mbaStaff = [
  {"name":"Dr. Meera Singh","role":"Professor & HOD","email":"meera@slec.edu.in","phone":"+91 98765 77771","present":true},
  {"name":"Prof. Rahul Mehta","role":"Associate Professor","email":"rahul@slec.edu.in","phone":"+91 98765 77772","present":true},
  {"name":"Dr. Divya Kapoor","role":"Assistant Professor","email":"divya@slec.edu.in","phone":"+91 98765 77773","present":false},
];


// NON TEACHING


final adminStaff = [
  {"name":"Ramesh Kumar","role":"Senior Administrator","email":"ramesh@slec.edu.in","phone":"+91 98765 88881","present":true},
  {"name":"Sunita Rao","role":"Office Coordinator","email":"sunita@slec.edu.in","phone":"+91 98765 88882","present":true},
  {"name":"Prakash Singh","role":"Accounts Officer","email":"prakash@slec.edu.in","phone":"+91 98765 88883","present":false},
];


final labStaff = [
  {"name":"Vijay Kumar","role":"Senior Lab Technician","email":"vijay@slec.edu.in","phone":"+91 98765 99991","present":true},
  {"name":"Anand Reddy","role":"Lab Technician","email":"anand@slec.edu.in","phone":"+91 98765 99992","present":true},
  {"name":"Lakshmi Devi","role":"Lab Technician","email":"lakshmi@slec.edu.in","phone":"+91 98765 99993","present":true},
];


final libraryStaff = [
  {"name":"Geetha Menon","role":"Chief Librarian","email":"geetha@slec.edu.in","phone":"+91 98765 00001","present":true},
  {"name":"Suresh Babu","role":"Assistant Librarian","email":"suresh@slec.edu.in","phone":"+91 98765 00002","present":true},
];


final maintenanceStaff = [
  {"name":"Nagaraj Gowda","role":"Maintenance Supervisor","email":"nagaraj@slec.edu.in","phone":"+91 98765 00011","present":true},
  {"name":"Kumar Swamy","role":"Electrician","email":"kumar@slec.edu.in","phone":"+91 98765 00012","present":false},
];

