import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/current_user_service.dart';

import 'student_notes_screen.dart';
import 'student_events_screen.dart';
import 'student_notifications_screen.dart';
import 'student_class_timetable_screen.dart';
import 'student_exam_timetable_screen.dart';
import 'student_marks_screen.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});


  @override
State<StudentHomeScreen> createState() => _StudentHomeScreenState();

}


Map<String, dynamic>? studentData;

List<Map<String, dynamic>> leaveRequests = [];
bool leaveLoading = true;

List<Map<String, dynamic>> recentUpdates = [];

class _StudentHomeScreenState extends State<StudentHomeScreen> {





@override
void initState() {
  super.initState();

  studentData = CurrentUserService.getUser(); // ✅ CACHE
  loadRecentUpdates();
}




Future<void> loadLeaveRequests(VoidCallback refresh) async {
  leaveLoading = true;
  refresh();

  final uid = FirebaseAuth.instance.currentUser!.uid;

  final snapshot = await FirebaseFirestore.instance
      .collection('leave_requests')
      .where('studentId', isEqualTo: uid)
      .orderBy('date', descending: true)
      .get();

  leaveRequests = snapshot.docs.map((d) => d.data()).toList();

  leaveLoading = false;
  refresh();
}


Future<void> loadRecentUpdates() async {
  final snapshot = await FirebaseFirestore.instance
      .collection('student_updates')
      .orderBy('createdAt', descending: true)
      .limit(5)
      .get();

  setState(() {
    recentUpdates = snapshot.docs.map((d) => d.data()).toList();
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 16),
              _buildStatsRow(),
              const SizedBox(height: 24),
              _buildQuickActions(context),
              const SizedBox(height: 24),
              _buildAcademicSchedule(context),
              const SizedBox(height: 24),
              _buildRecentUpdates(),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- HEADER ----------------
  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.deepPurple.shade100,
            child: Text(
              studentData?['username']
                  ?.split(' ')
                  .map((e) => e[0])
                  .take(2)
                  .join() ?? '',
              style: GoogleFonts.inter(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
  studentData?['username'] ?? '',
  style: GoogleFonts.inter(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  ),
),

  const SizedBox(height: 2),

  Text(
  studentData?['department'] ?? '',
  style: GoogleFonts.inter(
    color: Colors.grey[600],
    fontSize: 13,
    fontWeight: FontWeight.w500,
  ),
),


const SizedBox(height: 2),
Text(
  '${studentData?['rollNo'] ?? ''} • ${studentData?['year'] ?? ''}',
  style: GoogleFonts.inter(
    color: Colors.grey[700],
    fontSize: 13,
  ),
),


              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Student Portal',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }




  // ---------------- STATS ----------------
  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _infoCard('CGPA', studentData?['cgpa']?.toString() ?? '--',
          Icons.school_outlined,
              Colors.blue.shade50, Colors.blueAccent),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _infoCard('Attendance', '${studentData?['attendance'] ?? '--'}%',
          Icons.check_circle_outline,
              Colors.green.shade50, Colors.green),
        ),
      ],
    );
  }




  Widget _infoCard(String title, String value, IconData icon, Color bgColor, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 8),
          Text(value, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(title, style: GoogleFonts.inter(color: Colors.grey[700], fontSize: 13)),
        ],
      ),
    );
  }

  // ---------------- QUICK ACTIONS ----------------
  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),




        // Row 1
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StudentNotesScreen())),
                child: _actionCard(Icons.note_alt_outlined, 'Notes'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StudentEventsScreen())),
                child: _actionCard(Icons.event_outlined, 'Events'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StudentNotificationsScreen())),
                child: _actionCard(Icons.notifications_outlined, 'Notifications'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),




        // Row 2
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StudentMarksScreen())),
                child: _actionCard(Icons.bar_chart_outlined, 'Marks'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: GestureDetector(
                onTap: () => _showLeaveManagementDialog(context),
                child: _actionCard(Icons.send_outlined, 'Request Leave'),
              ),
            ),
          ],
        ),
      ],
    );
  }




  // ---------------- ACTION CARD (Fixed) ----------------
  Widget _actionCard(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.deepPurple, size: 26),
          const SizedBox(height: 6),
          Text(title, style: GoogleFonts.inter(fontSize: 13, color: Colors.black87)),
        ],
      ),
    );
  }




  // ---------------- ACADEMIC SCHEDULE ----------------
  Widget _buildAcademicSchedule(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Academic Schedule', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => _showTimetableDialog(context),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(Icons.calendar_today_outlined, size: 28, color: Colors.blueAccent),
                const SizedBox(height: 8),
                Text('View Timetable',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15)),
                Text('Check your class and exam schedules',
                    style: GoogleFonts.inter(color: Colors.grey[700], fontSize: 13)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ---------------- TIMETABLE POPUP ----------------
  void _showTimetableDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        insetPadding: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min, // ✅ IMPORTANT
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select Timetable Type",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: Colors.black54),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                "Choose the timetable you want to view",
                style: GoogleFonts.inter(
                  color: Colors.grey[600],
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 20),

              _timetableOption(
                context,
                icon: Icons.calendar_today_outlined,
                title: "Class Timetable",
                subtitle: "View your regular class schedule",
                color: Colors.blueAccent,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const StudentClassTimetableScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 12),

              _timetableOption(
                context,
                icon: Icons.assignment_outlined,
                title: "Exam Timetable",
                subtitle: "View examination schedule",
                color: Colors.purpleAccent,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const StudentExamTimetableScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}


  Widget _timetableOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14.5)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: GoogleFonts.inter(color: Colors.grey[700], fontSize: 12.5)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Colors.grey),
          ],
        ),
      ),
    );
  }
// ---------------- LEAVE MANAGEMENT POPUP ----------------
void _showLeaveManagementDialog(BuildContext context) {

  final TextEditingController reasonController = TextEditingController();
  String? selectedLeaveType;
  final leaveTypes = ["Medical","On Duty (OD)", "Emergency","others"];
  int selectedTab = 0;

  
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.all(20),
        child: StatefulBuilder(
          builder: (context, seState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Leave Management",
                        style: GoogleFonts.inter(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close, color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text("Submit new request or view request status",
                      style: GoogleFonts.inter(
                          color: Colors.grey[600], fontSize: 13)),
                  const SizedBox(height: 16),

                  // Tabs
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
  if (selectedTab == 0) return;

  seState(() {
    selectedTab = 0;
  });
},




                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: selectedTab == 0
                                    ? Colors.white
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: selectedTab == 0
                                    ? [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 3,
                                          offset: const Offset(0, 1),
                                        )
                                      ]
                                    : [],
                              ),
                              alignment: Alignment.center,
                              child: Text("New Request",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    color: selectedTab == 0
                                        ? Colors.black
                                        : Colors.grey[700],
                                  )),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
  onTap: () async {
  if (selectedTab == 1) return;

  seState(() {
    selectedTab = 1;
    leaveLoading = true;
  });

  try {
    await loadLeaveRequests(() => seState(() {}));
  } catch (e) {
    seState(() {
      leaveLoading = false;
    });
  }
},
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: selectedTab == 1
                                    ? Colors.white
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: selectedTab == 1
                                    ? [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 3,
                                          offset: const Offset(0, 1),
                                        )
                                      ]
                                    : [],
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Request Status",
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        color: selectedTab == 1
                                            ? Colors.black
                                            : Colors.grey[700],
                                      )),
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                        leaveRequests.length.toString(),
                                        style: GoogleFonts.inter(
                                            color: Colors.white, fontSize: 11)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),




                  // Tab Views
                  if (selectedTab == 0) ...[
                    _infoRow("Name", studentData?['name'] ?? ''),
                    _infoRow("Roll Number", studentData?['rollNo'] ?? ''),
                    _infoRow("Department", studentData?['department'] ?? ''),
                    _infoRow("Year", studentData?['year'] ?? ''),
                    const SizedBox(height: 10),




                    // Leave type
                    Text("Leave Type",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600, fontSize: 13)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: const SizedBox(),
                        value: selectedLeaveType,
                        hint: Text("Select leave type",
                            style:
                                GoogleFonts.inter(color: Colors.grey[700])),
                        items: leaveTypes
                            .map((type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(type,
                                      style: GoogleFonts.inter()),
                                ))
                            .toList(),
                        onChanged: (value) =>
                        seState(() => selectedLeaveType = value),

                      ),
                    ),
                    const SizedBox(height: 12),




                    // Reason
                    Text("Reason for Leave",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600, fontSize: 13)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: reasonController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText:
                            "Please provide the reason for your leave request...& from date to date leave required",
                        hintStyle:
                            GoogleFonts.inter(color: Colors.grey[600]),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),




                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey.shade400),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12),
                            ),
                            child: Text("Cancel",
                                style: GoogleFonts.inter(
                                    color: Colors.black87)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
  onPressed: () async {
  if (selectedLeaveType == null || reasonController.text.trim().isEmpty) {
  showTopPopup(
  message: "Please select leave type and enter reason",
  backgroundColor: Colors.red.shade700,
  icon: Icons.warning_amber_rounded,
);

  return;
}


  try {
    await FirebaseFirestore.instance.collection('leave_requests').add({
      'studentId': FirebaseAuth.instance.currentUser!.uid,
      'type': selectedLeaveType,
      'reason': reasonController.text.trim(),
      'date': Timestamp.now(),
      'approvers': ['Class Incharge Staff', 'HOD'],
      'status': ['pending', 'pending'],
    });

    if (!mounted) return;

    Navigator.pop(context);

    showTopPopup(
  message: "Leave request submitted successfully!",
  backgroundColor: Colors.green,
  icon: Icons.check_circle,
);
  } catch (e) {
    showTopPopup(
  message: "Error: $e",
  backgroundColor: Colors.red.shade700,
  icon: Icons.error,
);
  }
},

  icon: const Icon(Icons.send_outlined, size: 18, color: Colors.white),
  label: Text(
    "Submit Request",
    style: GoogleFonts.inter(
      fontWeight: FontWeight.w600,
      color: Colors.white, // ✅ ensures text is visible
    ),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
  foregroundColor: Colors.white, // ensures icon + text are white
    padding: const EdgeInsets.symmetric(vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    elevation: 0, // optional: makes it flat and clean
   ),
                          ),
                        ),
                      ],
                    ),
                  ]
                  else ...[
  if (leaveLoading)
    const CircularProgressIndicator(),

  if (!leaveLoading && leaveRequests.isEmpty)
    Text(
      "No leave requests found",
      style: GoogleFonts.inter(color: Colors.grey[600]),
    ),

  if (!leaveLoading && leaveRequests.isNotEmpty)
    Column(
      children: leaveRequests.map((d) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _leaveCard(
            d['type'],
            d['reason'],
            d['date'].toDate().toString().split(' ')[0],
            List<String>.from(d['approvers']),
            List<String>.from(d['status']),
          ),
        );
      }).toList(),
    ),
]


                ],
              ),
            );
          },
        ),
      );
    },
  );
}

// helper for student info rows
Widget _infoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(label,
              style: GoogleFonts.inter(
                  color: Colors.grey[700], fontWeight: FontWeight.w600)),
        ),
        Expanded(
          flex: 3,
          child: Text(value,
              style: GoogleFonts.inter(
                  color: Colors.black87, fontSize: 13.5)),
        ),
      ],
    ),
  );
}

// helper for leave cards
Widget _leaveCard(String type, String reason, String date,
    List<String> approvers, List<String> statusList) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(type,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600, fontSize: 14.5)),
            _statusChip(statusList.last),
          ],
        ),
        const SizedBox(height: 4),
        Text(reason,
            style: GoogleFonts.inter(color: Colors.grey[700], fontSize: 13)),
        const SizedBox(height: 4),
        Text("Submitted: $date",
            style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 12)),
        const Divider(height: 20),
        Column(
          children: List.generate(approvers.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Icon(
                    statusList[index] == "approved"
                        ? Icons.check_circle
                        : Icons.hourglass_bottom,
                    size: 18,
                    color: statusList[index] == "approved"
                        ? Colors.green
                        : Colors.orangeAccent,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(approvers[index],
                        style: GoogleFonts.inter(fontSize: 13.5)),
                  ),
                  _statusChip(statusList[index]),
                ],
              ),
            );
          }),
        ),
      ],
    ),
  );
}




Widget _statusChip(String status) {
  final isApproved = status == "approved";
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: isApproved
          ? Colors.green.withOpacity(0.1)
          : Colors.orange.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      status,
      style: GoogleFonts.inter(
        color: isApproved ? Colors.green : Colors.orange,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}








 // ---------------- RECENT UPDATES ----------------
Widget _buildRecentUpdates() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Recent Updates',
        style: GoogleFonts.inter(
            fontSize: 16, fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 12),

      if (recentUpdates.isEmpty)
        Text(
          "No recent updates",
          style: GoogleFonts.inter(color: Colors.grey[600]),
        ),

      if (recentUpdates.isNotEmpty)
        Column(
          children: recentUpdates.map((d) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _updateTile(
                Icons.info_outline,
                d['title'],
                d['message'],
              ),
            );
          }).toList(),
        ),
    ],
  );
}

void showTopPopup({
  required String message,
  Color backgroundColor = Colors.black,
  IconData icon = Icons.info_outline,
}) {
  final overlay = Overlay.of(context);
  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top + 20,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}


  }




  Widget _updateTile(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.redAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 4),
                Text(subtitle, style: GoogleFonts.inter(color: Colors.grey[700], fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
 