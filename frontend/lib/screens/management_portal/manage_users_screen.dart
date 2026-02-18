import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_new_admin_screen.dart';


class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  String selectedTab = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      body: SafeArea(
        child: Padding(
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

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Manage Users",
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                      Text("5 Staff Members",
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.grey)),
                    ],
                  ),

                  const Spacer(),

                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Text("Management Admin",
                        style: GoogleFonts.inter(fontSize: 12)),
                  )
                ],
              ),

              const SizedBox(height: 16),

              // ================= ADD STAFF BUTTON =================
             GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddNewAdminScreen(),
      ),
    );
  },
  child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person_add, color: Colors.white),
                    const SizedBox(width: 8),
                    Text("Add New Staff",
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
             ),
              const SizedBox(height: 14),

              // ================= SEARCH =================
              TextField(
                decoration: InputDecoration(
                  hintText: "Search staff...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // ================= FILTER TABS =================
              Row(
                children: [
                  tab("All"),
                  tab("Teaching"),
                  tab("Non-Teaching"),
                ],
              ),

              const SizedBox(height: 16),

              // ================= STATS =================
              Row(
                children: [

                  Expanded(
                    child: statCard("3", "Teaching Staff", Colors.blue),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child:
                        statCard("2", "Non-Teaching Staff", Colors.purple),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ================= STAFF LIST =================
              Expanded(
                child: ListView(
                  children: [

                    if (selectedTab == "All" ||
                        selectedTab == "Teaching")
                      staffCard(
                        name: "Dr. Rajesh Kumar",
                        role: "Professor & HOD",
                        dept: "Computer Science",
                        email: "rajesh.kumar@slec.edu.in",
                        phone: "+91 98765 43210",
                        joined: "15/06/2015",
                        type: "Teaching",
                      ),

                    if (selectedTab == "All" ||
                        selectedTab == "Teaching")
                      staffCard(
                        name: "Dr. Priya Sharma",
                        role: "Professor & HOD",
                        dept: "Electronics & Communication",
                        email: "priya.sharma@slec.edu.in",
                        phone: "+91 98765 43211",
                        joined: "20/07/2016",
                        type: "Teaching",
                      ),

                    if (selectedTab == "All" ||
                        selectedTab == "Teaching")
                      staffCard(
                        name: "Prof. Kavitha Reddy",
                        role: "Assistant Professor",
                        dept: "Computer Science",
                        email: "kavitha@slec.edu.in",
                        phone: "+91 98765 43212",
                        joined: "12/06/2018",
                        type: "Teaching",
                      ),

                    if (selectedTab == "All" ||
                        selectedTab == "Non-Teaching")
                      staffCard(
                        name: "Ramesh Kumar",
                        role: "Senior Administrator",
                        dept: "Administration",
                        email: "ramesh@slec.edu.in",
                        phone: "+91 98765 43213",
                        joined: "10/03/2014",
                        type: "Non-Teaching",
                      ),

                    if (selectedTab == "All" ||
                        selectedTab == "Non-Teaching")
                      staffCard(
                        name: "Sunita Rao",
                        role: "Office Coordinator",
                        dept: "Office",
                        email: "sunita@slec.edu.in",
                        phone: "+91 98765 43214",
                        joined: "05/08/2019",
                        type: "Non-Teaching",
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= TAB =================
  Widget tab(String text) {
    bool active = selectedTab == text;

    return GestureDetector(
      onTap: () {
        setState(() => selectedTab = text);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: active ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
              color: active ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  // ================= STAT CARD =================
  Widget statCard(String count, String title, Color color) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Column(
        children: [
          Text(count,
              style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: color)),
          const SizedBox(height: 6),
          Text(title,
              style: GoogleFonts.inter(
                  fontSize: 12, color: color)),
        ],
      ),
    );
  }

  // ================= STAFF CARD =================
  Widget staffCard({
    required String name,
    required String role,
    required String dept,
    required String email,
    required String phone,
    required String joined,
    required String type,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Expanded(
                child: Text(name,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600)),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(type,
                    style: GoogleFonts.inter(
                        color: Colors.white, fontSize: 11)),
              ),

              const SizedBox(width: 8),

              const Icon(Icons.delete, color: Colors.red),
            ],
          ),

          const SizedBox(height: 6),

          Text(role,
              style: GoogleFonts.inter(fontSize: 12)),

          Text(dept,
              style: GoogleFonts.inter(
                  fontSize: 12, color: Colors.grey)),

          const SizedBox(height: 8),

          Row(
            children: [
              const Icon(Icons.email, size: 14),
              const SizedBox(width: 6),
              Text(email,
                  style: GoogleFonts.inter(fontSize: 12)),
            ],
          ),

          const SizedBox(height: 4),

          Row(
            children: [
              const Icon(Icons.phone, size: 14),
              const SizedBox(width: 6),
              Text(phone,
                  style: GoogleFonts.inter(fontSize: 12)),
            ],
          ),

          const SizedBox(height: 4),

          Row(
            children: [
              const Icon(Icons.calendar_month, size: 14),
              const SizedBox(width: 6),
              Text("Joined: $joined",
                  style: GoogleFonts.inter(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
