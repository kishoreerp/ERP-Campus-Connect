import 'package:flutter/material.dart';

class StudentApprovedScreen extends StatelessWidget {
  const StudentApprovedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Approved - Student"),
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Dr. John Smith",
                  style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(height: 8),
              Text("Type: Leave Request"),
              Text("Reason: Annual Leave"),
              Text("Date: 2024-01-25"),
              Text("Days: 5"),
            ],
          ),
        ),
      ),
    );
  }
}
