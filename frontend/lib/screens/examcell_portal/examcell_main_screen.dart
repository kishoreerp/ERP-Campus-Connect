import 'package:flutter/material.dart';
import 'examcell_home_screen.dart';
import 'examcell_exam_screen.dart';
import 'examcell_result_screen.dart';
import 'examcell_profile_screen.dart';



class ExamCellMainScreen extends StatefulWidget {
  const ExamCellMainScreen({super.key});

  @override
  State<ExamCellMainScreen> createState() => _ExamCellMainScreenState();
}

class _ExamCellMainScreenState extends State<ExamCellMainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    ExamCellHomeScreen(),
    ExamCellExamScreen(),
    ExamCellResultScreen(),
    ExamCellProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF7C3AED),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Exam'),
          BottomNavigationBarItem(
              icon: Icon(Icons.description), label: 'Result'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
