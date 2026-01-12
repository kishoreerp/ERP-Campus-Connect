import 'package:flutter/material.dart';
import 'examcell_home_screen.dart';
import 'examcell_result_screen.dart';
import 'examcell_profile_screen.dart';
import 'exam_details_dialog.dart';
import 'edit_exam_dialog.dart';
import 'schedule_exam_dialog.dart';

class ExamCellExamScreen extends StatelessWidget {

  const ExamCellExamScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // ---------------- APP BAR ----------------
     appBar: AppBar(
  automaticallyImplyLeading: false, // ✅ THIS REMOVES BACK ARROW
  elevation: 0,
  backgroundColor: Colors.white,
  titleSpacing: 0,
  title: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      Text(
        'Exam Cell Admin',
        style: TextStyle(
          color: Color(0xFF7C3AED),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      SizedBox(height: 2),
      Text(
        'SLEC Admin Portal',
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
    ],
  ),
  actions: const [
    Padding(
      padding: EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor: Color.fromARGB(255, 187, 182, 196),
        child: Icon(Icons.person, color: Colors.white),
      ),
    ),
  ],
),


      // ---------------- BODY ----------------
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(context ),
            const SizedBox(height: 12),
            _filterDropdown(),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: const [
                  _ExamCard(
                    title: 'Data Structures',
                    faculty: 'Dr. Sarah Johnson',
                    date: '2024-01-25',
                    time: '09:00-12:00',
                    hall: 'Hall A',
                    students: '45 students',
                    status: 'Scheduled',
                    statusColor: Colors.blue,
                  ),
                  _ExamCard(
                    title: 'Database Systems',
                    faculty: 'Dr. Lisa Wong',
                    date: '2024-01-23',
                    time: '14:00-17:00',
                    hall: 'Hall B',
                    students: '42 students',
                    status: 'Completed',
                    statusColor: Colors.green,
                  ),
                  _ExamCard(
                    title: 'Algorithms',
                    faculty: 'Prof. David Lee',
                    date: '2024-01-27',
                    time: '10:00-13:00',
                    hall: 'Hall C',
                    students: '38 students',
                    status: 'Scheduled',
                    statusColor: Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // ---------------- BOTTOM NAV ----------------
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: const Color(0xFF7C3AED),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const ExamCellHomeScreen(),
              ),
            );
          }
           else if (index == 1) {
      return;
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ExamCellResultScreen()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ExamCellProfileScreen()),
      );
    }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Exam',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Result',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // ---------------- HEADER ----------------
 Widget _header(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Exam Management',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            Text(
              'Schedule and manage exams',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        ElevatedButton.icon(
  icon: const Icon(Icons.add),
  label: const Text('Add'),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  onPressed: () {
    showDialog(
      context: context,
      builder: (_) => const ScheduleExamDialog(),
    );
  },
),

      ],
    );
  }

  // ---------------- FILTER ----------------
  Widget _filterDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: 'All Status',
          items: const [
            DropdownMenuItem(value: 'All Status', child: Text('All Status')),
            DropdownMenuItem(value: 'Scheduled', child: Text('Scheduled')),
            DropdownMenuItem(value: 'Completed', child: Text('Completed')),
          ],
          onChanged: (_) {},
        ),
      ),
    );
  }
}

// ================= EXAM CARD =================
class _ExamCard extends StatelessWidget {
  final String title;
  final String faculty;
  final String date;
  final String time;
  final String hall;
  final String students;
  final String status;
  final Color statusColor;

  const _ExamCard({
    required this.title,
    required this.faculty,
    required this.date,
    required this.time,
    required this.hall,
    required this.students,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(faculty, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 12),

          // Date & Time
          Row(
            children: [
              const Icon(Icons.calendar_today,
                  size: 16, color: Colors.grey),
              const SizedBox(width: 6),
              Text(date),
              const SizedBox(width: 16),
              const Icon(Icons.access_time, size: 16, color: Colors.grey),
              const SizedBox(width: 6),
              Text(time),
            ],
          ),
          const SizedBox(height: 8),

          // Hall & Students
          Row(
            children: [
              const Icon(Icons.location_on,
                  size: 16, color: Colors.grey),
              const SizedBox(width: 6),
              Text(hall),
              const SizedBox(width: 16),
              const Icon(Icons.group, size: 16, color: Colors.grey),
              const SizedBox(width: 6),
              Text(students),
            ],
          ),

          const Divider(height: 24),

          // Buttons
          Row(
  children: [
    Expanded(
      child: OutlinedButton.icon(
        icon: const Icon(Icons.remove_red_eye),
        label: const Text('View'),
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const ExamDetailsDialog(),
          );
        },
      ),
    ),
    const SizedBox(width: 12),
    Expanded(
      child: OutlinedButton.icon(
        icon: const Icon(Icons.edit),
        label: const Text('Edit'),
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const EditExamDialog(),
           );
           },
         ),
        ),
         ],
          ),

        ],
      ),
    );
  }
}
