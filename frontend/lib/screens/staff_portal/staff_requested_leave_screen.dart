  import 'package:flutter/material.dart';
  import 'package:google_fonts/google_fonts.dart';


  class RequestedLeaveScreen extends StatelessWidget {
    const RequestedLeaveScreen({Key? key}) : super(key: key);


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const BackButton(color: Colors.black),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Staff Portal",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              Text(
                "Computer Science",
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),


        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Requested Leave",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),


              _leaveCard(
                title: "Sick Leave",
                appliedOn: "10/1/2024",
                from: "15/1/2024",
                to: "17/1/2024",
                reason: "Medical treatment",
                status: "Approved",
                statusColor: Colors.green,
              ),


              _leaveCard(
                title: "Casual Leave",
                appliedOn: "1/2/2024",
                from: "5/2/2024",
                to: "6/2/2024",
                reason: "Personal work",
                status: "Pending",
                statusColor: Colors.grey.shade400,
              ),


              _leaveCard(
                title: "Earned Leave",
                appliedOn: "15/12/2023",
                from: "20/12/2023",
                to: "22/12/2023",
                reason: "Family function",
                status: "Rejected",
                statusColor: Colors.red,
                rejectionReason: "End semester exams scheduled",
              ),
            ],
          ),
        ),
      );
    }


    Widget _leaveCard({
      required String title,
      required String appliedOn,
      required String from,
      required String to,
      required String reason,
      required String status,
      required Color statusColor,
      String? rejectionReason,
    }) {
      return Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),


            const SizedBox(height: 4),
            Text(
              "Applied on $appliedOn",
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),


            const SizedBox(height: 10),
            _row("From", from),
            _row("To", to),


            const Divider(height: 20),


            const Text(
              "Reason:",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 2),
            Text(
              reason,
              style: const TextStyle(fontSize: 13),
            ),


            if (rejectionReason != null) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Rejection Reason:",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      rejectionReason,
                      style: const TextStyle(fontSize: 12, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      );
    }


    Widget _row(String label, String value) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          children: [
            Icon(Icons.calendar_today_outlined,
                size: 14, color: Colors.grey.shade600),
            const SizedBox(width: 6),
            Text(
              "$label : ",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      );
    }
  }





