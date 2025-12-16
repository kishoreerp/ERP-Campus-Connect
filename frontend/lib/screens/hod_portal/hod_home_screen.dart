import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class HODHomeScreen extends StatelessWidget {
  final String username;
  const HODHomeScreen({super.key, required this.username});


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
              _buildWelcomeCard(),
              const SizedBox(height: 24),
              Text(
                "Quick Actions",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 14),
              _buildQuickActions(),
              const SizedBox(height: 24),
              Text(
                "Recent Announcements",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 14),
              _buildAnnouncementCard(
                "Department Meeting",
                "HOD meeting with all faculty on Friday at 3 PM",
                "2024-01-14",
              ),
              _buildAnnouncementCard(
                "Exam Schedule",
                "Mid-term exam schedule has been published",
                "2024-01-13",
              ),
              _buildAnnouncementCard(
                "Faculty Workshop",
                "Faculty development workshop next week",
                "2024-01-12",
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildWelcomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF7B61FF), Color(0xFF9D85FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white24,
                child: Icon(Icons.person_outline, color: Colors.white, size: 36),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome, Dr. Sarah Johnson!",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "HOD12345 • Head of Department",
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildQuickActions() {
    final actions = [
      {"icon": Icons.announcement_outlined, "label": "Announcements"},
      {"icon": Icons.event_outlined, "label": "Events"},
      {"icon": Icons.notifications_outlined, "label": "Notifications"},
      {"icon": Icons.note_alt_outlined, "label": "Notes"},
      {"icon": Icons.approval_outlined, "label": "Approvals"},
      {"icon": Icons.time_to_leave_outlined, "label": "Request Leave"},
    ];


    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final item = actions[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item["icon"] as IconData, color: Colors.black87, size: 26),
              const SizedBox(height: 8),
              Text(
                item["label"].toString(),
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(fontSize: 13),
              ),
            ],
          ),
        );
      },
    );
  }


  Widget _buildAnnouncementCard(String title, String subtitle, String date) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.campaign_outlined,
              color: Colors.purpleAccent, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600, fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: GoogleFonts.inter(
                        color: Colors.grey[700], fontSize: 13)),
                const SizedBox(height: 6),
                Text(
                  date,
                  style: GoogleFonts.inter(
                    color: Colors.grey[500],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



