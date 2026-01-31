import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class StaffEventsScreen extends StatefulWidget {
  const StaffEventsScreen({super.key});


  @override
  State<StaffEventsScreen> createState() => _StaffEventsScreenState();
}


class _StaffEventsScreenState extends State<StaffEventsScreen> {
  DateTime currentMonth = DateTime.now();
  DateTime? selectedDate = DateTime.now();


  int get daysInMonth =>
      DateTime(currentMonth.year, currentMonth.month + 1, 0).day;


  int get firstWeekdayOfMonth =>
      DateTime(currentMonth.year, currentMonth.month, 1).weekday % 7;


  void _previousMonth() {
    setState(() {
      currentMonth =
          DateTime(currentMonth.year, currentMonth.month - 1);
    });
  }


  void _nextMonth() {
    setState(() {
      currentMonth =
          DateTime(currentMonth.year, currentMonth.month + 1);
    });
  }


  String get monthYearLabel {
    return "${_monthName(currentMonth.month)} ${currentMonth.year}";
  }


  String _monthName(int month) {
    const months = [
      'January','February','March','April','May','June',
      'July','August','September','October','November','December'
    ];
    return months[month - 1];
  }


  final List<String> weekDays = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'];


  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();


    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Events',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700, color: Colors.black)),
            Text('View calendar and upcoming events',
                style: GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),


      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            /// ---------------- CALENDAR ----------------
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [


                  /// MONTH NAVIGATION
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.chevron_left),
                          onPressed: _previousMonth),
                      Text(monthYearLabel,
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600)),
                      IconButton(
                          icon: const Icon(Icons.chevron_right),
                          onPressed: _nextMonth),
                    ],
                  ),


                  const SizedBox(height: 8),


                  /// WEEK DAYS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: weekDays
                        .map((d) => Expanded(
                              child: Center(
                                child: Text(d,
                                    style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey)),
                              ),
                            ))
                        .toList(),
                  ),


                  const SizedBox(height: 10),


                  /// DAYS GRID
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: daysInMonth + firstWeekdayOfMonth,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6,
                    ),
                    itemBuilder: (context, index) {
                      if (index < firstWeekdayOfMonth) {
                        return const SizedBox();
                      }


                      final day = index - firstWeekdayOfMonth + 1;


                      final isToday =
                          day == today.day &&
                          currentMonth.month == today.month &&
                          currentMonth.year == today.year;


                      final isSelected =
                          selectedDate?.day == day &&
                          selectedDate?.month == currentMonth.month &&
                          selectedDate?.year == currentMonth.year;


                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedDate = DateTime(
                                currentMonth.year,
                                currentMonth.month,
                                day);
                          });
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.black
                                : isToday
                                    ? Colors.black.withOpacity(0.15)
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '$day',
                            style: GoogleFonts.inter(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: isToday || isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),


            const SizedBox(height: 16),


            /// ---------------- LEGEND ----------------
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _legendDot(Colors.blue, 'Event'),
                const SizedBox(width: 16),
                _legendDot(Colors.red, 'Exam'),
                const SizedBox(width: 16),
                _legendDot(Colors.green, 'Holiday'),
              ],
            ),


            const SizedBox(height: 24),


            /// ---------------- UPCOMING EVENTS ----------------
            Text('Upcoming Events',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600, fontSize: 16)),
            const SizedBox(height: 12),


            _eventTile(
              color: Colors.blue,
              title: 'Faculty Development Program',
              date: '22 Jan 2024',
              time: '10:00 AM',
              tag: 'Event',
            ),
            _eventTile(
              color: Colors.red,
              title: 'Mid-term Exam Starts',
              date: '25 Jan 2024',
              time: 'Full Day',
              tag: 'Exam',
            ),
            _eventTile(
              color: Colors.green,
              title: 'Republic Day Holiday',
              date: '26 Jan 2024',
              time: 'Closed',
              tag: 'Holiday',
            ),
            _eventTile(
              color: const Color.fromARGB(218, 15, 160, 222),
              title: 'Department Meeting',
              date: '1 Feb 2024',
              time: '2.00 pm',
              tag: 'Event',
            ),
          ],
        ),
      ),
    );
  }


  /// ---------------- HELPERS ----------------


  Widget _legendDot(Color color, String label) {
    return Row(
      children: [
        Container(
          height: 8,
          width: 8,
          decoration:
              BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: GoogleFonts.inter(fontSize: 12)),
      ],
    );
  }


  Widget _eventTile({
    required Color color,
    required String title,
    required String date,
    required String time,
    required String tag,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Container(
              width: 10,
              height: 10,
              decoration:
                  BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 12),


          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 14, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(date,
                        style: GoogleFonts.inter(
                            fontSize: 12, color: Colors.grey)),
                    const SizedBox(width: 12),
                    const Icon(Icons.access_time,
                        size: 14, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(time,
                        style: GoogleFonts.inter(
                            fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),


          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(tag, style: GoogleFonts.inter(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}