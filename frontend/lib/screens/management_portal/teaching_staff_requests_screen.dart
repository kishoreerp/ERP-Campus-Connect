import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeachingStaffRequestsScreen extends StatefulWidget {
  const TeachingStaffRequestsScreen({super.key});

  @override
  State<TeachingStaffRequestsScreen> createState() =>
      _TeachingStaffRequestsScreenState();
}

class _TeachingStaffRequestsScreenState
    extends State<TeachingStaffRequestsScreen> {

  String selectedTab = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      body: SafeArea(
        child: Padding(
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

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Teaching Staff\nRequests",
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                      Text("8 pending",
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

              // ================= FILTER TABS =================
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    filterTab("All"),
                    filterTab("Leave"),
                    filterTab("Purchase"),
                    filterTab("Training"),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ================= LIST =================
              Expanded(
                child: ListView(
                  children: [

                    // LEAVE
                    if (selectedTab == "All" || selectedTab == "Leave")
                      requestCard(
                        icon: Icons.calendar_month,
                        iconBg: Colors.blue.shade100,
                        name: "Dr. Rajesh Kumar",
                        role: "Professor & HOD",
                        title: "Leave Request",
                        description:
                            "Medical leave for 2 days (Dec 16-17, 2025)",
                        date: "Dec 14, 2025",
                        priority: "medium",
                        priorityColor: Colors.grey,
                      ),

                    // TRAINING
                    if (selectedTab == "All" || selectedTab == "Training")
                      requestCard(
                        icon: Icons.card_giftcard,
                        iconBg: Colors.red.shade100,
                        name: "Prof. Kavitha Reddy",
                        role: "Assistant Professor",
                        title: "Conference Approval",
                        description:
                            "Permission to attend International AI Conference in Mumbai",
                        date: "Dec 13, 2025",
                        priority: "high",
                        priorityColor: Colors.red,
                      ),

                    // PURCHASE
                    if (selectedTab == "All" || selectedTab == "Purchase")
                      requestCard(
                        icon: Icons.shopping_cart,
                        iconBg: Colors.orange.shade100,
                        name: "Dr. Priya Sharma",
                        role: "Professor & HOD",
                        title: "Purchase Request",
                        description:
                            "New oscilloscopes and signal generators for ECE lab",
                        amount: "₹4,50,000",
                        date: "Dec 12, 2025",
                        priority: "high",
                        priorityColor: Colors.red,
                      ),

                    // LEAVE
                    if (selectedTab == "All" || selectedTab == "Leave")
                      requestCard(
                        icon: Icons.calendar_month,
                        iconBg: Colors.grey.shade200,
                        name: "Dr. Anita Desai",
                        role: "Assistant Professor",
                        title: "Leave Request",
                        description: "Casual leave",
                        date: "Dec 12, 2025",
                        priority: "low",
                        priorityColor: Colors.black,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= FILTER TAB =================
  Widget filterTab(String text) {
    bool active = selectedTab == text;

    return GestureDetector(
      onTap: () {
        setState(() => selectedTab = text);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: active ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            color: active ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  // ================= REQUEST CARD =================
  Widget requestCard({
    required IconData icon,
    required Color iconBg,
    required String name,
    required String role,
    required String title,
    required String description,
    String? amount,
    required String date,
    required String priority,
    required Color priorityColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          CircleAvatar(
            backgroundColor: iconBg,
            child: Icon(icon),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    Expanded(
                      child: Text(name,
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600)),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color:
                            priorityColor.withOpacity(0.15),
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                      child: Text(priority,
                          style: GoogleFonts.inter(
                              fontSize: 11,
                              color: priorityColor)),
                    )
                  ],
                ),

                const SizedBox(height: 2),

                Text(role,
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.grey)),

                const SizedBox(height: 8),

                Text(title,
                    style: GoogleFonts.inter(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500)),

                const SizedBox(height: 4),

                Text(description,
                    style: GoogleFonts.inter(fontSize: 12)),

                if (amount != null) ...[
                  const SizedBox(height: 4),
                  Text(amount,
                      style: GoogleFonts.inter(
                          color: Colors.green,
                          fontWeight: FontWeight.w600)),
                ],

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(Icons.access_time,
                        size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(date,
                        style: GoogleFonts.inter(
                            fontSize: 11,
                            color: Colors.grey)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
