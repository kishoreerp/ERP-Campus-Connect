import 'package:flutter/material.dart';

class StudentPendingApprovalScreen extends StatelessWidget {
  const StudentPendingApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pending Approval - Student"),
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _card(
              name: "Prof. David Lee",
              type: "Leave Request",
              reason: "Sick Leave",
              date: "2024-01-20",
              days: "2",
            ),
            const SizedBox(height: 12),
            _card(
              name: "Dr. Lisa Wong",
              type: "OD Request",
              reason: "Conference attendance",
              date: "2024-01-22",
              days: "3",
            ),
          ],
        ),
      ),
    );
  }

  Widget _card({
    required String name,
    required String type,
    required String reason,
    required String date,
    required String days,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text("Type: $type"),
          Text("Reason: $reason"),
          Text("Date: $date"),
          Text("Days: $days"),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.check),
                  label: const Text("Approve"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.close, color: Colors.red),
                  label: const Text("Reject",
                      style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
