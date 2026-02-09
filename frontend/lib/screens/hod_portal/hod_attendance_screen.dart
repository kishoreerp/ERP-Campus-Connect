import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HODAttendanceScreen extends StatelessWidget {
  const HODAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
     appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Attendance Management",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              "Choose an option to manage attendance",
              style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),

      // ================= BODY =================
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _attendanceCard(
              icon: Icons.check_circle_outline,
              color: Colors.blue,
              title: "Mark Attendance",
              subtitle: "Mark attendance for your subjects",
              onTap: () {
                Navigator.pushNamed(context, '/hod-mark-attendance');
              },
            ),
            const SizedBox(height: 12),
            _attendanceCard(
              icon: Icons.remove_red_eye_outlined,
              color: Colors.green,
              title: "View Attendance",
              subtitle: "View department student attendance",
              onTap: () {
                Navigator.pushNamed(context, '/hod-view-attendance');
              },
            ),
            const SizedBox(height: 12),
            _attendanceCard(
              icon: Icons.people_outline,
              color: Colors.purple,
              title: "Staff Attendance",
              subtitle: "View department faculty attendance",
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierColor: Colors.black.withOpacity(0.45),
                  builder: (_) => const _StaffAttendanceDialog(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ================= CARD =================
  Widget _attendanceCard({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600)),
                  Text(subtitle,
                      style: GoogleFonts.inter(
                          fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////
/// STAFF ATTENDANCE POPUP (SCROLLABLE – FIXED)
//////////////////////////////////////////////////////////////////////////////

class _StaffAttendanceDialog extends StatelessWidget {
  const _StaffAttendanceDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75, // ✅ KEY FIX
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Staff Attendance",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Text(
                "View department faculty attendance",
                style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 12),

              // SCROLLABLE LIST
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _staffList.length,
                  itemBuilder: (context, index) {
                    final staff = _staffList[index];
                    return _StaffTile(
                      name: staff['name'],
                      role: staff['role'],
                      classes: staff['classes'],
                      time: staff['time'],
                      present: staff['present'],
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
}

//////////////////////////////////////////////////////////////////////////////
/// STAFF DATA
//////////////////////////////////////////////////////////////////////////////

const List<Map<String, dynamic>> _staffList = [
  {
    "name": "Prof. David Lee",
    "role": "Professor",
    "classes": "Data Structures, Algorithms",
    "time": "09:00 AM",
    "present": true,
  },
  {
    "name": "Dr. Lisa Wong",
    "role": "Associate Professor",
    "classes": "Database Systems",
    "time": "09:00 AM",
    "present": true,
  },
  {
    "name": "Dr. John Smith",
    "role": "Assistant Professor",
    "classes": "Web Development",
    "time": "-",
    "present": false,
  },
  {
    "name": "Prof. Sarah Miller",
    "role": "Professor",
    "classes": "Operating Systems",
    "time": "09:15 AM",
    "present": true,
  },
  {
    "name": "Dr. Michael Brown",
    "role": "Associate Professor",
    "classes": "Computer Networks",
    "time": "09:20 AM",
    "present": true,
  },
];

//////////////////////////////////////////////////////////////////////////////
/// STAFF TILE
//////////////////////////////////////////////////////////////////////////////

class _StaffTile extends StatelessWidget {
  final String name;
  final String role;
  final String classes;
  final String time;
  final bool present;

  const _StaffTile({
    required this.name,
    required this.role,
    required this.classes,
    required this.time,
    required this.present,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor:
                    present ? Colors.green.shade100 : Colors.red.shade100,
                child: Icon(Icons.person,
                    color: present ? Colors.green : Colors.red),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600)),
                    Text(role,
                        style: GoogleFonts.inter(
                            fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: present
                      ? Colors.green.withOpacity(0.15)
                      : Colors.red.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  present ? "Present" : "Absent",
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: present ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _info(Icons.menu_book, "Classes: $classes"),
          _info(Icons.access_time, "Check-in Time: $time"),
        ],
      ),
    );
  }

  Widget _info(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text,
                style: GoogleFonts.inter(fontSize: 12)),
          ),
        ],
      ),
    );  
  }
}
