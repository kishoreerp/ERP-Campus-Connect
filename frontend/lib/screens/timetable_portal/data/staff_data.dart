import '../models/staff.dart';

const Map<String, List<Staff>> staffByDepartment = {
  'CSE': [
    Staff(
      name: 'Dr. Sarah Johnson',
      role: 'Professor',
      workload: 'Worked: 18/24h',
    ),
    Staff(
      name: 'Prof. David Lee',
      role: 'Associate Professor',
      workload: 'Worked: 20/24h',
    ),
  ],

  'IT': [
    Staff(
      name: 'Dr. Anita Kumar',
      role: 'Professor',
      workload: 'Worked: 16/24h',
    ),
  ],

  'ECE': [
    Staff(
      name: 'Dr. Ramesh',
      role: 'Professor',
      workload: 'Worked: 22/24h',
    ),
    Staff(
      name: 'Ms. Priya',
      role: 'Assistant Professor',
      workload: 'Worked: 14/24h',
    ),
  ],
};
