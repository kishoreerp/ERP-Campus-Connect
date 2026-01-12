import 'package:flutter/material.dart';

class EditExamDialog extends StatefulWidget {
  const EditExamDialog({super.key});

  @override
  State<EditExamDialog> createState() => _EditExamDialogState();
}

class _EditExamDialogState extends State<EditExamDialog> {
  late TextEditingController subjectCtrl;
  late TextEditingController dateCtrl;
  late TextEditingController timeCtrl;
  late TextEditingController hallCtrl;
  late TextEditingController durationCtrl;
  late TextEditingController studentsCtrl;
   String? selectedExamType;
  String? selectedFaculty;

  @override
  void initState() {
    super.initState();
    subjectCtrl = TextEditingController(text: 'Data Structures');
    dateCtrl = TextEditingController(text: '25-01-2024');
    timeCtrl = TextEditingController(text: '09:00-12:00');
    hallCtrl = TextEditingController(text: 'Hall A');
    durationCtrl = TextEditingController(text: '180');
    studentsCtrl = TextEditingController(text: '45');
  }

  @override
  void dispose() {
    subjectCtrl.dispose();
    dateCtrl.dispose();
    timeCtrl.dispose();
    hallCtrl.dispose();
    durationCtrl.dispose();
    studentsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Edit Exam Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Text(
              'Edit the details of the selected exam.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),

            _input('Subject', subjectCtrl),
            _dropdown('Exam Type'),
            _input('Date', dateCtrl),
            _input('Time', timeCtrl),
            _input('Room/Hall', hallCtrl),
            _input('Duration (minutes)', durationCtrl),
            _dropdown('Supervising Faculty'),
            _input('Number of Students', studentsCtrl),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Update Exam'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
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
    padding: const EdgeInsets.only(bottom: 12),
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
}
