import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateTimetableEntrySheet extends StatelessWidget {
  const CreateTimetableEntrySheet({super.key});

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
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 16),

          /// DAY
          _label('Day'),
          _dropdown(hint: 'Monday'),

          const SizedBox(height: 12),

          /// TIME SLOT
          _label('Time Slot'),
          _dropdown(hint: '09:00 - 10:00'),

          const SizedBox(height: 12),

          /// SUBJECT
          _label('Subject'),
          _textField(hint: 'Enter subject name'),

          const SizedBox(height: 12),

          /// FACULTY
          _label('Faculty'),
          _dropdown(hint: 'Select faculty'),

          const SizedBox(height: 12),

          /// ROOM
          _label('Room'),
          _dropdown(hint: 'Select room'),

          const SizedBox(height: 20),

          /// CREATE BUTTON
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
                // TODO: Save timetable entry
              },
              child: Text(
                'Create Entry',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

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

  /// SMALL HELPERS (UI ONLY)

  Widget _label(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _textField({required String hint}) {
    return TextField(
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

  Widget _dropdown({required String hint}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: null,
          hint: Text(hint),
          isExpanded: true,
          items: const [],
          onChanged: (value) {},
        ),
      ),
    );
  }
}
