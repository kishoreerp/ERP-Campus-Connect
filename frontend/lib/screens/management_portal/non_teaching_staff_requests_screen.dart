import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NonTeachingStaffRequestsScreen extends StatefulWidget {
  const NonTeachingStaffRequestsScreen({super.key});

  @override
  State<NonTeachingStaffRequestsScreen> createState() =>
      _NonTeachingStaffRequestsScreenState();
}

class _NonTeachingStaffRequestsScreenState
    extends State<NonTeachingStaffRequestsScreen> {

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
                      Text("Non-Teaching Staff\nRequests",
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                      Text("7 pending",
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
                        name: "Ramesh Kumar",
                        role: "Senior Administrator",
                        title: "Leave Request",
                        description: "Sick leave",
                        date: "Dec 14, 2025",
                        priority: "medium",
                        priorityColor: Colors.grey,
                      ),

                    // PURCHASE
                    if (selectedTab == "All" || selectedTab == "Purchase")
                      requestCard(
                        icon: Icons.shopping_cart,
                        iconBg: Colors.blue.shade100,
                        name: "Sunita Rao",
                        role: "Office Coordinator",
                        title: "Equipment Request",
                        description:
                            "New desktop computer and printer",
                        amount: "₹75,000",
                        date: "Dec 13, 2025",
                        priority: "medium",
                        priorityColor: Colors.grey,
                      ),

                    // LEAVE
                    if (selectedTab == "All" || selectedTab == "Leave")
                      requestCard(
                        icon: Icons.calendar_month,
                        iconBg: Colors.red.shade100,
                        name: "Prakash Singh",
                        role: "Accounts Officer",
                        title: "Leave Request",
                        description: "Personal leave",
                        date: "Dec 12, 2025",
                        priority: "high",
                        priorityColor: Colors.red,
                      ),

                    // PURCHASE
                    if (selectedTab == "All" || selectedTab == "Purchase")
                      requestCard(
                        icon: Icons.shopping_cart,
                        iconBg: Colors.red.shade100,
                        name: "Vijay Kumar",
                        role: "Senior Lab Technician",
                        title: "Equipment Request",
                        description:
                            "Lab safety equipment and protective gear",
                        amount: "₹45,000",
                        date: "Dec 11, 2025",
                        priority: "high",
                        priorityColor: Colors.red,
                      ),

                    // TRAINING
                    if (selectedTab == "All" || selectedTab == "Training")
                      requestCard(
                        icon: Icons.card_giftcard,
                        iconBg: Colors.blue.shade100,
                        name: "Anand Reddy",
                        role: "Lab Technician",
                        title: "Training Request",
                        description:
                            "Workshop on new lab equipment handling",
                        date: "Dec 10, 2025",
                        priority: "medium",
                        priorityColor: Colors.grey,
                      ),

                    // PURCHASE
                    if (selectedTab == "All" || selectedTab == "Purchase")
                      requestCard(
                        icon: Icons.shopping_cart,
                        iconBg: Colors.blue.shade100,
                        name: "Geetha Menon",
                        role: "Chief Librarian",
                        title: "Purchase Request",
                        description:
                            "New reference books and digital subscriptions",
                        amount: "₹1,20,000",
                        date: "Dec 9, 2025",
                        priority: "medium",
                        priorityColor: Colors.grey,
                      ),

                    // MAINTENANCE (Purchase type)
                    if (selectedTab == "All" || selectedTab == "Purchase")
                      requestCard(
                        icon: Icons.shopping_cart,
                        iconBg: Colors.red.shade100,
                        name: "Nagaraj Gowda",
                        role: "Maintenance Supervisor",
                        title: "Maintenance Request",
                        description:
                            "AC repair and servicing for Block A",
                        amount: "₹85,000",
                        date: "Dec 8, 2025",
                        priority: "high",
                        priorityColor: Colors.red,
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
