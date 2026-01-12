import 'package:flutter/material.dart';

class EditResultDialog extends StatefulWidget {
  const EditResultDialog({super.key});

  @override
  State<EditResultDialog> createState() => _EditResultDialogState();
}

class _EditResultDialogState extends State<EditResultDialog> {
  final TextEditingController scoreController =
      TextEditingController(text: '78');

  String selectedGrade = 'B+';

  final List<String> grades = ['A+', 'A', 'B+', 'B', 'C', 'D', 'F'];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- HEADER ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Edit Result Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Text(
              'Edit the details of the selected result.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),

            _infoRow('Student Name', 'Bob Smith'),
            _infoRow('Student ID', 'CS002'),
            _infoRow('Exam Subject', 'Database Systems'),

            const SizedBox(height: 14),

            // ---------- SCORE ----------
            const Text('Score'),
            const SizedBox(height: 6),
            TextField(
              controller: scoreController,
              keyboardType: TextInputType.number,
              onChanged: _autoUpdateGrade,
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.edit),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 14),

            // ---------- GRADE DROPDOWN ----------
            const Text('Grade'),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: selectedGrade,
              items: grades
                  .map(
                    (g) => DropdownMenuItem(
                      value: g,
                      child: Text(g),
                    ),
                  )
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedGrade = val!;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 14),

            _infoRow('Status', 'PASS'),

            const SizedBox(height: 20),

            // ---------- ACTIONS ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Update Result'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------- AUTO GRADE CALC ----------
  void _autoUpdateGrade(String value) {
    final score = int.tryParse(value) ?? 0;
    setState(() {
      if (score >= 90) {
        selectedGrade = 'A+';
      } else if (score >= 80) {
        selectedGrade = 'A';
      } else if (score >= 70) {
        selectedGrade = 'B+';
      } else if (score >= 60) {
        selectedGrade = 'B';
      } else if (score >= 50) {
        selectedGrade = 'C';
      } else {
        selectedGrade = 'F';
      }
    });
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(value),
        ],
      ),
    );
  }
}
