import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StaffApprovedScreen extends StatelessWidget {
  const StaffApprovedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _header(context, "Approved - Staff"),
            const SizedBox(height: 16),
            _card(
              name: "Dr. John Smith",
              reason: "Annual Leave",
              date: "2024-01-25",
              days: "5",
            ),
          ],
        ),
      ),
    );
  }

  Widget _card({
    required String name,
    required String reason,
    required String date,
    required String days,
  }) {
    return Container(
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
