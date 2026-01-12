import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';


class StudentAttendanceScreen extends StatefulWidget {
  const StudentAttendanceScreen({super.key});


  @override
  State<StudentAttendanceScreen> createState() =>
      _StudentAttendanceScreenState();
}


class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
  DateTime _focusedDay = DateTime(2025, 10, 12);
  DateTime? _selectedDay;


  final Map<DateTime, List<Map<String, dynamic>>> attendanceRecords = {
    DateTime(2025, 10, 12): [
      {'subject': 'Data Structures', 'status': 'Present'},
      {'subject': 'Database Systems', 'status': 'Absent'},
      {'subject': 'Software Engineering', 'status': 'Present'},
    ],
    DateTime(2025, 10, 13): [
      {'subject': 'Algorithms', 'status': 'Present'},
      {'subject': 'Web Development', 'status': 'Present'},
    ],
  };


  @override
  Widget build(BuildContext context) {
    final attendanceData = [
      {
        'subject': 'Industrial Management',
        'attended': 23,
        'total': 25,
        'percentage': 0.92,
        'status': 'Good',
      },
      {
        'subject': 'Human values and Professional Ethics',
        'attended': 22,
        'total': 25,
        'percentage': 0.88,
        'status': 'Good',
      },
      {
        'subject': 'Project Report Writing',
        'attended': 20,
        'total': 24,
        'percentage': 0.85,
        'status': 'Good',
      },
      {
        'subject': 'English for Competitive Exams',
        'attended': 20,
        'total': 24,
        'percentage': 0.83,
        'status': 'Average',
      },
    ];


    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
             children: [
              _buildOverallAttendance(context),
              const SizedBox(height: 20),
              ...attendanceData.map((data) => _buildSubjectAttendance(data)),
            ],
          ),
        ),
      ),
    );
  }


 
  // ---------------- OVERALL ATTENDANCE ----------------
  Widget _buildOverallAttendance(BuildContext context) {
    return GestureDetector(
      onTap: () => _showAttendanceCalendar(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('87%',
                style: GoogleFonts.inter(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent)),
            Text('Overall Attendance - Tap to view calendar',
                style:
                    GoogleFonts.inter(fontSize: 13, color: Colors.grey[700])),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: 0.87,
              color: Colors.black,
              backgroundColor: Colors.grey[300],
              minHeight: 6,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      ),
    );
  }


  // ---------------- SUBJECT ATTENDANCE CARD ----------------
  Widget _buildSubjectAttendance(Map<String, dynamic> data) {
    final percentage = (data['percentage'] * 100).toInt();


    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(data['subject'],
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600, fontSize: 15)),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$percentage%',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${data['attended']}/${data['total']} classes',
                  style: GoogleFonts.inter(
                      fontSize: 13, color: Colors.grey[700])),
              Text(data['status'],
                  style: GoogleFonts.inter(
                      fontSize: 13, color: Colors.grey[800])),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: data['percentage'],
            backgroundColor: Colors.grey[200],
            color: Colors.black,
            minHeight: 6,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }


  // ---------------- ATTENDANCE CALENDAR POPUP ----------------
  void _showAttendanceCalendar(BuildContext context) {
    final presentDays = {1, 2, 3, 6, 7, 8, 9, 10};
    final absentDays = {4, 5, 11, 12};
    final holidays = {13, 20, 27};


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding: const EdgeInsets.all(20),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Attendance Calendar',
                                style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            Text('Tap a date to view details',
                                style: GoogleFonts.inter(
                                    fontSize: 13, color: Colors.grey[700])),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.close,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),


                    TableCalendar(
                      firstDay: DateTime.utc(2025, 1, 1),
                      lastDay: DateTime.utc(2025, 12, 31),
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                        final normalized = DateTime(selectedDay.year,
                            selectedDay.month, selectedDay.day);
                        _showDayAttendanceDetails(context, normalized);
                      },
                      calendarStyle: const CalendarStyle(
                        outsideDaysVisible: false,
                        todayDecoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        markersMaxCount: 1,
                      ),
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, day, focusedDay) {
                          final dayNum = day.day;
                          Color? dotColor;


                          if (presentDays.contains(dayNum)) {
                            dotColor = Colors.green;
                          } else if (absentDays.contains(dayNum)) {
                            dotColor = Colors.redAccent;
                          } else if (holidays.contains(dayNum)) {
                            dotColor = Colors.orange;
                          }


                          return Container(
                            margin: const EdgeInsets.all(4),
                            child: Center(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Text('${day.day}',
                                      style: GoogleFonts.inter(fontSize: 13)),
                                  if (dotColor != null)
                                    Positioned(
                                      bottom: 3,
                                      child: Container(
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: dotColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        formatButtonVisible: false,
                        titleTextStyle: GoogleFonts.inter(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _legendItem('Present', Colors.green),
                        _legendItem('Absent', Colors.redAccent),
                        _legendItem('Holiday', Colors.orange),
                        _legendItem('Sunday', Colors.purple),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }


  // ---------------- DAY ATTENDANCE DETAILS ----------------
  void _showDayAttendanceDetails(BuildContext context, DateTime selectedDay) {
    final normalized =
        DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
    final data = attendanceRecords[normalized];


    if (data == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No attendance records found for this date.',
            style: GoogleFonts.inter(fontSize: 13),
          ),
          backgroundColor: Colors.black87,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }


    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Attendance Details - ${normalized.day}/${normalized.month}/${normalized.year}',
                style: GoogleFonts.inter(
                    fontSize: 15, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              ...data.map((entry) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      entry['status'] == 'Present'
                          ? Icons.check_circle
                          : Icons.cancel,
                      color: entry['status'] == 'Present'
                          ? Colors.green
                          : Colors.redAccent,
                    ),
                    title: Text(entry['subject'],
                        style: GoogleFonts.inter(fontSize: 14)),
                    trailing: Text(entry['status'],
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: entry['status'] == 'Present'
                                ? Colors.green
                                : Colors.redAccent)),
                  )),
            ],
          ),
        );
      },
    );
  }


  // ---------------- LEGEND ITEM ----------------
  Widget _legendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label,
            style:
                GoogleFonts.inter(fontSize: 12, color: Colors.grey[800])),
      ],
    );
  }
}







