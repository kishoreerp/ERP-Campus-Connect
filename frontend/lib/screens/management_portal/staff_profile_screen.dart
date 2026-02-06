import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class StaffProfileScreen extends StatelessWidget {

  final Map<String, dynamic> staff;

  const StaffProfileScreen({
    super.key,
    required this.staff,
  });

  @override
  Widget build(BuildContext context) {

    bool present = staff["present"];

    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

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

                  Text(
                    "Staff Profile",
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),

                  const Spacer(),

                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Management Admin",
                      style: GoogleFonts.inter(fontSize: 12),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 20),

              // ================= PROFILE CARD =================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [

                    CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.person,
                          size: 40, color: Colors.white),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      staff["name"],
                      style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      staff["role"],
                      style: GoogleFonts.inter(color: Colors.grey),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: present ? Colors.black : Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        present ? "Present Today" : "Absent Today",
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // ================= CONTACT INFO =================
              infoCard(
                title: "Contact Information",
                children: [
                  infoRow(Icons.email, staff["email"]),
                  infoRow(Icons.phone, staff["phone"]),
                  infoRow(Icons.location_on,
                      staff["address"] ?? "Not Available"),
                ],
              ),

              const SizedBox(height: 16),

              // ================= PROFESSIONAL INFO =================
              infoCard(
                title: "Professional Information",
                children: [
                  infoRow(Icons.school,
                      "Qualification: ${staff["qualification"]}"),
                  infoRow(Icons.work,
                      "Experience: ${staff["experience"]}"),
                  infoRow(Icons.calendar_month,
                      "Date of Joining: ${staff["joiningDate"]}"),
                  infoRow(Icons.memory,
                      "Specialization: ${staff["specialization"]}"),
                  infoRow(Icons.book,
                      "Publications: ${staff["publications"]}"),
                ],
              ),

              const SizedBox(height: 16),

              // ================= ATTENDANCE =================
              infoCard(
                title: "Attendance Summary (This Month)",
                children: [
                  Row(
                    children: [

                      attendanceBox("22", "Present", Colors.green),

                      const SizedBox(width: 10),

                      attendanceBox("2", "Absent", Colors.red),

                      const SizedBox(width: 10),

                      attendanceBox("92%", "Rate", Colors.blue),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= INFO CARD =================
  Widget infoCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  // ================= INFO ROW =================
  Widget infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.blue),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text,
                style: GoogleFonts.inter(fontSize: 13)),
          )
        ],
      ),
    );
  }

  // ================= ATTENDANCE BOX =================
  Widget attendanceBox(
      String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color),
        ),
        child: Column(
          children: [
            Text(value,
                style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color)),
            const SizedBox(height: 4),
            Text(label,
                style: GoogleFonts.inter(
                    fontSize: 12,
                    color: color)),
          ],
        ),
      ),
    );
  }
}
