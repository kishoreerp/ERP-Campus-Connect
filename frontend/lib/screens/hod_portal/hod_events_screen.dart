import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'hod_events_screen.dart';
import 'event_dialogs.dart';
class HODEventsScreen extends StatelessWidget {
  const HODEventsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(24),
                    child: const Padding(
                      padding: EdgeInsets.all(6),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Events",
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "View calendar and manage events",
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),


              const SizedBox(height: 16),


              // ACTION BUTTONS
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                         showMakeEventDialog(context);
                      },
                      icon: const Icon(Icons.add, size: 18),
                      label: Text(
                        "Make Event",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                         showManageEventsDialog(context);
                      },
                      icon: const Icon(Icons.edit_outlined, size: 18),
                      label: Text(
                        "Edit Events",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),


              const SizedBox(height: 18),


              // CALENDAR CARD
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.chevron_left),
                        Text(
                          "December 2025",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Icon(Icons.chevron_right),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _CalendarGrid(),
                  ],
                ),
              ),


              const SizedBox(height: 22),


              Text(
                "Upcoming Events",
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),


              const SizedBox(height: 12),


              _eventTile(
                title: "Department Review Meeting",
                date: "2024-01-22  •  10:00 AM",
                tag: "event",
              ),


              const SizedBox(height: 12),


              _eventTile(
                title: "Mid-term Exam Starts",
                date: "2024-01-25  •  Full Day",
                tag: "exam",
              ),
            ],
          ),
        ),
      ),
    );
  }


  // EVENT CARD
  Widget _eventTile({
    required String title,
    required String date,
    required String tag,
  }) {
    return Container(
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
            child: Icon(
              Icons.calendar_today_outlined,
              color: Colors.purple.shade400,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    tag,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


/// CALENDAR GRID (STATIC — MATCHES SS)
class _CalendarGrid extends StatelessWidget {
  const _CalendarGrid();


  @override
  Widget build(BuildContext context) {
    final days = [
      "Su","Mo","Tu","We","Th","Fr","Sa",
      "30","1","2","3","4","5","6",
      "7","8","9","10","11","12","13",
      "14","15","16","17","18","19","20",
      "21","22","23","24","25","26","27",
      "28","29","30","31","1","2","3",
    ];


    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: days.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
      ),
      itemBuilder: (_, i) {
        final isSelected = days[i] == "17";
        final isHeader = i < 7;


        return Center(
          child: isSelected
              ? Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    days[i],
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              : Text(
                  days[i],
                  style: TextStyle(
                    fontWeight:
                        isHeader ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
        );
      },
    );
  }
}




