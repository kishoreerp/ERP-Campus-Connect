import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'management_attendance_screen.dart';
import 'management_announcement_screen.dart';
import 'management_approve_requests_screen.dart';
import 'manage_users_screen.dart';




class ManagementHomeScreen extends StatelessWidget {
 final String username;


  const ManagementHomeScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 250, 250),


      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
 
// ================= HEADER  =================
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [

    const SizedBox(height:2),


    // Your remaining content
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
              const SizedBox(width: 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, "sandhiya"',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'EMP12345 • st.Lourdes engineering',
                    style:
                        GoogleFonts.inter(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
        ),],
      ),      const SizedBox(height: 22),
              // ================= OVERVIEW =================
              Row(
                children: [
                  Text("Overview Statistics",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5, vertical: 2),
                  ),
                ],
              ),


              const SizedBox(height: 10),


              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                 crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2.4,
                children: const [
                  _StatCard("3247", "TOTAL STUDENTS", Icons.school),
                  _StatCard("156", "TEACHING STAFF", Icons.person),
                  _StatCard("42", "NON-TEACHING", Icons.groups),
                  _StatCard("12", "DEPARTMENTS", Icons.apartment),
                ],
              ),


              const SizedBox(height: 10),


              // ================= QUICK ACTIONS =================
            

Text(
  "Quick Actions",
  style: GoogleFonts.inter(
    fontWeight: FontWeight.w600,
    fontSize: 16,
  ),
),

const SizedBox(height: 12),

_buildQuickActions(context),

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
  Widget _buildQuickActions(BuildContext context) {
  return Column(
    children: [

      // First Row
      Row(
        children: [
          Expanded(
            child: _quickAction(
              context,
              Icons.check_circle,
              "Attendance",
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ManagementAttendanceScreen(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _quickAction(
              context,
              Icons.campaign,
              "Announce",
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const ManagementAnnouncementScreen(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _quickAction(
              context,
              Icons.description,
              "Requests",
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const ManagementApproveRequestsScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      const SizedBox(height: 12),

      // Second Row
      Row(
        children: [
          Expanded(
            child: _quickAction(
              context,
              Icons.people,
              "Users",
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ManageUsersScreen(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(child: SizedBox()), // empty space
          const SizedBox(width: 10),
          const Expanded(child: SizedBox()), // empty space
        ],
      ),
    ],
  );
}
Widget _quickAction(
  BuildContext context,
  IconData icon,
  String title,
  VoidCallback onTap,
) {
  return InkWell(
    borderRadius: BorderRadius.circular(12),
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 23, 23, 23).withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black87, size: 26),
          const SizedBox(height: 6),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
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
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
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

