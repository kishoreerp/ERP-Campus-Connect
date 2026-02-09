import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StaffPendingScreen extends StatelessWidget {
  const StaffPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _header(context, "Pending Approval - Staff"),
            const SizedBox(height: 16),
            _requestCard(
              name: "Prof. David Lee",
              reason: "Sick Leave",
              date: "2024-01-20",
              days: "2",
            ),
            _requestCard(
              name: "Dr. Lisa Wong",
              reason: "Conference attendance",
              date: "2024-01-22",
              days: "3",
            ),
          ],
        ),
      ),
    );
  }

  Widget _requestCard({
    required String name,
    required String reason,
    required String date,
    required String days,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text("Reason: $reason"),
          Text("Date: $date"),
          Text("Days: $days"),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {},
                  child: const Text("Approve"),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text("Reject",
                      style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _header(BuildContext context, String title) {
    return Row(
      children: [
        IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
        Text(title,
            style:
                GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
