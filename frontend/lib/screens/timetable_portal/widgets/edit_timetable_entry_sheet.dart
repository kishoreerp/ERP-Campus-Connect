import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditTimetableEntrySheet extends StatefulWidget {
  const EditTimetableEntrySheet({super.key});

  @override
  State<EditTimetableEntrySheet> createState() =>
      _EditTimetableEntrySheetState();
}

class _EditTimetableEntrySheetState extends State<EditTimetableEntrySheet> {
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
    return SingleChildScrollView(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Edit Timetable Entry',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Modify existing timetable entry',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// INFO BANNER
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Edit the selected timetable entry',
              style: GoogleFonts.inter(fontSize: 12),
            ),
          ),

          const SizedBox(height: 16),

          /// DAY
          _label('Day'),
          _dropdown(
            value: selectedDay,
            hint: 'Select day',
            items: days,
            onChanged: (v) => setState(() => selectedDay = v),
          ),

          const SizedBox(height: 12),

          /// TIME SLOT
          _label('Time Slot'),
          _dropdown(
            value: selectedTime,
            hint: 'Select time slot',
            items: times,
            onChanged: (v) => setState(() => selectedTime = v),
          ),

          const SizedBox(height: 12),

          /// SUBJECT
          _label('Subject'),
          _textField(hint: 'Enter subject name'),

          const SizedBox(height: 12),

          /// FACULTY
          _label('Faculty'),
          _dropdown(
            value: selectedFaculty,
            hint: 'Select faculty',
            items: faculties,
            onChanged: (v) => setState(() => selectedFaculty = v),
          ),

          const SizedBox(height: 12),


          /// SAVE CHANGES
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // TODO: Save updated entry
                Navigator.pop(context);
              },
              child: Text(
                'Save Changes',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          /// DELETE
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // TODO: Delete entry
                Navigator.pop(context);
              },
              icon: const Icon(Icons.delete, color: Colors.white),
              label: Text(
                'Delete',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          /// CANCEL
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ---------- UI HELPERS ----------

  Widget _label(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
    );
  }

  Widget _textField({required String hint}) {
    return TextField(
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
  }

  Widget _dropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
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
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
