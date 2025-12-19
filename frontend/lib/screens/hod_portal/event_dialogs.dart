import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';




/* ================= MAKE EVENT POPUP ================= */


Future<void> showMakeEventDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => _MakeEventDialog(),
  );
}


class _MakeEventDialog extends StatefulWidget {
  @override
  State<_MakeEventDialog> createState() => _MakeEventDialogState();
}


class _MakeEventDialogState extends State<_MakeEventDialog> {
  String? eventType;


  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(context, "Make Event", "Create a new department event"),
            _label("Event Type"),
            _dropdown(),
            _label("Date"),
            _input("dd-mm-yyyy", Icons.calendar_today_outlined),
            _label("Time"),
            _input("--:-- --", Icons.access_time_outlined),
            _label("Location"),
            _input("Event location", null),
            _label("Description"),
            _input("Event description (optional)", null, maxLines: 3),
            const SizedBox(height: 14),
            _primaryButton("Create Event"),
            _cancel(context),
          ],
        ),
      ),
    );
  }


  Widget _header(BuildContext c, String t, String s) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 24),
          Column(
            children: [
              Text(t,
                  style: GoogleFonts.inter(
                      fontSize: 18, fontWeight: FontWeight.w700)),
              Text(s,
                  style: GoogleFonts.inter(
                      fontSize: 13, color: Colors.grey)),
            ],
          ),
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(c))
        ],
      );


  Widget _label(String t) => Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 6),
        child: Text(t,
            style:
                GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
      );


  Widget _input(String hint, IconData? icon, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: icon != null ? Icon(icon, size: 18) : null,
        filled: true,
        fillColor: const Color(0xFFF6F7F9),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
      ),
    );
  }


  Widget _dropdown() {
    return DropdownButtonFormField<String>(
      value: eventType,
      hint: const Text("Select event type"),
      items: ["event", "exam", "holiday"]
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (v) => setState(() => eventType = v),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF6F7F9),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
      ),
    );
  }


  Widget _primaryButton(String t) => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade400,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 12)),
          child:
              Text(t, style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        ),
      );


  Widget _cancel(BuildContext c) => Center(
        child: TextButton(
            onPressed: () => Navigator.pop(c),
            child: const Text("Cancel")),
      );
}


/* ================= MANAGE EVENTS POPUP ================= */


Future<void> showManageEventsDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => _ManageEventsDialog(),
  );
}


class _ManageEventsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _title(context),
            _event("Department Review Meeting", "2024-01-22 • 10:00 AM"),
            _event("Mid-term Exam Starts", "2024-01-25 • Full Day"),
          ],
        ),
      ),
    );
  }


  Widget _title(BuildContext c) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text("Manage Events",
                  style: GoogleFonts.inter(
                      fontSize: 18, fontWeight: FontWeight.w700)),
              Text("View and edit department events",
                  style: GoogleFonts.inter(fontSize: 13, color: Colors.grey)),
            ],
          ),
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(c))
        ],
      );


  Widget _event(String title, String date) => Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    GoogleFonts.inter(fontWeight: FontWeight.w600)),
            Text(date,
                style: GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 8),
           Row(
  children: [
    InkWell(
      onTap: () {
        
      },
      child: Row(
        children: const [
          Icon(Icons.edit_outlined, size: 16),
          SizedBox(width: 4),
          Text("Edit"),
        ],
      ),
    ),
    const SizedBox(width: 24),
    Row(
      children: const [
        Icon(Icons.delete_outline, size: 16, color: Colors.red),
        SizedBox(width: 4),
        Text(
          "Delete",
          style: TextStyle(color: Colors.red),
        ),
      ],
    ),
  ],
),


          ],
        ),
      );
}




