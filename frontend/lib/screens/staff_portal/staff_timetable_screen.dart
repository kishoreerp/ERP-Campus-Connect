import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class StaffTimeTableScreen extends StatefulWidget {
  const StaffTimeTableScreen({super.key});


  @override
  State<StaffTimeTableScreen> createState() => _StaffTimeTableScreenState();
}


class _StaffTimeTableScreenState extends State<StaffTimeTableScreen> {
  bool isWeekTimetable = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Timetable & Schedule',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            Text(
              'View your teaching schedule and exam timetable',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),


          // TOGGLE BUTTONS
          _buildToggle(),


          const SizedBox(height: 12),


          Expanded(
            child: isWeekTimetable
                ? _buildWeekTimetable()
                : _buildExamTimetable(),
          ),
        ],
      ),
    );
  }


  // ---------------- TOGGLE ----------------
  Widget _buildToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            _toggleButton('Week Timetable', true),
            _toggleButton('Exam Timetable', false),
          ],
        ),
      ),
    );
  }


  Widget _toggleButton(String title, bool value) {
    final selected = isWeekTimetable == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => isWeekTimetable = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: selected ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }


  // ---------------- WEEK TIMETABLE ----------------
  Widget _buildWeekTimetable() {
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];


    final tableData = {
      'Monday': ['DS-2Y', 'ALG-3Y', '☕', 'DB-FY', 'WD-1Y', '🍽', 'DS Lab', 'DS Lab','-'],
      'Tuesday': ['ALG-3Y', 'DS-2Y', '☕', 'WD-1Y', '-', '🍽', 'ALG Lab','ALG Lab','-'],
      'Wednesday': ['WD-1Y', '-', '☕', 'DS-2Y', 'ALG-3Y', '🍽', 'DB Lab','WD Lab','-'],
      'Thursday': ['DB-FY', 'WD-1Y', '☕', 'ALG-3Y', '-', '🍽', '-','DB Lab','-'],
      'Friday': ['-', 'DB-FY', '☕', 'WD-1Y', 'DS-2Y', '🍽', '-','-','-'],
      'Saturday': ['DS-2Y', 'ALG-3Y', '☕', 'DB-FY', '-', '🍽', '-','-','-'],
    };


    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16),
      child: DataTable(
        headingRowColor:
            MaterialStateProperty.all(Colors.grey.shade200),
        columns: const [
          DataColumn(label: Text('Day')),
          DataColumn(label: Text('1st')),
          DataColumn(label: Text('2nd')),
          DataColumn(label: Text('Break')),
          DataColumn(label: Text('3rd')),
          DataColumn(label: Text('4th')),
          DataColumn(label: Text('Lunch')),
          DataColumn(label: Text('5th')),
          DataColumn(label: Text('6th')),
          DataColumn(label: Text('7th')),
        ],
        rows: days.map((day) {
          final row = tableData[day]!;
          return DataRow(
            cells: [
              DataCell(Text(day)),
              ...row.map((e) => DataCell(Text(e))).toList(),
            ],
          );
        }).toList(),
      ),
    );
  }


  // ---------------- EXAM TIMETABLE ----------------
  Widget _buildExamTimetable() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _ExamCard(
          subject: 'Data Structures',
          year: '2nd Year',
          date: '2024-01-25 (Thursday)',
          time: '10:00 AM - 1:00 PM',
          hall: 'Exam Hall 1',
        ),
        _ExamCard(
          subject: 'Algorithms',
          year: '3rd Year',
          date: '2024-01-27 (Saturday)',
          time: '10:00 AM - 1:00 PM',
          hall: 'Exam Hall 2',
        ),
        _ExamCard(
          subject: 'Database Systems',
          year: 'Final Year',
          date: '2024-01-29 (Monday)',
          time: '2:00 PM - 5:00 PM',
          hall: 'Exam Hall 1',
        ),
        _ExamCard(
          subject: 'Web Development',
          year: '1st Year',
          date: '2024-01-31 (Wednesday)',
          time: '10:00 AM - 1:00 PM',
          hall: 'Exam Hall 3',
        ),
      ],
    );
  }
}


// ---------------- EXAM CARD ----------------
class _ExamCard extends StatelessWidget {
  final String subject;
  final String year;
  final String date;
  final String time;
  final String hall;


  const _ExamCard({
    required this.subject,
    required this.year,
    required this.date,
    required this.time,
    required this.hall,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subject,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  year,
                  style: GoogleFonts.inter(fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _infoRow(Icons.calendar_today, date),
          _infoRow(Icons.access_time, time),
          _infoRow(Icons.location_on, hall),
        ],
      ),
    );
  }


  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.inter(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
