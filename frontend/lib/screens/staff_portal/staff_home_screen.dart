import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/screens/hod_portal/leave_dialogs.dart';
import 'staff_notes_screen.dart';

import 'staff_events_screen.dart';
import 'staff_notifications_screen.dart';
import 'staff_announcement_screen.dart';
import 'staff_timetable_screen.dart';
import 'staff_leave_dialog.dart'hide showLeaveRequestDialog;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'staff_approved_screen.dart';
  import 'staff_pending_approval_screen.dart';



class StaffHomeScreen extends StatefulWidget {
  final String username;

  const StaffHomeScreen({
    super.key,
    required this.username,
  });

  @override
  State<StaffHomeScreen> createState() => _StaffHomeScreenState();
}
class _StaffHomeScreenState extends State<StaffHomeScreen> {

  bool isClassIncharge = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkUserRole();
  }

  void _showApprovalPopup() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Text(
                  "Approvals",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "Choose approval type to view",
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 20),

                _approvalOptionTile(
                  icon: Icons.pending_actions_outlined,
                  title: "Pending Approval",
                  subtitle: "Review pending requests",
                  onTap: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const StaffPendingApprovalScreen()),
                    );
                  },
                ),

                const SizedBox(height: 14),

                _approvalOptionTile(
                  icon: Icons.verified_outlined,
                  title: "Approved",
                  subtitle: "View approved requests",
                  onTap: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const StaffApprovedScreen()),
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

  Future<void> _checkUserRole() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists) {
        final role = doc['role'];
        final designation = doc['designation'];

        if (role == 'Staff' &&
            designation.toString().toLowerCase() == 'class incharge') {
          isClassIncharge = true;
        }
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  Widget _approvalOptionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.black),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    if (isLoading) {
  return const Scaffold(
    body: Center(child: CircularProgressIndicator()),
  );
}

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildQuickActions(context),
              const SizedBox(height: 24),
              _buildSchedule(),
              const SizedBox(height: 24),
              _buildRecentUpdates(),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- HEADER ----------------
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        const SizedBox(height: 2),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 26,
                backgroundColor: Colors.white,
                child: Icon(Icons.person_outline,
                    color: Colors.blueAccent, size: 34),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, ${widget.username.isNotEmpty ? widget.username : 'John Smith'}!',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'EMP12345 • Computer Science',
                    style:
                        GoogleFonts.inter(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------- QUICK ACTIONS ----------------
 Widget _buildQuickActions(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Quick Actions',
        style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      const SizedBox(height: 12),

      Row(
        children: [
          Expanded(
            child: _quickAction(
              context,
              Icons.note_alt_outlined,
              'Notes',
              const StaffNotesScreen(),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _quickAction(
              context,
              Icons.event_outlined,
              'Events',
              const StaffEventsScreen(), // or null if not ready
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
  child: isClassIncharge
      ? _quickAction(
  context,
  Icons.approval_outlined,
  'Approval',
  null,
  customOnTap: () {
    _showApprovalPopup();
  },
)
      : _quickAction(
          context,
          Icons.notifications_outlined,
          'Notifications',
          const StaffNotificationsScreen(),
        ),
),

        ],
      ),

      const SizedBox(height: 12),

      Row(
        children: [
          Expanded(
            child: _quickAction(
              context,
              Icons.campaign_outlined,
              'Announcement',
              const StaffAnnouncementScreen(), // or null
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _quickAction(
              context,
              Icons.calendar_month_outlined,
              'Time table',
              const StaffTimeTableScreen(), // or null
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _quickAction(
              context,
              Icons.exit_to_app_outlined,
              'Request Leave',
              null,
              customOnTap: () {
                showLeaveManagementDialog(context);
              },
            ),
          ),
        ],
      ),
      if (isClassIncharge) ...[
  const SizedBox(height: 12),
  _quickAction(
    context,
    Icons.notifications_outlined,
    'Notifications',
    const StaffNotificationsScreen(),
    isFullWidth: true,
  ),
],


    ],
  );
}

Widget _quickAction(
  BuildContext context,
  IconData icon,
  String title,
  Widget? screen, {
  VoidCallback? customOnTap,
  bool isFullWidth = false,
}) {
  Widget tile = InkWell(
    borderRadius: BorderRadius.circular(12),
    onTap: () {
      if (customOnTap != null) {
        customOnTap();
      } else if (screen != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      }
    },
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
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
      child: Column(
        children: [
          Icon(icon, color: Colors.black87, size: 26),
          const SizedBox(height: 6),
          Text(
            title,
            style: GoogleFonts.inter(fontSize: 13, color: Colors.black87),
          ),
        ],
      ),
    ),
  );

  if (isFullWidth) {
    return tile; // no Row, full width
  }

  return Expanded(child: tile);
}
Widget _buildSchedule() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Today's Schedule",
        style: GoogleFonts.inter(
            fontWeight: FontWeight.w600, fontSize: 16),
      ),
      const SizedBox(height: 12),
      const _ScheduleTile(
          title: 'Data Structures',
          subtitle: '09:00 - 10:00 • Lab 301',
          tag: '2nd Year'),
      const _ScheduleTile(
          title: 'Algorithms',
          subtitle: '10:00 - 11:00 • Room 205',
          tag: '3rd Year'),
      const _ScheduleTile(
          title: 'Database Systems',
          subtitle: '11:00 - 12:00 • Lab 302',
          tag: 'Final Year'),
      const _ScheduleTile(
          title: 'Web Development',
          subtitle: '14:00 - 15:00 • Lab 303',
          tag: '1st Year'),
    ],
  );
}

  // ---------------- RECENT UPDATES ----------------
  Widget _buildRecentUpdates() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Updates',
            style:
                GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 16)),
        const SizedBox(height: 12),
        const _UpdateTile(
          icon: Icons.error_outline,
          color: Colors.redAccent,
          title: 'Faculty Meeting',
          subtitle: 'Monthly faculty meeting on Friday at 3 PM',
        ),
        const SizedBox(height: 8),
        const _UpdateTile(
          icon: Icons.schedule_outlined,
          color: Colors.orangeAccent,
          title: 'Exam Schedule',
          subtitle: 'Mid-term exam schedule has been published',
        ),
      ],
    );
  }
}

// ---------------- COMPONENTS ----------------
class _ScheduleTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String tag;
  const _ScheduleTile(
      {required this.title, required this.subtitle, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3))
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade50,
          child: const Icon(Icons.access_time, color: Colors.blue),
        ),
        title: Text(title,
            style:
                GoogleFonts.inter(fontSize: 14.5, fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle,
            style: GoogleFonts.inter(color: Colors.grey[700], fontSize: 13)),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(tag,
              style: GoogleFonts.inter(
                  color: Colors.blueAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}

class _UpdateTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  const _UpdateTile(
      {required this.icon,
      required this.color,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3))
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: GoogleFonts.inter(
                        color: Colors.grey[700], fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}