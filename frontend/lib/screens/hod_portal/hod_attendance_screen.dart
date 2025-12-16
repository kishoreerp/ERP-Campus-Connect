import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class HODAttendanceScreen extends StatelessWidget {
  const HODAttendanceScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        "title": "Mark Attendance",
        "subtitle": "Mark attendance for your subjects",
        "icon": Icons.check_circle_outline,
        "iconBg": const Color(0xFFE8F2FF),
        "iconColor": Colors.blueAccent,
      },
      {
        "title": "View Attendance",
        "subtitle": "View department student attendance",
        "icon": Icons.remove_red_eye_outlined,
        "iconBg": const Color(0xFFE8FFF0),
        "iconColor": Colors.green,
      },
      {
        "title": "Staff Attendance",
        "subtitle": "View department faculty attendance",
        "icon": Icons.group_outlined,
        "iconBg": const Color(0xFFF6E8FF),
        "iconColor": Colors.purpleAccent,
      },
    ];


    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            //---------------- HEADER ----------------//
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.maybePop(context),
                    borderRadius: BorderRadius.circular(24),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(Icons.arrow_back, color: Colors.black87),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Attendance Management",
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Choose an option to manage attendance",
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),


            const SizedBox(height: 8),


            //---------------- LIST ITEMS ----------------//
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = items[index];


                  return InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {
                      // TODO: Add navigation
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.grey.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Icon Box
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: item["iconBg"],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              item["icon"],
                              color: item["iconColor"],
                              size: 26,
                            ),
                          ),


                          const SizedBox(width: 12),


                          // Title + Subtitle
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item["title"],
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item["subtitle"],
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),


                          // Arrow
                          Icon(Icons.chevron_right, color: Colors.grey.shade400),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}





