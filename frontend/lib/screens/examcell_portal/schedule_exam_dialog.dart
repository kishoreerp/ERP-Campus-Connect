import 'package:flutter/material.dart';

class ScheduleExamDialog extends StatefulWidget {
  const ScheduleExamDialog({super.key});

  @override
  State<ScheduleExamDialog> createState() => _ScheduleExamDialogState();
}

class _ScheduleExamDialogState extends State<ScheduleExamDialog> {
  String? selectedExamType;
  String? selectedFaculty;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
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
                  'Schedule New Exam',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Text(
              'Create a new exam session with date, time, and venue details.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // ---------- FORM ----------
            _input('Subject', 'Enter subject name'),
            _dropdown('Exam Type'),
            _rowInputs(
              _input('Date', 'dd-mm-yyyy'),
              _input('Time', 'e.g. 09:00-12:00'),
            ),
            _rowInputs(
              _input('Room/Hall', 'Enter venue'),
              _input('Duration (minutes)', '180'),
            ),
            _dropdown('Supervising Faculty'),

            const SizedBox(height: 24),

            // ---------- ACTIONS ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Schedule Exam'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------- INPUT ----------
  Widget _input(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 6),
          TextField(
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- DROPDOWN ----------
  Widget _dropdown(String label) {
    List<String> items = [];

    if (label == 'Exam Type') {
      items = ['Midterm', 'Final', 'Practical', 'Quiz'];
    } else if (label == 'Supervising Faculty') {
      items = [
        'Dr. Sarah Johnson',
        'Prof. David Lee',
        'Dr. Lisa Wong',
        'Mr. James Brown',
      ];
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: label == 'Exam Type'
                ? selectedExamType
                : selectedFaculty,
            hint: const Text('Select'),
            items: items
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                if (label == 'Exam Type') {
                  selectedExamType = value;
                } else {
                  selectedFaculty = value;
                }
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
        ],
      ),
    );
  }

  // ---------- ROW INPUTS ----------
  Widget _rowInputs(Widget left, Widget right) {
    return Row(
      children: [
        Expanded(child: left),
        const SizedBox(width: 12),
        Expanded(child: right),
      ],
    );
  }
}
