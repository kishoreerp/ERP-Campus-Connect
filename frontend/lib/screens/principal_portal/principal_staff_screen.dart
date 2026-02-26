import 'package:flutter/material.dart';

class PrincipalStaffScreen extends StatefulWidget {
  const PrincipalStaffScreen({super.key});

  @override
  State<PrincipalStaffScreen> createState() =>
      _PrincipalStaffScreenState();
}

class _PrincipalStaffScreenState
    extends State<PrincipalStaffScreen> {

  final TextEditingController _searchController = TextEditingController();
  
 final List<String> departments = [
  "All",
  "Information Technology",
  "Computer Science",
  "Cyber Security",
  "Artificial Intelligence",
  "Electronics and communication",
  "MBA",
];
void _filterStaff() {
  setState(() {
    filteredStaff = staffList.where((staff) {
      final matchesSearch = staff.name
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()) ||
          staff.department
              .toLowerCase()
              .contains(_searchController.text.toLowerCase());

      final matchesDepartment = selectedDepartment == "All" ||
          staff.department == selectedDepartment;

      return matchesSearch && matchesDepartment;
    }).toList();
  });
}
String selectedDepartment = "All";

  final List<StaffModel> staffList = [


  StaffModel(
    name: "Dr. Ravi Kumar",
    staffId: "STF001",
    department: "Computer Science",
    designation: "Professor",
    phone: "9876543210",
    email: "ravi@college.edu",
    dob: "12-08-1980",
    gender: "Male",
    bloodGroup: "B+",
    address: "Chennai, Tamil Nadu",
    qualification: "M.Tech Cyber Security",
  experience: 6,
  salary: "₹ 65,000 / month",
  joiningDate: "12-06-2018",
  subjects: [
    "Ethical Hacking",
    "Network Security",
    "Cryptography"],
    isActive: true,
  ),

  StaffModel(
    name: "Ms. Anitha",
    staffId: "STF002",
    department: "Information Technology",
    designation: "Assistant Professor",
    phone: "9123456780",
    email: "anitha@college.edu",
    dob: "03-04-1985",
    gender: "Female",
    bloodGroup: "O+",
    address: "Coimbatore, Tamil Nadu",
     qualification: "M.Tech Information Technology",
  experience: 8,
  salary: "₹ 75,000 / month",
  joiningDate: "15-06-2016",
  subjects: [
    "Web Development",
    "Database Management",
    "Software Engineering"
  ],
   isActive: true,
  ),

  StaffModel(
    name: "Mr. Suresh",
    staffId: "STF003",
    department: "Cyber Security",
    designation: "Lecturer",
    phone: "9988776655",
    email: "suresh@college.edu",
    dob: "25-01-1990",
    gender: "Male",
    bloodGroup: "A+",
    address: "Madurai, Tamil Nadu",
    qualification: "M.Tech Cyber Security",
  experience: 6,
  salary: "₹ 65,000 / month",
  joiningDate: "12-06-2018",
  subjects: [
    "Ethical Hacking",
    "Network Security",
    "Cryptography"
  ],
   isActive: false,
  ),
StaffModel(
  name: "Dr. Priya Sharma",
  staffId: "STF004",
  department: "Artificial Intelligence",
  designation: "Associate Professor",
  phone: "9876501234",
  email: "priya.ai@college.edu",
  dob: "14-02-1987",
  gender: "Female",
  bloodGroup: "AB+",
  address: "Bangalore, Karnataka",
  qualification: "PhD in Artificial Intelligence",
  experience: 10,
  salary: "₹ 90,000 / month",
  joiningDate: "10-07-2015",
  subjects: [
    "Machine Learning",
    "Deep Learning",
    "Neural Networks"
  ],
  isActive: true,
),

StaffModel(
  name: "Mr. Arjun Verma",
  staffId: "STF005",
  department: "Electronics and communication",
  designation: "Assistant Professor",
  phone: "9123409876",
  email: "arjun.ece@college.edu",
  dob: "21-09-1989",
  gender: "Male",
  bloodGroup: "O-",
  address: "Hyderabad, Telangana",
  qualification: "M.Tech in ECE",
  experience: 7,
  salary: "₹ 70,000 / month",
  joiningDate: "18-06-2017",
  subjects: [
    "Digital Electronics",
    "Microprocessors",
    "Signal Processing"
  ],
  isActive: true,
),

StaffModel(
  name: "Dr. Kavitha Rao",
  staffId: "STF006",
  department: "MBA",
  designation: "Professor",
  phone: "9988001122",
  email: "kavitha.mba@college.edu",
  dob: "05-11-1982",
  gender: "Female",
  bloodGroup: "B-",
  address: "Chennai, Tamil Nadu",
  qualification: "PhD in Management",
  experience: 12,
  salary: "₹ 1,00,000 / month",
  joiningDate: "01-08-2013",
  subjects: [
    "Marketing Management",
    "Financial Management",
    "Human Resource Management"
  ],
  isActive: true,
),
];
  

  List<StaffModel> filteredStaff = [];

  @override
  void initState() {
    super.initState();
    filteredStaff = staffList;
  }
  

  void _searchStaff(String query) {
    setState(() {
      filteredStaff = staffList
          .where((staff) =>
              staff.name.toLowerCase().contains(query.toLowerCase()) ||
              staff.department.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
       automaticallyImplyLeading: false, 
        centerTitle: false,
         toolbarHeight: 45, 
  title:/// 🔹 Section Title

Padding(
  padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
  child: Text(
    "Staff Management",
    style: const TextStyle(
      fontSize: 20,        // 🔥 Change size here
      fontWeight: FontWeight.bold,
    ),
  ),
),
  
),

      body: Column(
        children: [
          

          /// 🔎 Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  )
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _searchStaff,
                decoration: const InputDecoration(
                  icon: Icon(Icons.search),
                  hintText: "Search Staff...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

/// 🏢 Department Filter 
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(30),
    child: Container(
      height: 45,
      color: const Color.fromARGB(255, 255, 255, 255),
      child: InteractiveViewer(
        constrained: false,
        boundaryMargin: const EdgeInsets.all(20),
        
        minScale: 1,
        maxScale: 1, 
         panAxis: PanAxis.horizontal,
        child: Row(
          children: departments.map((dept) {
            final isSelected = selectedDepartment == dept;

            return Padding(
              padding: const EdgeInsets.only(right: 14),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDepartment = dept;
                  });
                  _filterStaff();
                  
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isSelected ? Colors.blue : Colors.white,
                    borderRadius:
                        BorderRadius.circular(25),
                    border: Border.all(
                      color: isSelected
                          ? Colors.blue
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    dept,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    ),
  ),
),
const SizedBox(height: 10),
          /// 👨‍🏫 Staff List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredStaff.length,
              itemBuilder: (context, index) {
                final staff = filteredStaff[index];
                return _buildStaffCard(context, staff);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffCard(BuildContext context, StaffModel staff) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => StaffProfileScreen(staff: staff),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [

            /// Avatar
            CircleAvatar(
              radius: 26,
              backgroundColor: Colors.blue.withOpacity(0.1),
              child: Text(
                staff.name[0],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),

            const SizedBox(width: 16),

            /// Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    staff.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    staff.designation,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}

class StaffModel {
  final String name;
  final String staffId;
  final String designation;
  final String department;
  final String phone;
  final String email;
  final String dob;
  final String gender;
  final String bloodGroup;
  final String address;
  final String qualification;
  final int experience; 
  final String salary;
  final String joiningDate;
  final List<String> subjects;
  final bool isActive;


  StaffModel({
    required this.name,
    required this.staffId,
    required this.designation,
    required this.department,
    required this.phone,
    required this.email,
    required this.dob,
    required this.gender,
    required this.bloodGroup,
    required this.address,
     required this.qualification,
    required this.experience,
    required this.salary,
    required this.joiningDate,
    required this.subjects,
    required this.isActive,
  });
}

class StaffProfileScreen extends StatelessWidget {
  final StaffModel staff;

  const StaffProfileScreen({
    super.key,
    required this.staff,
  });

  @override
  Widget build(BuildContext context) {
   return Scaffold(
  backgroundColor: const Color.fromARGB(255, 255, 255, 255),

  appBar: AppBar(
    title: const Text(
      "Staff Profile",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: false,
  ),

  body: SingleChildScrollView(
    padding: const EdgeInsets.only(top: 10), // little spacing
        child: Column(
          children: [

            /// 👤 FLOATING PROFILE CARD
           Padding(
  padding: const EdgeInsets.only(top: 10),
  child: Column(
                children: [

                Center(
  child: Container(
    width: MediaQuery.of(context).size.width * 0.92, // 👈 controls size
    margin: const EdgeInsets.only(top: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.blue.withOpacity(0.08),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.blue.withOpacity(0.2)),
    ),

  child: Row(
    children: [

      /// 🔵 Avatar
      CircleAvatar(
        radius: 26,
        backgroundColor: Colors.blue,
        child: Text(
          staff.name[0],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      const SizedBox(width: 14),

      /// 🔷 Staff Info
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              staff.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              staff.email,
              style: const TextStyle(
                color: Color.fromARGB(255, 17, 13, 13),
              ),
            ),
          ],
        ),
      ),

      /// ✅ Status Badge (Like Student Present)
      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: staff.isActive
              ? Colors.green.withOpacity(0.1)
              : Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              staff.isActive
                  ? Icons.check_circle
                  : Icons.cancel,
              size: 14,
              color: staff.isActive
                  ? Colors.green
                  : Colors.red,
            ),
            const SizedBox(width: 5),
            Text(
              staff.isActive
                  ? "Active"
                  : "On Leave",
              style: TextStyle(
                color: staff.isActive
                    ? Colors.green
                    : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
  ),
),

                  const SizedBox(height: 20),

                  /// 📋 PROFESSIONAL INFORMATION
                  _buildInfoCard("Professional Information", [
                    _infoRow("Department", staff.department),
                    _infoRow("Phone", staff.phone),
                    _infoRow("Email", staff.email),
                  ]),

                  /// 👤 PERSONAL INFORMATION
                  _buildInfoCard("Personal Information", [
                    _infoRow("Date of Birth", staff.dob),
                    _infoRow("Gender", staff.gender),
                    _infoRow("Blood Group", staff.bloodGroup),
                    _infoRow("Address", staff.address),
                  ]),
                  _buildInfoCard("Professional Information", [

  _infoRow("Department", staff.department),
  _infoRow("Designation", staff.designation),
  _infoRow("Qualification", staff.qualification),
  _infoRow("Experience", "${staff.experience} Years"),
  _infoRow("Date of Joining", staff.joiningDate),
  _infoRow("Salary", staff.salary),

]),
_buildInfoCard("Subjects Handling", [

  Wrap(
    spacing: 8,
    runSpacing: 8,
    children: staff.subjects.map((subject) {
      return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          subject,
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }).toList(),
  ),

]),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Info Card
  Widget _buildInfoCard(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
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
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }

  /// 🔹 Info Row
  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color.fromARGB(255, 104, 102, 102),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}