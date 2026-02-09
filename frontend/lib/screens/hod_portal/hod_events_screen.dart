import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'event_dialogs.dart';


class HODEventsScreen extends StatelessWidget {
  const HODEventsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Events",
                          style: GoogleFonts.inter(
                              fontSize: 18, fontWeight: FontWeight.w700)),
                      Text("View calendar and manage events",
                          style: GoogleFonts.inter(
                              fontSize: 13, color: Colors.grey)),
                    ],
                  )
                ],
              ),


              const SizedBox(height: 16),


              /// ACTION BUTTONS
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => showMakeEventDialog(context),
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text("Make Event"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => showManageEventsDialog(context),
                      icon: const Icon(Icons.edit_outlined),
                      label: const Text("Edit Events"),
                    ),
                  ),
                ],
              ),


              const SizedBox(height: 20),


              /// CALENDAR (STATIC – MATCHES UI)
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.chevron_left),
                        Text("January 2026",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        Icon(Icons.chevron_right),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _CalendarGrid(),
                  ],
                ),
              ),


              const SizedBox(height: 24),


              Text("Upcoming Events",
                  style: GoogleFonts.inter(
                      fontSize: 15, fontWeight: FontWeight.w700)),


              const SizedBox(height: 12),


              _eventTile("Department Review Meeting",
                  "2024-01-22 • 10:00 AM", "event"),
              _eventTile(
                  "Mid-term Exam Starts", "2024-01-25 • Full Day", "exam"),
              _eventTile(
                  "Republic Day Holiday", "2024-01-26 • Closed", "holiday"),
              _eventTile(
                  "Faculty Evaluation", "2024-02-01 • 2:00 PM", "event"),
            ],
          ),
        ),
      ),
    );
  }


  Widget _eventTile(String title, String date, String tag) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.calendar_today_outlined,
                color: Colors.purple.shade400),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(date,
                    style:
                        GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(tag,
                      style: GoogleFonts.inter(fontSize: 11)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


/// CALENDAR GRID
class _CalendarGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final days = [
      "Su","Mo","Tu","We","Th","Fr","Sa",
      "28","29","30","31","1","2","3",
      "4","5","6","7","8","9","10",
      "11","12","13","14","15","16","17",
      "18","19","20","21","22","23","24",
      "25","26","27","28","29","30","31",
    ];


    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: days.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
      itemBuilder: (_, i) {
        final selected = days[i] == "10";
        return Center(
          child: selected
              ? Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)),
                  child:
                      Text(days[i], style: const TextStyle(color: Colors.white)),
                )
              : Text(days[i]),
        );
      },
    );
  }
}



