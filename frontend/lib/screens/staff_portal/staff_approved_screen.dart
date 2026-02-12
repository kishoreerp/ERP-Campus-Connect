import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class StaffApprovedScreen extends StatelessWidget {
  const StaffApprovedScreen({super.key});


  @override
  Widget build(BuildContext context) {


    final approvedList = [
      {
        "name": "Dr. John Smith",
        "department": "Computer Science",
        "type": "Leave Request",
        "reason": "Annual Leave",
        "date": "2024-01-25",
        "days": "5",
      },
      {
        "name": "Dr. Emily Brown",
        "department": "Information Technology",
        "type": "OD Request",
        "reason": "Workshop Attendance",
        "date": "2024-02-02",
        "days": "2",
      },
      {
        "name": "Prof. Michael Lee",
        "department": "Electronics",
        "type": "Leave Request",
        "reason": "Medical Leave",
        "date": "2024-02-10",
        "days": "3",
      },
    ];


    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),


      // ---------------- APP BAR ----------------
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Approved - Student",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              "Review and manage requests",
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),


      // ---------------- BODY ----------------
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: approvedList.length,
        itemBuilder: (context, index) {
          final data = approvedList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _approvedCard(data),
          );
        },
      ),
    );
  }


  // ---------------- APPROVED CARD ----------------
  static Widget _approvedCard(Map<String, String> data) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [


          // Top Row
          Row(
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFFE8F0FE),
                child: Icon(Icons.person_outline,
                    color: Colors.blue, size: 22),
              ),
              const SizedBox(width: 12),


              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data["name"]!,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      data["department"]!,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),


              // Approved Badge
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Approved",
                  style: GoogleFonts.inter(
                    color: Colors.green,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),


          const SizedBox(height: 16),


          // Grey Detail Box
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _detailRow("Type:", data["type"]!),
                const SizedBox(height: 8),
                _detailRow("Reason:", data["reason"]!),
                const SizedBox(height: 8),
                _detailRow("Date:", data["date"]!),
                const SizedBox(height: 8),
                _detailRow("Days:", data["days"]!),
              ],
            ),
          ),
        ],
      ),
    );
  }


  // ---------------- DETAIL ROW ----------------
  static Widget _detailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}





