import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


//////////////////////////////////////////////////////////
// MANAGEMENT STUDENT SCREEN
//////////////////////////////////////////////////////////


class ManagementStudentScreen extends StatelessWidget {
  const ManagementStudentScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


             
              const SizedBox(height: 10),


              // ================= TITLE =================
              Row(
                children: [
                  Text("Student Management",
                      style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
         
               
                ],
              ),


           


              const SizedBox(height: 16),


              // ================= SEARCH =================
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search students...",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 14),
                    ),
                    onPressed: () {},
                    child: const Text("Search"),
                  )
                ],
              ),


              const SizedBox(height: 18),


              // ================= YEAR COUNTS =================
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2.6,
                children: const [
                  YearStatCard("847", "1st Year", Colors.blue),
                  YearStatCard("823", "2nd Year", Colors.green),
                  YearStatCard("798", "3rd Year", Colors.purple),
                  YearStatCard("779", "Final Year", Colors.orange),
                ],
              ),


              const SizedBox(height: 20),


              // ================= DEPARTMENTS =================
              Text("Department-wise Students",
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold)),


              const SizedBox(height: 12),


              deptRow(context, "Computer Science"),
              deptRow(context, "Information Technology"),
              deptRow(context, "Cyber Security"),
              deptRow(context, "Artificial Intelligence & Data Science"),
              deptRow(context, "Electronics & Communication"),
              deptRow(context, "MBA"),
            ],
          ),
        ),
      ),
    );
  }


  // ================= DEPARTMENT TILE =================
  Widget deptRow(BuildContext context, String title) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                DepartmentYearsView(departmentName: title),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const CircleAvatar(
                radius: 5,
                backgroundColor: Colors.orange),
            const SizedBox(width: 10),
            Expanded(
              child: Text(title,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500)),
            ),
            const Icon(Icons.arrow_forward_ios,
                size: 14),
          ],
        ),
      ),
    );
  }
}


//////////////////////////////////////////////////////////
// YEAR CARD WIDGET
//////////////////////////////////////////////////////////


class YearStatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;


  const YearStatCard(this.value, this.label, this.color,
      {super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value,
              style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: color)),
          const SizedBox(height: 6),
          Text(label,
              style: GoogleFonts.inter(color: color)),
        ],
      ),
    );
  }
}


//////////////////////////////////////////////////////////
// YEAR SELECTION SCREEN
//////////////////////////////////////////////////////////


class DepartmentYearsView extends StatelessWidget {
  final String departmentName;


  DepartmentYearsView({
    super.key,
    required this.departmentName,
  });


  final Map<String, List<String>> yearData = {
    "Computer Science": ["95", "126", "111", "62"],
    "Information Technology": ["114", "124", "79", "114"],
    "Cyber Security": ["90", "85", "99", "56"],
    "Artificial Intelligence & Data Science": ["145", "98", "86", "89"],
    "Electronics & Communication": ["65", "57", "84", "64"],
    "MBA": ["116", "106"],
  };


  @override
  Widget build(BuildContext context) {
    final years = yearData[departmentName] ?? [];


    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [


              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () =>
                        Navigator.pop(context),
                  ),
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(departmentName,
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.w600)),
                      Text("Select a year",
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.grey)),
                    ],
                  ),
                ],
              ),


              const SizedBox(height: 20),


              if (years.length > 0)
                yearTile(context,"1st Year",
                    "${years[0]} Students"),
              if (years.length > 1)
                yearTile(context,"2nd Year",
                    "${years[1]} Students"),
              if (years.length > 2)
                yearTile(context,"3rd Year",
                    "${years[2]} Students"),
              if (years.length > 3)
                yearTile(context,"Final Year",
                    "${years[3]} Students"),
            ],
          ),
        ),
      ),
    );
  }


 Widget yearTile(BuildContext context, String title, String count) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => StudentListScreen(
            departmentName: departmentName,
            yearName: title,
          ),
        ),
      );
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.black,
            child: Icon(Icons.school, color: Colors.white),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600)),
              Text(count,
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    ),
  );
}


}
//////////////////////////////////////////////////////////
// STUDENT LIST SCREEN
//////////////////////////////////////////////////////////


class StudentListScreen extends StatelessWidget {
  final String departmentName;
  final String yearName;


  StudentListScreen({
    super.key,
    required this.departmentName,
    required this.yearName,
  });


  // Demo Students
  final List<Map<String, String>> students = [


    {"name": "Rajesh Kumar", "reg": "CSE01001"},
    {"name": "Priya Sharma", "reg": "CSE01002"},
    {"name": "Amit Patel", "reg": "CSE01003"},
    {"name": "Sneha Reddy", "reg": "CSE01004"},
    {"name": "Vikram Singh", "reg": "CSE01005"},
    {"name": "Divya Nair", "reg": "CSE01006"},
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              // ---------- HEADER ----------
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$departmentName - $yearName",
                        style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      Text("CSE",
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.grey)),
                    ],
                  ),
                 
                ],
              ),


              const SizedBox(height: 16),


              // ---------- VIEW MODE ----------
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline,
                        color: Colors.orange),
                    const SizedBox(width: 8),
                    Text("View-Only Mode - Management Admin",
                        style: GoogleFonts.inter(
                            color: Colors.orange.shade800)),
                  ],
                ),
              ),


              const SizedBox(height: 16),


              // ---------- SEARCH ----------
              TextField(
                decoration: InputDecoration(
                  hintText: "Search students...",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),


              const SizedBox(height: 16),


              // ---------- STUDENT LIST ----------
              Expanded(
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                 return studentTile(
  context,
  students[index]["name"]!,
  students[index]["reg"]!,
  departmentName,
  yearName,
);


                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  // ---------- STUDENT TILE ----------
Widget studentTile(
  BuildContext context,
  String name,
  String reg,
  String department,
  String year,
) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => StudentProfileScreen(
            name: name,
            regNo: reg,
            department: department,
            year: year,
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
        children: [
          const CircleAvatar(
            backgroundColor: Colors.black,
            child: Icon(Icons.school, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600)),
              Text(reg,
                  style: const TextStyle(
                      fontSize: 12, color: Colors.grey)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    ),
  );
}


}
//////////////////////////////////////////////////////////
// STUDENT PROFILE SCREEN
//////////////////////////////////////////////////////////


class StudentProfileScreen extends StatelessWidget {
  final String name;
  final String regNo;
  final String department;
  final String year;


  const StudentProfileScreen({
    super.key,
    required this.name,
    required this.regNo,
    required this.department,
    required this.year,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,


      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              // ================= HEADER =================
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    "Student Details",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                 
                ],
              ),


              const SizedBox(height: 12),


              // ================= VIEW MODE =================
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.info_outline, color: Colors.orange),
                    SizedBox(width: 8),
                    Text("View-Only Mode - Management Admin"),
                  ],
                ),
              ),


              const SizedBox(height: 20),


              // ================= PROFILE CARD =================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.black,
                      child:
                          Icon(Icons.school, color: Colors.white, size: 30),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(regNo),
                    const SizedBox(height: 6),
                    Chip(label: Text(year)),
                  ],
                ),
              ),


              const SizedBox(height: 20),


              // ================= PERSONAL INFO =================
       whiteSection(
  title: "Personal Information",
  children: [
    infoTile(
      icon: Icons.person,
      label: "Full Name",
      value: "Rajesh Kumar",
    ),
    infoTile(
      icon: Icons.email,
      label: "Email",
      value: "rajesh.kumar@student.slec.edu.in",
    ),
    infoTile(
      icon: Icons.phone,
      label: "Phone",
      value: "+91 4799048155",
    ),
    infoTile(
      icon: Icons.location_on,
      label: "Address",
      value: "10, Koramangala, Bangalore - 560048",
    ),
  ],
),




              const SizedBox(height: 16),


              // ================= ACADEMIC INFO =================
             whiteSection(
  title: "Academic Information",
  children: [
    infoTile(
      icon: Icons.school,
      label: "Department",
      value: "Computer Science",
    ),
    infoTile(
      icon: Icons.class_,
      label: "Year",
      value: "1st Year",
    ),
    infoTile(
      icon: Icons.groups,
      label: "Section",
      value: "C",
    ),
    infoTile(
      icon: Icons.grade,
      label: "CGPA",
      value: "8.58",
    ),
    infoTile(
      icon: Icons.percent,
      label: "Attendance",
      value: "94%",
    ),
    infoTile(
      icon: Icons.calendar_today,
      label: "Admission Date",
      value: "August 15, 2024",
    ),
  ],
),


              const SizedBox(height: 16),


              // ================= PARENT INFO =================
            whiteSection(
  title: "Parent/Guardian Information",
  children: [
    infoTile(
      icon: Icons.person,
      label: "Father's Name",
      value: "Rajesh Patel",
    ),
    infoTile(
      icon: Icons.phone,
      label: "Parent Contact",
      value: "+91 1020657830",
    ),
    infoTile(
      icon: Icons.work,
      label: "Father's Occupation",
      value: "Doctor",
    ),
  ],
),


            ],
          ),
        ),
      ),
    );
  }


  // ---------- Small Widgets ----------


  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }


  Widget simpleinfoTile({
  required IconData icon,
  required String label,
  required String value,
})
 {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(label,
          style: const TextStyle(
                  fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(value,
              style:
                  const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
// ================= WHITE SECTION BOX =================
Widget whiteSection({
  required String title,
  required List<Widget> children,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}


// ================= INFO ROW TILE =================
Widget infoTile({
  required IconData icon,
  required String label,
  required String value,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.grey),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        )
      ],
    ),
  );
}







