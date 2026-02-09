import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


/// ================= MAKE EVENT =================
void showMakeEventDialog(BuildContext context) {
  _baseDialog(
    context,
    title: "Make Event",
    subtitle: "Create a new department event",
    child: _eventForm(
      buttonText: "Create Event",
      buttonColor: Colors.grey.shade400,
    ),
  );
}


/// ================= MANAGE EVENTS =================
void showManageEventsDialog(BuildContext context) {
  _baseDialog(
    context,
    title: "Manage Events",
    subtitle: "View and edit department events",
    child: Column(
      children: [
        _manageTile(context, "Department Review Meeting", "2024-01-22 • 10:00 AM", "event"),
        _manageTile(context, "Mid-term Exam Starts", "2024-01-25 • Full Day", "exam"),
        _manageTile(context, "Republic Day Holiday", "2024-01-26 • Closed", "holiday"),
        _manageTile(context, "Faculty Evaluation", "2024-02-01 • 2:00 PM", "event"),
      ],
    ),
  );
}


/// ================= EDIT EVENT =================
void showEditEventDialog(BuildContext context) {
  _baseDialog(
    context,
    title: "Edit Event",
    subtitle: "Update event details",
    child: _eventForm(
      buttonText: "Save Changes",
      buttonColor: Colors.black,
    ),
  );
}


/// ================= SHARED UI =================


void _baseDialog(
  BuildContext context, {
  required String title,
  required String subtitle,
  required Widget child,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: GoogleFonts.inter(
                              fontSize: 18, fontWeight: FontWeight.w700)),
                      Text(subtitle,
                          style: GoogleFonts.inter(
                              fontSize: 13, color: Colors.grey)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
            const SizedBox(height: 12),
            child,
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
          ],
        ),
      ),
    ),
  );
}


Widget _eventForm({
  required String buttonText,
  required Color buttonColor,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _label("Event Type"),
      _input("Select event type"),


      _label("Date"),
      _input("dd-mm-yyyy"),


      _label("Time"),
      _input("--:-- --"),


      _label("Location"),
      _input("Event location"),


      _label("Description"),
      _input("Event description (optional)", maxLines: 3),


      const SizedBox(height: 16),


      SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.calendar_today_outlined),
          label: Text(buttonText),
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
    ],
  );
}


Widget _manageTile(
  BuildContext context,
  String title,
  String date,
  String tag,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        Text(date, style: GoogleFonts.inter(fontSize: 12)),
        const SizedBox(height: 6),
        Row(
          children: [
            TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
                showEditEventDialog(context);
              },
              icon: const Icon(Icons.edit_outlined, size: 16),
              label: const Text("Edit"),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () {},
              icon:
                  const Icon(Icons.delete_outline, size: 16, color: Colors.red),
              label:
                  const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        )
      ],
    ),
  );
}


Widget _label(String text) => Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Text(text,
          style:
              GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500)),
    );


Widget _input(String hint, {int maxLines = 1}) {
  return TextField(
    maxLines: maxLines,
    decoration: InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none),
    ),
  );
}



