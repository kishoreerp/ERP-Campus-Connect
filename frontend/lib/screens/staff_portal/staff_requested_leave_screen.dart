import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StaffRequestedLeaveScreen extends StatelessWidget {
  const StaffRequestedLeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Requested Leave'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _LeaveCard(
            type: 'Sick Leave',
            status: 'Approved',
            statusColor: Colors.green,
            from: '15/1/2024',
            to: '17/1/2024',
            reason: 'Medical treatment',
          ),
          _LeaveCard(
            type: 'Casual Leave',
            status: 'Pending',
            statusColor: Colors.orange,
            from: '5/2/2024',
            to: '6/2/2024',
            reason: 'Personal work',
          ),
          _LeaveCard(
            type: 'Earned Leave',
            status: 'Rejected',
            statusColor: Colors.red,
            from: '20/12/2023',
            to: '22/12/2023',
            reason: 'Family function',
            rejection: 'End semester exams scheduled',
          ),
        ],
      ),
    );
  }
}

class _LeaveCard extends StatelessWidget {
  final String type;
  final String status;
  final Color statusColor;
  final String from;
  final String to;
  final String reason;
  final String? rejection;

  const _LeaveCard({
    required this.type,
    required this.status,
    required this.statusColor,
    required this.from,
    required this.to,
    required this.reason,
    this.rejection,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(type,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600)),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.inter(
                      fontSize: 12, color: statusColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('From: $from'),
          Text('To: $to'),
          const SizedBox(height: 6),
          Text('Reason: $reason'),
          if (rejection != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Rejection Reason: $rejection',
                style: GoogleFonts.inter(
                    fontSize: 12, color: Colors.red),
              ),
            )
          ]
        ],
      ),
    );
  }
}
