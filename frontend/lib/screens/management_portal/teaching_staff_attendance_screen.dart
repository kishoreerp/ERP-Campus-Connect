import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeachingStaffAttendanceScreen extends StatefulWidget {
  const TeachingStaffAttendanceScreen({super.key});

  @override
  State<TeachingStaffAttendanceScreen> createState() =>
      _TeachingStaffAttendanceScreenState();
}

class _TeachingStaffAttendanceScreenState
    extends State<TeachingStaffAttendanceScreen> {
    bool showPresent = true; // toggle

  // ---------------- PRESENT STAFF ----------------
  final List<Map<String, String>> presentStaff = [
    {
      "name": "Dr. Rajesh Kumar",
      "role": "Professor & HOD",
      "dept": "Computer Science",
      "time": "08:45 AM"
    },
    {
      "name": "Dr. Arun Sharma",
      "role": "Associate Professor",
      "dept": "Computer Science",
      "time": "08:52 AM"
    },
    {
      "name": "Prof. Kavitha Reddy",
      "role": "Assistant Professor",
      "dept": "Computer Science",
      "time": "08:38 AM"
    },
  ];

  // ---------------- ABSENT STAFF ----------------
  final List<Map<String, String>> absentStaff = [
    {
      "name": "Dr. Suresh Patel",
      "role": "Associate Professor",
      "dept": "Computer Science",
      "reason": "Sick Leave"
    },
    {
      "name": "Prof. Deepak Singh",
      "role": "Associate Professor",
      "dept": "Mechanical Engineering",
      "reason": "Personal Leave"
    },
    {
      "name": "Prof. Sneha Krishnan",
      "role": "Associate Professor",
      "dept": "Cyber Security",
      "reason": "Conference"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ---------------- HEADER ----------------
              Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back)),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Teaching Staff",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      Text("Attendance"),
                    ],
                  ),

                  const Spacer(),

                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text("Management Admin"),
                  )
                ],
              ),

              const SizedBox(height: 6),
              const Text("December 15, 2025"),

              const SizedBox(height: 20),

              // ---------------- STATS ----------------
              Row(
                children: const [
                  _StatBox("18", "Present", Colors.green),
                  SizedBox(width: 12),
                  _StatBox("4", "Absent", Colors.red),
                  SizedBox(width: 12),
                  _StatBox("82%", "Rate", Colors.blue),
                ],
              ),

              const SizedBox(height: 20),

              // ---------------- TABS ----------------
              Row(
                children: [

                  // PRESENT
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          showPresent = true;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: showPresent ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Center(
                          child: Text(
                            "Present (18)",
                            style: TextStyle(
                              color: showPresent
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // ABSENT
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          showPresent = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: !showPresent ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Center(
                          child: Text(
                            "Absent (4)",
                            style: TextStyle(
                              color: !showPresent
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ---------------- LIST ----------------
              if (showPresent)
                ...presentStaff.map((s) => presentTile(
                      s["name"]!,
                      s["role"]!,
                      s["dept"]!,
                      s["time"]!,
                    ))
              else
                ...absentStaff.map((s) => absentTile(
                      s["name"]!,
                      s["role"]!,
                      s["dept"]!,
                      s["reason"]!,
                    )),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- PRESENT TILE ----------------
  Widget presentTile(
      String name, String role, String dept, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.green),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),
          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600)),
                Text(role),
                Text(dept,
                    style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 6),
                Text("Check-in: $time",
                    style: const TextStyle(color: Colors.green)),
              ],
            ),
          )
        ],
      ),
    );
  }

  // ---------------- ABSENT TILE ----------------
  Widget absentTile(
      String name, String role, String dept, String reason) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.red),
      ),
      child: Row(
        children: [
          const Icon(Icons.cancel, color: Colors.red),
          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600)),
                Text(role),
                Text(dept,
                    style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 6),

                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    reason,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 12),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// ---------------- STAT BOX ----------------
class _StatBox extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _StatBox(this.value, this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color),
        ),
        child: Column(
          children: [
            Text(value,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: color)),
            const SizedBox(height: 6),
            Text(label, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}
