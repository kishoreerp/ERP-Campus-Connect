import 'package:flutter/material.dart';

class ExamDetailsDialog extends StatelessWidget {
  const ExamDetailsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ---------- HEADER ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Exam Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Text(
              'View the details of the selected exam.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            _row('Subject', 'Data Structures'),
            _row('Exam Type', 'midterm'),
            _row('Date', '2024-01-25'),
            _row('Time', '09:00-12:00'),
            _row('Room/Hall', 'Hall A'),
            _row('Duration (minutes)', '180'),
            _row('Supervising Faculty', 'Dr. Sarah Johnson'),
            _row('Number of Students', '45'),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
