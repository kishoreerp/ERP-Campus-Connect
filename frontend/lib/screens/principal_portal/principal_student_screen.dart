 import 'package:flutter/material.dart';




final List<StudentModel> demoStudents = [
 
  StudentModel(
    name: "Arun Kumar",
    registerNumber: "MSC001",
    year: "1st Year",
     isPresent: true,
    dob: "12-05-2005",
    gender: "Male",
    bloodGroup: "B+",
    aadhar: "123456789012",
    email: "arun@gmail.com",
    phone: "9876543210",
    fatherName: "Ravi Kumar",
    motherName: "Lakshmi",
    address: "Chennai",
    religion: "Hindu",
    caste: "OC",
    community: "General",
    income: "1,50,000",
    arrears: 2,
    subjects: ["Mathematics I", "Engineering Physics"],
  ),




  StudentModel(
    name: "Bala Murugan",
    registerNumber: "MSC002",
    year: "1st Year",
     isPresent: true,
    dob: "03-09-2005",
    gender: "Male",
    bloodGroup: "O+",
    aadhar: "234567890123",
    email: "bala@gmail.com",
    phone: "9123456780",
    fatherName: "Murugan",
    motherName: "Kavitha",
    address: "Madurai",
    religion: "Hindu",
    caste: "BC",
    community: "Backward",
    income: "1,20,000",
    arrears: 1,
    subjects: ["C Programming", "Physics"],
  ),




  StudentModel(
    name: "Charan Raj",
    registerNumber: "MSC003",
    year: "1st Year",
     isPresent: false,
    dob: "21-01-2005",
    gender: "Male",
    bloodGroup: "A+",
    aadhar: "345678901234",
    email: "charan@gmail.com",
    phone: "9988776655",
    fatherName: "Raj Kumar",
    motherName: "Sangeetha",
    address: "Coimbatore",
    religion: "Hindu",
    caste: "MBC",
    community: "Most Backward",
    income: "2,00,000",
    arrears: 0,
    subjects: ["Data Structures", "Maths"],
  ),




  StudentModel(
    name: "Divya Lakshmi",
    registerNumber: "MSC004",
    year: "1st Year",
     isPresent: true,
    dob: "15-02-2006",
    gender: "Female",
    bloodGroup: "AB+",
    aadhar: "456789012345",
    email: "divya@gmail.com",
    phone: "9871234567",
    fatherName: "Lakshman",
    motherName: "Rani",
    address: "Salem",
    religion: "Hindu",
    caste: "OC",
    community: "General",
    income: "1,75,000",
    arrears: 3,
    subjects: ["Operating Systems", "Digital Logic"],
  ),




  StudentModel(
    name: "Eshwar Reddy",
    registerNumber: "MSC005",
    year: "1st Year",
     isPresent: true,
    dob: "08-08-2005",
    gender: "Male",
    bloodGroup: "B-",
    aadhar: "567890123456",
    email: "eshwar@gmail.com",
    phone: "9998887776",
    fatherName: "Reddy",
    motherName: "Anitha",
    address: "Vellore",
    religion: "Hindu",
    caste: "BC",
    community: "Backward",
    income: "1,40,000",
    arrears: 0,
    subjects: ["Java", "Maths II"],
  ),




  StudentModel(
    name: "Farhana Begum",
    registerNumber: "MSC006",
    year: "1st Year",
     isPresent: true,
    dob: "12-11-2005",
    gender: "Female",
    bloodGroup: "O-",
    aadhar: "678901234567",
    email: "farhana@gmail.com",
    phone: "9001122334",
    fatherName: "Ahmed",
    motherName: "Shabana",
    address: "Chennai",
    religion: "Muslim",
    caste: "BC",
    community: "Minority",
    income: "1,10,000",
    arrears: 1,
    subjects: ["Python", "Statistics"],
  ),




  StudentModel(
    name: "Ganesh Kumar",
    registerNumber: "MSC007",
    year: "1st Year",
     isPresent: true,
    dob: "30-04-2005",
    gender: "Male",
    bloodGroup: "A-",
    aadhar: "789012345678",
    email: "ganesh@gmail.com",
    phone: "9011223344",
    fatherName: "Kumar",
    motherName: "Meena",
    address: "Trichy",
    religion: "Hindu",
    caste: "SC",
    community: "Scheduled Caste",
    income: "90,000",
    arrears: 4,
    subjects: ["Networks", "DBMS"],
  ),




  StudentModel(
    name: "Harini S",
    registerNumber: "MSC008",
    year: "1st Year",
     isPresent:false,
    dob: "19-06-2005",
    gender: "Female",
    bloodGroup: "B+",
    aadhar: "890123456789",
    email: "harini@gmail.com",
    phone: "9090909090",
    fatherName: "Suresh",
    motherName: "Kala",
    address: "Erode",
    religion: "Hindu",
    caste: "OC",
    community: "General",
    income: "2,50,000",
    arrears: 0,
    subjects: ["AI", "Machine Learning"],
  ),




  StudentModel(
    name: "Imran Khan",
    registerNumber: "MSC009",
    year: "1st Year",
     isPresent: true,
    dob: "07-07-2005",
    gender: "Male",
    bloodGroup: "O+",
    aadhar: "901234567890",
    email: "imran@gmail.com",
    phone: "9898989898",
    fatherName: "Khan",
    motherName: "Ayesha",
    address: "Chennai",
    religion: "Muslim",
    caste: "BC",
    community: "Minority",
    income: "1,30,000",
    arrears: 2,
    subjects: ["Cloud Computing", "Linux"],
  ),




  StudentModel(
    name: "Janani V",
    registerNumber: "MSC010",
    year: "1st Year",
     isPresent: true,
    dob: "25-12-2005",
    gender: "Female",
    bloodGroup: "AB-",
    aadhar: "112233445566",
    email: "janani@gmail.com",
    phone: "9876501234",
    fatherName: "Venkatesh",
    motherName: "Uma",
    address: "Tirunelveli",
    religion: "Hindu",
    caste: "MBC",
    community: "Most Backward",
    income: "1,60,000",
    arrears: 1,
    subjects: ["Compiler Design", "Software Engineering"],
  ),




  // You can duplicate structure to add more up to 15+
  StudentModel(
    name: "Karthik R",
    registerNumber: "MSC011",
    year: "1st Year",
     isPresent: true,
    dob: "14-03-2005",
    gender: "Male",
    bloodGroup: "B+",
    aadhar: "223344556677",
    email: "karthik@gmail.com",
    phone: "9988001122",
    fatherName: "Ramesh",
    motherName: "Geetha",
    address: "Namakkal",
    religion: "Hindu",
    caste: "BC",
    community: "Backward",
    income: "1,45,000",
    arrears: 0,
    subjects: ["Cyber Security", "Ethical Hacking"],
  ),




  StudentModel(
    name: "Lavanya M",
    registerNumber: "MSC012",
    year: "1st Year",
     isPresent: true,
    dob: "10-10-2005",
    gender: "Female",
    bloodGroup: "A+",
    aadhar: "334455667788",
    email: "lavanya@gmail.com",
    phone: "9000012345",
    fatherName: "Mani",
    motherName: "Radha",
    address: "Karur",
    religion: "Hindu",
    caste: "OC",
    community: "General",
    income: "1,70,000",
    arrears: 2,
    subjects: ["Data Mining", "Big Data"],
  ),
  StudentModel(
    name: "Arun Kumar",
    registerNumber: "MSC001",
    year: "1st Year",
     isPresent: true,
    dob: "12-05-2005",
    gender: "Male",
    bloodGroup: "B+",
    aadhar: "123456789012",
    email: "arun@gmail.com",
    phone: "9876543210",
    fatherName: "Ravi Kumar",
    motherName: "Lakshmi",
    address: "Chennai, Tamil Nadu",
    religion: "Hindu",
    caste: "OC",
    community: "General",
    income: "1,50,000",
    arrears: 2,
    subjects: [
      "Mathematics I",
      "Engineering Physics",
    ],
  ),




  StudentModel(
    name: "Naveen P",
    registerNumber: "MSC013",
    year: "1st Year",
     isPresent: true,
    dob: "02-02-2005",
    gender: "Male",
    bloodGroup: "O+",
    aadhar: "445566778899",
    email: "naveen@gmail.com",
    phone: "9012345678",
    fatherName: "Prakash",
    motherName: "Latha",
    address: "Dharmapuri",
    religion: "Hindu",
    caste: "SC",
    community: "Scheduled Caste",
    income: "80,000",
    arrears: 3,
    subjects: ["Android Dev", "Kotlin"],
  ),




  StudentModel(
    name: "Priya K",
    registerNumber: "MSC014",
    year: "1st Year",
     isPresent: true,
    dob: "09-09-2005",
    gender: "Female",
    bloodGroup: "B+",
    aadhar: "556677889900",
    email: "priya@gmail.com",
    phone: "9098765432",
    fatherName: "Kumar",
    motherName: "Anjali",
    address: "Chennai",
    religion: "Hindu",
    caste: "BC",
    community: "Backward",
    income: "1,25,000",
    arrears: 0,
    subjects: ["Web Development", "React"],
  ),




  StudentModel(
    name: "Rahul S",
    registerNumber: "MSC015",
    year: "1st Year",
     isPresent: true,
    dob: "18-05-2005",
    gender: "Male",
    bloodGroup: "A+",
    aadhar: "667788990011",
    email: "rahul@gmail.com",
    phone: "9876001122",
    fatherName: "Sankar",
    motherName: "Rekha",
    address: "Salem",
    religion: "Hindu",
    caste: "MBC",
    community: "Most Backward",
    income: "1,90,000",
    arrears: 1,
    subjects: ["Flutter", "Firebase"],
  ),
];








class PrincipalStudentScreen extends StatefulWidget {
  const PrincipalStudentScreen({super.key});




  @override
  State<PrincipalStudentScreen> createState() =>
      _PrincipalStudentScreenState();
}
final TextEditingController _searchController = TextEditingController();




class _PrincipalStudentScreenState
    extends State<PrincipalStudentScreen> {
int get totalStudents => demoStudents.length;


int get totalPresent =>
    demoStudents.where((s) => s.isPresent).length;


int get totalAbsent =>
    demoStudents.where((s) => !s.isPresent).length;


  final List<String> ugYears = [
    "1st Year",
    "2nd Year",
    "3rd Year",
    "4th Year",
  ];




  final List<String> pgYears = [
    "1st Year",
    "2nd Year",
  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  automaticallyImplyLeading: false,
  toolbarHeight: 48,
  elevation: 0,
  backgroundColor: Colors.white,      // ✅ important
  surfaceTintColor: Colors.white,     // ✅ very important (Material 3)
  shadowColor: Colors.transparent,    // ✅ removes grey shadow
  title: const Text(
    "Student",
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [




            /// SEARCH CARD
            _buildSearchCard(),




            const SizedBox(height: 14),




            /// ===============================
            /// UNDERGRADUATE
            /// ===============================




            _buildProgramHeader("Undergraduate"),


            const SizedBox(height: 16),




            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2.2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: ugYears.map((year) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DepartmentScreen(
                          program: "UG",
                          year: year,
                        ),
                      ),
                    );
                  },
                  child: _buildYearCard("UG", year),
                );
              }).toList(),
            ),




            const SizedBox(height: 16),




            /// ===============================
            /// POSTGRADUATE
            /// ===============================
            _buildProgramHeader("Postgraduate"),


            const SizedBox(height: 16),




            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2.2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: pgYears.map((year) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DepartmentScreen(
                          program: "PG",
                          year: year,
                        ),
                      ),
                    );
                  },
                  child: _buildYearCard("PG", year),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }




  /// SEARCH CARD
 Widget _buildSearchCard() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: "Search Student",
        prefixIcon: const Icon(Icons.search, color: Colors.blue),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
      ),
      onSubmitted: (value) {
        if (value.trim().isEmpty) return;




        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => StudentSearchScreen(
              query: value.trim(),
            ),
          ),
        );
      },
    ),
  );
}




  /// YEAR CARD
Widget _buildYearCard(String program, String year) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: program == "UG"
              ? Colors.blue.withOpacity(0.12)
              : Colors.purple.withOpacity(0.12),
          child: Icon(
            Icons.school,
            size: 18,
            color: program == "UG"
                ? Colors.blue
                : Colors.purple,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          year,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
Widget _buildProgramHeader(String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),


          /// Summary Badge
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Total: $totalStudents",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),


      const SizedBox(height: 8),


      /// Present / Absent Row
      Row(
        children: [
          _miniStatusBox(
            label: "Present",
            count: totalPresent,
            color: Colors.green,
          ),
          const SizedBox(width: 10),
          _miniStatusBox(
            label: "Absent",
            count: totalAbsent,
            color: Colors.red,
          ),
        ],
      ),
    ],
  );
}
Widget _miniStatusBox({
  required String label,
  required int count,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(
        horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, size: 8, color: color),
        const SizedBox(width: 6),
        Text(
          "$label: $count",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    ),
  );
}}
/// ===============================================
/// DEPARTMENT SCREEN (Same File - No New File)
/// ===============================================




class DepartmentScreen extends StatelessWidget {
  final String program;
  final String year;




  static const List<Color> iconColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
  ];




  const DepartmentScreen({
    super.key,
    required this.program,
    required this.year,
  });




IconData _getDepartmentIcon(String name) {
  if (name.contains("Computer") || name.contains("CSE")) {
    return Icons.computer;
  } else if (name.contains("Information Technology")) {
    return Icons.devices;
  } else if (name.contains("Cyber")) {
    return Icons.security;
  } else if (name.contains("Artificial")) {
    return Icons.smart_toy;
  } else if (name.contains("Electronics")) {
    return Icons.memory;
  } else if (name.contains("MBA")) {
    return Icons.business;
  } else if (name.contains("M.E")) {
    return Icons.engineering;
  } else {
    return Icons.school;
  }
}
  @override
  Widget build(BuildContext context) {
    final Map<String, int> departments = program == "UG"
        ? {
            "Information Technology": 45,
            "Computer Science and Engineering": 52,
            "Cyber Security": 38,
            "Artificial Intelligence & Data Science": 41,
            "Electronics and Communication": 47,
          }
        : {
            "M.E:Computer Science and Engineering": 30,
            "MBA:Master of Business Administration": 22,
          };
   
    return Scaffold(
  appBar: AppBar(
  toolbarHeight: 56,
  elevation: 0,
  backgroundColor: Colors.white,
  surfaceTintColor: Colors.white,
  title: Text(
    "$program - $year",
    style: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: ListView(
          children: departments.entries
              .toList()
              .asMap()
              .entries
              .map((e) {
            return _buildDepartmentCard(
              context,
              e.value,
              e.key,
            );
          }).toList(),
        ),
      ),
    );
  }




  /// ✅ THIS METHOD MUST BE INSIDE CLASS
  Widget _buildDepartmentCard(
    BuildContext context,
    MapEntry<String, int> entry,
    int index,
  ) {
    final iconColor =
        iconColors[index % iconColors.length];




    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => StudentListScreen(
  departmentName: entry.key,
  totalStudents: entry.value,
   program: program,  
  year: year,        
),




          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.all(14),
  decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(20),




  // ✅ FULL BORDER
  border: Border.all(
    color: const Color.fromARGB(255, 224, 221, 221), // soft grey border
    width: 1.2,
  ),




  // Optional soft shadow (recommended)
  boxShadow: [
    BoxShadow(
      color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.04),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ],
),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                  _getDepartmentIcon(entry.key),
                color: iconColor,
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                entry.key,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "${entry.value} Students",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class StudentListScreen extends StatelessWidget {
  final String departmentName;
  final int totalStudents;
  final String program;  
  final String year;  


int get totalStudentsYear =>
    demoStudents.where((s) => s.year == year).length;


int get totalPresentYear =>
    demoStudents
        .where((s) => s.year == year && s.isPresent)
        .length;


int get totalAbsentYear =>
    demoStudents
        .where((s) => s.year == year && !s.isPresent)
        .length;


  const StudentListScreen({
    super.key,
    required this.departmentName,
    required this.totalStudents,
    required this.program,  
  required this.year,
  });




  @override
  Widget build(BuildContext context) {




    /// ✅ Proper Student List (NOT List<String>)








    return Scaffold(
    appBar: AppBar(
  toolbarHeight: 70, // increase height to fit 2 lines
  titleSpacing: 0,
  title: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [




        /// 🔷 Program + Year (Dynamic)
    Text(
  "$program - $year",
  style: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
),




      const SizedBox(height: 2),




      /// 🔷 Department Name (Normal)
      Text(
        departmentName,
        style: const TextStyle(
          fontSize: 15,
          color: Color.fromARGB(255, 73, 72, 72),
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  ),
),
   body: Column(
  children: [




_buildYearSummary(),
const SizedBox(height: 12),




    /// 🔷 STUDENT LIST
    Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: demoStudents.length,
        itemBuilder: (context, index) {
          return _buildStudentTile(context, demoStudents[index]);
        },
      ),
    ),
  ],
),
    );
  }


Widget _buildYearSummary() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _summaryItem("Total", totalStudentsYear, Colors.blue),
          _summaryItem("Present", totalPresentYear, Colors.green),
          _summaryItem("Absent", totalAbsentYear, Colors.red),
        ],
      ),
    ),
  );
}
Widget _summaryItem(String title, int count, Color color) {
  return Column(
    children: [
      Text(
        "$count",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
    ],
  );
}
  /// ✅ Navigate Properly
  Widget _buildStudentTile(BuildContext context, StudentModel student) {
   return InkWell(
  borderRadius: BorderRadius.circular(20),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StudentProfileScreen(student: student),
      ),
    );
  },
  child: Container(
    margin: const EdgeInsets.only(bottom: 18),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(20),




  // ✅ FULL BORDER
  border: Border.all(
    color: const Color.fromARGB(255, 224, 221, 221), // soft grey border
    width: 1.2,
  ),




  // Optional soft shadow (recommended)
  boxShadow: [
    BoxShadow(
      color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.04),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ],
),
    child: Row(
      children: [




        /// 🔵 Avatar
        CircleAvatar(
          radius: 22,
          backgroundColor: Colors.blue.withOpacity(0.1),
          child: Text(
            student.name[0],
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),




        const SizedBox(width: 16),




        /// 🔷 Student Info
       Expanded(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        student.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      const SizedBox(height: 6),
      Text(
        "Reg No: ${student.registerNumber}",
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 13,
        ),
      ),
    ],
  ),
),




/// ✅ Attendance Badge
Container(
  padding: const EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 5,
  ),
  decoration: BoxDecoration(
    color: student.isPresent
        ? Colors.green.withOpacity(0.1)
        : Colors.red.withOpacity(0.1),
    borderRadius: BorderRadius.circular(20),
  ),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        student.isPresent
            ? Icons.check_circle
            : Icons.cancel,
        size: 12,
        color: student.isPresent
            ? Colors.green
            : Colors.red,
      ),
      const SizedBox(width: 5),
      Text(
        student.isPresent
            ? "Present"
            : "Absent",
        style: TextStyle(
          color: student.isPresent
              ? Colors.green
              : Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    ],
  ),
),




const SizedBox(width: 8),
      ],
    ),
  ),
);
  }
}
class StudentModel {
  final String name;
  final String registerNumber;
  final String year;
  final bool isPresent;
  final String dob;
  final String gender;
  final String bloodGroup;
  final String aadhar;
  final String email;
  final String phone;




  final String fatherName;
  final String motherName;
  final String address;




  final String religion;
  final String caste;
  final String community;
  final String income;




  final List<String> subjects;
  final int arrears;




  StudentModel({
    required this.name,
    required this.registerNumber,
    required this.year,
     required this.isPresent,
    required this.dob,
    required this.gender,
    required this.bloodGroup,
    required this.aadhar,
    required this.email,
    required this.phone,
    required this.fatherName,
    required this.motherName,
    required this.address,
    required this.religion,
    required this.caste,
    required this.community,
    required this.income,
    required this.subjects,
    required this.arrears,
  });
}
class StudentProfileScreen extends StatelessWidget {
  final StudentModel student;




  const StudentProfileScreen({
    super.key,
    required this.student,
  });




  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
  title: const Text(
    "Student Profile",
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  centerTitle: false,
),
body: SingleChildScrollView(
  padding: const EdgeInsets.all(16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [




      /// 🔷 STUDENT HEADER CARD
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.blue,
              child: Text(
                student.name[0],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(student.email),
                ],
              ),
            ),
         Container(
  padding: const EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 6,
  ),
  decoration: BoxDecoration(
    color: student.isPresent
        ? Colors.green
        : Colors.red,
    borderRadius: BorderRadius.circular(20),
  ),
  child: Text(
    student.isPresent ? "PRESENT" : "ABSENT",
    style: const TextStyle(
      color: Colors.white,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
  ),
),
          ],
        ),
      ),




      const SizedBox(height: 20),




      /// 🔷 PERSONAL INFORMATION
      _buildSectionCard(
        title: "Personal Information",
        children: [
          _infoRow(Icons.calendar_today, "Date of Birth", student.dob),
          _infoRow(Icons.person, "Gender", student.gender),
          _infoRow(Icons.bloodtype, "Blood Group", student.bloodGroup),
          _infoRow(Icons.phone, "Phone", student.phone),
          _infoRow(Icons.email, "Email", student.email),
        ],
      ),




      /// 🔷 PARENTS & ADDRESS
      _buildSectionCard(
        title: "Parents & Address",
        children: [
          _infoRow(Icons.man, "Father Name", student.fatherName),
          _infoRow(Icons.woman, "Mother Name", student.motherName),
          _infoRow(Icons.home, "Address", student.address),
        ],
      ),




      /// 🔷 COMMUNITY DETAILS
      _buildSectionCard(
        title: "Community Details",
        children: [
          _infoRow(Icons.account_balance, "Religion", student.religion),
          _infoRow(Icons.badge, "Caste", student.caste),
          _infoRow(Icons.group, "Community", student.community),
          _infoRow(Icons.currency_rupee, "Income", student.income),
        ],
      ),
     _buildSectionCard(
  title: "Academic Details",
  children: [




    /// 🔴 Arrear Count
    _infoRow(Icons.warning, "Arrear Count", "${student.arrears}"),




    const SizedBox(height: 10),




    /// 📘 Arrear Subjects
    if (student.arrears > 0)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Arrear Subjects",
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 6),




          ...student.subjects.map(
            (subject) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                "• $subject",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      )
    else
      const Text(
        "No Arrears 🎉",
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.w600,
        ),
      ),
  ],
),
      const SizedBox(height: 30),
    ],
  ),
),
    );
  }




 Widget _buildSectionCard({
  required String title,
  required List<Widget> children,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}




Widget _infoRow(IconData icon, String title, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      children: [
        Icon(icon, size: 18, color: Colors.blue),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
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
          ),
        ),
      ],
    ),
  );
}
Widget _buildRow(IconData icon, String title, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Row(
      children: [
        Icon(icon, size: 20, color: Colors.blue),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
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
          ),
        ),
      ],
    ),
  );
}
}class StudentSearchScreen extends StatelessWidget {
  final String query;




  const StudentSearchScreen({super.key, required this.query});




  @override
  Widget build(BuildContext context) {




    final List<StudentModel> allStudents = demoStudents; // use your list




    final results = allStudents.where((student) {
      return student.name.toLowerCase().contains(query.toLowerCase()) ||
          student.registerNumber.toLowerCase().contains(query.toLowerCase());
    }).toList();




    return Scaffold(
      appBar: AppBar(
        title: Text("Search: $query"),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: results.isEmpty
          ? const Center(child: Text("No students found"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: results.length,
              itemBuilder: (context, index) {
                final student = results[index];
                return ListTile(
                  title: Text(student.name),
                  subtitle: Text(student.registerNumber),
                );
              },
            ),
    );
  }
}



