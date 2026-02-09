import 'package:flutter/material.dart';
import 'models/timetable_entry.dart';
import 'widgets/create_timetable_entry_sheet.dart';
import 'widgets/edit_timetable_entry_sheet.dart';

class TimetableGridScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<TimetableEntry> entries;

  const TimetableGridScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.entries,
  });

  static const days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  static const times = [
    '09:00 - 09:50',
    '09:50 - 10:40',
    '10:55 - 11:45',
    '11:45 - 12:35',
    '01:10 - 02:00',
    '02:00 - 02:50',
    '02:50 - 03:40',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        title: Text(title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(24),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(subtitle, style: const TextStyle(fontSize: 12)),
          ),
        ),
      ),
      body: Column(
        children: [
          _actionBar(context),
          const SizedBox(height: 12),
          Expanded(child: _timetableGrid()),
        ],
      ),
    );
  }

  /// ACTION BUTTONS (Make / Edit / Upload)
  Widget _actionBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          /// ✅ MAKE BUTTON (FIXED)
          ElevatedButton.icon(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                builder: (_) => const CreateTimetableEntrySheet(),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Make'),
          ),

          const SizedBox(width: 12),

          /// EDIT BUTTON (leave empty or add later)
          OutlinedButton.icon(
  onPressed: () {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => const EditTimetableEntrySheet(),
    );
  },
  icon: const Icon(Icons.edit),
  label: const Text('Edit'),
),


          const Spacer(),

          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.upload),
            label: const Text('Upload to Student Portal'),
          ),
        ],
      ),
    );
  }

  /// MAIN GRID
  Widget _timetableGrid() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Table(
          border: TableBorder.all(color: Colors.grey.shade300),
          defaultColumnWidth: const FixedColumnWidth(140),
          children: [
            _headerRow(),
            for (int i = 0; i < times.length; i++) _timeRow(i),
          ],
        ),
      ),
    );
  }

  /// HEADER ROW
  TableRow _headerRow() {
    return TableRow(
      children: [
        _headerCell('Time'),
        for (final day in days) _headerCell(day),
      ],
    );
  }

  /// EACH TIME ROW
  TableRow _timeRow(int index) {
    return TableRow(
      children: [
        _timeCell(times[index]),
        for (int d = 0; d < days.length; d++)
          _entryCell(day: d, period: index + 1),
      ],
    );
  }

  /// CELLS
  Widget _headerCell(String text) {
    return Container(
      height: 48,
      alignment: Alignment.center,
      color: const Color(0xFFEAF0F6),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }

  Widget _timeCell(String text) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Text(text, style: const TextStyle(fontSize: 12)),
    );
  }

  Widget _entryCell({required int day, required int period}) {
    final match = entries.where(
      (e) => e.day == day && e.period == period,
    );

    if (match.isEmpty) {
      return const SizedBox(height: 72);
    }

    final e = match.first;

    return Padding(
      padding: const EdgeInsets.all(6),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFE3F2FD),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(e.subject,
                style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(e.teacher, style: const TextStyle(fontSize: 11)),
            Text(e.room, style: const TextStyle(fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
