import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'teaching_staff_requests_screen.dart';
import 'non_teaching_staff_requests_screen.dart';

class ManagementApproveRequestsScreen extends StatelessWidget {
  const ManagementApproveRequestsScreen({super.key});

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
                      Text("Approve Requests",
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                      Text("Pending approvals",
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

              const SizedBox(height: 20),

              // ================= TOTAL CARD =================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.orange),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.warning_amber,
                        color: Colors.orange, size: 28),

                    const SizedBox(height: 8),

                    Text("Total Pending Requests",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600)),

                    const SizedBox(height: 6),

                    Text("15",
                        style: GoogleFonts.inter(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange)),

                    const SizedBox(height: 4),

                    Text("Requires your attention",
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.orange)),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ================= TEACHING STAFF =================
            InkWell(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const TeachingStaffRequestsScreen(),
      ),
    );
  },
  child: _requestCard(
    iconColor: Colors.blue,
    title: "Teaching Staff Requests",
    leave: "3",
    purchase: "2",
    training: "2",
    total: "8",
  ),
),

              

              const SizedBox(height: 16),

              // ================= NON TEACHING =================
             InkWell(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const NonTeachingStaffRequestsScreen(),
      ),
    );
  },
  child: _requestCard(
                iconColor: Colors.purple,
                title: "Non-Teaching Staff Requests",
                leave: "2",
                purchase: "4",
                training: "1",
                total: "7",
              ),
             ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= REQUEST CARD =================
  Widget _requestCard({
    required Color iconColor,
    required String title,
    required String leave,
    required String purchase,
    required String training,
    required String total,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [

          Row(
            children: [
              CircleAvatar(
                backgroundColor: iconColor.withOpacity(0.15),
                child: Icon(Icons.person, color: iconColor),
              ),

              const SizedBox(width: 12),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600)),
                  Text("Click to view details",
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.grey)),
                ],
              )
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              _smallBox(leave, "Leave", Colors.blue),
              const SizedBox(width: 10),
              _smallBox(purchase, "Purchase", Colors.green),
              const SizedBox(width: 10),
              _smallBox(training, "Training", Colors.purple),
              const SizedBox(width: 10),
              _smallBox(total, "Total", Colors.orange),
            ],
          )
        ],
      ),
    );
  }

  // ================= SMALL BOX =================
  Widget _smallBox(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color),
        ),
        child: Column(
          children: [
            Text(value,
                style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color)),
            const SizedBox(height: 4),
            Text(label,
                style: GoogleFonts.inter(
                    fontSize: 11,
                    color: color)),
          ],
        ),
      ),
    );
  }
}
