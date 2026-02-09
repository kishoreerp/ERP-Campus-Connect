class TimetableEntry {
  final String id;
  final int day;
  final int period;
  final String subject;
  final String teacher;
  final String room;

  TimetableEntry({
    required this.id,
    required this.day,
    required this.period,
    required this.subject,
    required this.teacher,
    required this.room,
  });
}
