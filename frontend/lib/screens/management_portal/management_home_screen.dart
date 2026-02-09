import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'management_attendance_screen.dart';
import 'management_announcement_screen.dart';
import 'management_approve_requests_screen.dart';
import 'manage_users_screen.dart';


class ManagementHomeScreen extends StatelessWidget {
  const ManagementHomeScreen({super.key});

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

// ================= HEADER  =================
Row(
  children: [
    Container(
      height: 34,
      width: 34,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: Text(
        'SLEC',
        style: GoogleFonts.inter(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    ),
    const SizedBox(width: 10),

    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Management Portal',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          'St. Lourdes Engineering College',
          style: GoogleFonts.inter(
            color: Colors.grey[600],
            fontSize: 13,
          ),
        ),
      ],
    ),

    const Spacer(),

    IconButton(
      icon: const Icon(Icons.notifications_outlined),
      onPressed: () {},
    ),
  ],
),


              // ================= TITLE =================
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Management",
                          style: GoogleFonts.inter(
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      Text("Dashboard",
                          style: GoogleFonts.inter(
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text("ST. Lourdes Engineering College",
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

              // ================= WARNING =================
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber, color: Colors.orange),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "View-Only Mode: You can monitor all activities but cannot make changes",
                        style: GoogleFonts.inter(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // ================= OVERVIEW =================
              Row(
                children: [
                  Text("Overview Statistics",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text("LIVE DATA",
                        style: GoogleFonts.inter(
                            color: Colors.white, fontSize: 10)),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.9,
                children: const [
                  _StatCard("3247", "TOTAL STUDENTS", Icons.school),
                  _StatCard("156", "TEACHING STAFF", Icons.person),
                  _StatCard("42", "NON-TEACHING", Icons.groups),
                  _StatCard("12", "DEPARTMENTS", Icons.apartment),
                ],
              ),

              const SizedBox(height: 24),

              // ================= QUICK ACTIONS =================
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [
                        const Icon(Icons.flash_on, size: 18),
                        const SizedBox(width: 6),
                        Text("QUICK ACTIONS",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600)),
                      ],
                    ),

                    const SizedBox(height: 14),

                  GridView.count(
  crossAxisCount: 2,
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  crossAxisSpacing: 12,
  mainAxisSpacing: 12,
  childAspectRatio: 1.9,
  children: [

    _ActionCard(
      "ATTENDANCE",
      Icons.check_circle,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ManagementAttendanceScreen(),
          ),
        );
      },
    ),

   _ActionCard(
  "ANNOUNCE",
  Icons.campaign,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ManagementAnnouncementScreen(),
      ),
    );
  },
),


  _ActionCard(
  "REQUESTS",
  Icons.description,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ManagementApproveRequestsScreen(),
      ),
    );
  },
),


    _ActionCard(
      "USERS",
      Icons.people,
      onTap: () {
        Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const ManageUsersScreen(),
  ),
        );
      },
    ),

  ],
),

                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ================= NOTIFICATIONS =================
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [
                        const Icon(Icons.notifications_none),
                        const SizedBox(width: 6),
                        Text("Notifications",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600)),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text("5"),
                        )
                      ],
                    ),

                    const SizedBox(height: 14),

                    const _NotificationCard(
                      title: "23 pending approval requests",
                      subtitle:
                          "Leave applications, purchase requests, and event approvals are awaiting your review.",
                      time: "10 mins ago",
                      dotColor: Colors.orange,
                    ),

                    const _NotificationCard(
                      title: "HOD Meeting at 3:00 PM today",
                      subtitle:
                          "Monthly review meeting with all department heads in the conference room.",
                      time: "30 mins ago",
                      dotColor: Colors.black,
                    ),

                    const _NotificationCard(
                      title: "System maintenance scheduled tomorrow",
                      subtitle:
                          "The admin portal will be under maintenance from 2 AM to 4 AM.",
                      time: "2 hours ago",
                      dotColor: Colors.black,
                    ),
                    _NotificationCard(
  title: "New admission applications received",
  subtitle:
      "45 new applications for the upcoming semester.",
  time: "4 hours ago",
  dotColor: Colors.black,
),

_NotificationCard(
  title: "Feedback responses pending review",
  subtitle:
      "Student feedback for 3rd Year needs your attention.",
  time: "5 hours ago",
  dotColor: Colors.orange,
),

const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =================================================
// STAT CARD
// =================================================
class _StatCard extends StatelessWidget {
  final String value;
  final String title;
  final IconData icon;

  const _StatCard(this.value, this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(height: 10),
          Text(value,
              style: GoogleFonts.inter(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(title,
              style: GoogleFonts.inter(
                  fontSize: 11, color: Colors.grey)),
        ],
      ),
    );
  }
}

// =================================================
// ACTION CARD
// =================================================
class _ActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionCard(
    this.title,
    this.icon, {
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon),
              const SizedBox(height: 6),
              Text(title,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}


// =================================================
// NOTIFICATION CARD
// =================================================
class _NotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final Color dotColor;

  const _NotificationCard({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(title,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600)),

                const SizedBox(height: 4),

                Text(subtitle,
                    style: GoogleFonts.inter(
                        fontSize: 12, color: Colors.grey)),

                const SizedBox(height: 6),

                Row(
                  children: [
                    const Icon(Icons.access_time,
                        size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(time,
                        style: GoogleFonts.inter(
                            fontSize: 11, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          CircleAvatar(radius: 4, backgroundColor: dotColor),
        ],
      ),
    );
  }
}
