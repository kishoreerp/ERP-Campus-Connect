import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'teaching_staff_attendance_screen.dart';
import 'non_teaching_staff_attendance_screen.dart';


class ManagementAttendanceScreen extends StatelessWidget {
  const ManagementAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

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
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Today's Attendance",
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                      Text("December 15, 2025",
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
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text("Management Admin",
                        style: GoogleFonts.inter(fontSize: 12)),
                  )
                ],
              ),

              const SizedBox(height: 24),

              // ================= OVERALL ATTENDANCE =================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blue),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.people, color: Colors.blue),
                    const SizedBox(height: 8),

                    Text("Overall Attendance",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600)),

                    const SizedBox(height: 8),

                    Text("26/32",
                        style: GoogleFonts.inter(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),

                    const SizedBox(height: 6),

                    Text("81.3% Present",
                        style: GoogleFonts.inter(
                            color: Colors.blue)),
                  ],
                ),
              ),

              const SizedBox(height: 24),

            // ================= TEACHING STAFF =================
GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const TeachingStaffAttendanceScreen(),
      ),
    );
  },
  child: _staffCard(
    title: "Teaching Staff",
    present: "18",
    absent: "4",
    rate: "81.8%",
    iconColor: Colors.green,
  ),
),

              // ================= NON-TEACHING STAFF =================
             GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const NonTeachingStaffAttendanceScreen(),
      ),
    );
  },
  child: _staffCard(
                title: "Non-Teaching Staff",
                present: "8",
                absent: "2",
                rate: "80.0%",
                iconColor: Colors.purple,
              ),
             ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= STAFF CARD =================
  Widget _staffCard({
    required String title,
    required String present,
    required String absent,
    required String rate,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [

          Row(
            children: [
              CircleAvatar(
                backgroundColor: iconColor.withOpacity(0.15),
                child: Icon(Icons.person, color: iconColor),
              ),

              const SizedBox(width: 12),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600)),
                  Text("Click to view details",
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.grey)),
                ],
              )
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              _smallBox(present, "Present", Colors.green),
              const SizedBox(width: 10),
              _smallBox(absent, "Absent", Colors.red),
              const SizedBox(width: 10),
              _smallBox(rate, "Rate", Colors.blue),
            ],
          )
        ],
      ),
    );
  }

  // ================= SMALL BOX =================
  Widget _smallBox(String value, String label, Color color) {
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
