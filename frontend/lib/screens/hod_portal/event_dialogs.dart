import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

Future<void> showMakeEventDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (_) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: const Text("Make Event"),
        ),
      );
    },
  );
}



/* ================= MAKE EVENT POPUP ================= */

Future<void> showEditEventDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (_) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: const Text("Edit Event"),
        ),
      );
    },
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
  return showDialog<void>(
    context: context,
    builder: (_) {
      return Dialog(
        insetPadding: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Manage Events",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "View and edit department events",
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),

              _manageEventItem(
                context,
                title: "Mid-term Exam Starts",
                date: "2024-01-25 • Full Day",
              ),

              const SizedBox(height: 12),

              _manageEventItem(
                context,
                title: "Republic Day Holiday",
                date: "2024-01-26 • Closed",
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _manageEventItem(
  BuildContext context, {
  required String title,
  required String date,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text(date,
            style: GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 10),

        Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
                showEditEventDialog(context);
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
                Icon(Icons.delete_outline,
                    size: 16, color: Colors.red),
                SizedBox(width: 4),
                Text("Delete",
                    style: TextStyle(color: Colors.red)),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
