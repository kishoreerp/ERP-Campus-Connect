import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'staff_notes_screen.dart';
import 'staff_notes_subject_screen.dart';
import 'staff_events_screen.dart';
import 'staff_notifications_screen.dart';
import 'staff_announcement_screen.dart';
import 'staff_timetable_screen.dart';
import 'staff_request_leave_screen.dart';




class StaffHomeScreen extends StatelessWidget {
  final String username;
  const StaffHomeScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
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
                    'Welcome, ${username.isNotEmpty ? username : 'John Smith'}!',
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
            child: _quickAction(
              context,
              Icons.notifications_outlined,
              'Notifications',
              const StaffNotificationsScreen(), // or null
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
              StaffRequestLeaveScreen(), // or null
            ),
          ),
        ],
      ),
    ],
  );
}


  Widget _quickAction(
  BuildContext context,
  IconData icon,
  String title,
  Widget? screen,
) {
  return InkWell(
    borderRadius: BorderRadius.circular(12),
    onTap: () {
      if (screen != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      }
    },
    child: Container(
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
}


  // ---------------- SCHEDULE ----------------
  Widget _buildSchedule() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Today's Schedule",
            style:
                GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 16)),
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