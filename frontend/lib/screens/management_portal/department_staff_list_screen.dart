import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'staff_profile_screen.dart';

class DepartmentStaffListScreen extends StatelessWidget {
  final String departmentName;
  final List<Map<String, dynamic>> staffList;

  const DepartmentStaffListScreen({
    super.key,
    required this.departmentName,
    required this.staffList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              // HEADER
              Row(
                children: [
                  IconButton(
                    onPressed: ()=>Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(departmentName,
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                      Text("${staffList.length} Staff Members",
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.grey)),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Expanded(
                child: ListView.builder(
                  itemCount: staffList.length,
                itemBuilder: (context, index) {
  final staff = staffList[index];

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => StaffProfileScreen(
            staff: staff,
          ),
        ),
      );
    },
    child: staffCard(staff),
  );
},

                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  // ---------------- STAFF CARD ----------------
  Widget staffCard(Map<String,dynamic> staff){

    bool present = staff["present"];

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [

          // DOT
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: present ? Colors.green : Colors.red,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        staff["name"],
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: present ? Colors.black : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        present ? "Present" : "Absent",
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: present ? Colors.white : Colors.black,
                        ),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 4),

                Text(
                  staff["role"],
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey),
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    const Icon(Icons.email,size:14,color:Colors.grey),
                    const SizedBox(width:6),
                    Text(staff["email"],
                        style: GoogleFonts.inter(fontSize:12)),
                  ],
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    const Icon(Icons.phone,size:14,color:Colors.grey),
                    const SizedBox(width:6),
                    Text(staff["phone"],
                        style: GoogleFonts.inter(fontSize:12)),
                  ],
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////
/// 🔹 ALL STAFF DATA (ONE PLACE)
////////////////////////////////////////////////////////

final Map<String,List<Map<String,dynamic>>> departmentStaffData = {

"Computer Science":[
 {"name":"Dr. Rajesh Kumar","role":"Professor & HOD","email":"rajesh.kumar@slec.edu.in","phone":"+91 98765 11111","present":true},
 {"name":"Dr. Arun Sharma","role":"Associate Professor","email":"arun.sharma@slec.edu.in","phone":"+91 98765 11112","present":true},
 {"name":"Prof. Kavitha Reddy","role":"Assistant Professor","email":"kavitha.reddy@slec.edu.in","phone":"+91 98765 11113","present":true},
 {"name":"Dr. Suresh Patel","role":"Associate Professor","email":"suresh.patel@slec.edu.in","phone":"+91 98765 11114","present":false},
],

"Electronics & Communication":[
 {"name":"Dr. Priya Sharma","role":"Professor & HOD","email":"priya.sharma@slec.edu.in","phone":"+91 98765 22221","present":true},
 {"name":"Prof. Ramesh Iyer","role":"Associate Professor","email":"ramesh.iyer@slec.edu.in","phone":"+91 98765 22222","present":true},
 {"name":"Dr. Anjali Menon","role":"Assistant Professor","email":"anjali.menon@slec.edu.in","phone":"+91 98765 22223","present":true},
],

"Mechanical Engineering":[
 {"name":"Dr. Vijay Patel","role":"Professor & HOD","email":"vijay.patel@slec.edu.in","phone":"+91 98765 33331","present":true},
 {"name":"Prof. Deepak Singh","role":"Associate Professor","email":"deepak.singh@slec.edu.in","phone":"+91 98765 33332","present":false},
 {"name":"Dr. Lakshmi Rao","role":"Assistant Professor","email":"lakshmi.rao@slec.edu.in","phone":"+91 98765 33333","present":true},
],

"Information Technology":[
 {"name":"Dr. Anita Desai","role":"Professor & HOD","email":"anita.desai@slec.edu.in","phone":"+91 98765 44441","present":true},
 {"name":"Prof. Mohan Kumar","role":"Associate Professor","email":"mohan.kumar@slec.edu.in","phone":"+91 98765 44442","present":true},
 {"name":"Dr. Pooja Verma","role":"Assistant Professor","email":"pooja.verma@slec.edu.in","phone":"+91 98765 44443","present":true},
],

"Cyber Security":[
 {"name":"Dr. Suresh Reddy","role":"Professor & HOD","email":"suresh.reddy@slec.edu.in","phone":"+91 98765 55551","present":true},
 {"name":"Prof. Sneha Krishnan","role":"Associate Professor","email":"sneha.krishnan@slec.edu.in","phone":"+91 98765 55552","present":false},
 {"name":"Dr. Vikram Gupta","role":"Assistant Professor","email":"vikram.gupta@slec.edu.in","phone":"+91 98765 55553","present":true},
],

"Artificial Intelligence & Data Science":[
 {"name":"Dr. Karthik Iyer","role":"Professor & HOD","email":"karthik.iyer@slec.edu.in","phone":"+91 98765 66661","present":true},
 {"name":"Prof. Rekha Nair","role":"Associate Professor","email":"rekha.nair@slec.edu.in","phone":"+91 98765 66662","present":true},
 {"name":"Dr. Arjun Bhat","role":"Assistant Professor","email":"arjun.bhat@slec.edu.in","phone":"+91 98765 66663","present":true},
],

"MBA":[
 {"name":"Dr. Meera Singh","role":"Professor & HOD","email":"meera.singh@slec.edu.in","phone":"+91 98765 77771","present":true},
 {"name":"Prof. Rahul Mehta","role":"Associate Professor","email":"rahul.mehta@slec.edu.in","phone":"+91 98765 77772","present":true},
 {"name":"Dr. Divya Kapoor","role":"Assistant Professor","email":"divya.kapoor@slec.edu.in","phone":"+91 98765 77773","present":false},
],

};
