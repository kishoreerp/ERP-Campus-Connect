import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateTimetableEntrySheet extends StatefulWidget {
  const CreateTimetableEntrySheet({super.key});

  @override
  State<CreateTimetableEntrySheet> createState() =>
      _CreateTimetableEntrySheetState();
}

class _CreateTimetableEntrySheetState
    extends State<CreateTimetableEntrySheet> {
  String? selectedDay;
  String? selectedTime;
  String? selectedFaculty;


  final subjectController = TextEditingController();

  final days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  final times = [
    '09:00 - 09:50',
    '09:50 - 10:40',
    '10:55 - 11:45',
    '11:45 - 12:35',
  ];

  final faculties = [
    'Dr. Rajesh Kumar',
    'Dr. Arun Sharma',
    'Prof. Kavitha Reddy',
    'Dr. Suresh Patel',
  ];



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Create New Timetable Entry',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),

          const SizedBox(height: 4),
          Text(
            'Add a new class to the timetable',
            style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
          ),

          const SizedBox(height: 16),

          _label('Day'),
          _dropdown(
            value: selectedDay,
            hint: 'Select day',
            items: days,
            onChanged: (v) => setState(() => selectedDay = v),
          ),

          const SizedBox(height: 12),

          _label('Time Slot'),
          _dropdown(
            value: selectedTime,
            hint: 'Select time slot',
            items: times,
            onChanged: (v) => setState(() => selectedTime = v),
          ),

          const SizedBox(height: 12),

          _label('Subject'),
          _textField(hint: 'Enter subject name'),

          const SizedBox(height: 12),

          _label('Faculty'),
          _dropdown(
            value: selectedFaculty,
            hint: 'Select faculty',
            items: faculties,
            onChanged: (v) => setState(() => selectedFaculty = v),
          ),

          const SizedBox(height: 12),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Create Entry',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

          const SizedBox(height: 8),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) => Text(
        text,
        style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
      );

  Widget _textField({required String hint}) => TextField(
        controller: subjectController,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      );

  Widget _dropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            hint: Text(hint),
            isExpanded: true,
            items: items
                .map(
                  (e) => DropdownMenuItem(value: e, child: Text(e)),
                )
                .toList(),
            onChanged: onChanged,
          ),
        ),
      );
}
