import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class StudentAttendanceService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ===========================================
  // LOAD STUDENT SUBJECT ATTENDANCE
  // ===========================================

  Future<List<Map<String, dynamic>>> loadStudentSubjects() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final userSnap = await _db.collection("users").doc(uid).get();

    final String rollNo = userSnap["rollNo"].toString().trim();

    final String year =
        userSnap["year"].toString().toLowerCase().trim();

    final snap = await _db.collection("attendance").get();

    final Map<String, Map<String, dynamic>> subjectMap = {};

    for (final d in snap.docs) {
      final data = d.data();

      if (!data.containsKey("subject")) continue;
      if (!data.containsKey("year")) continue;
      if (!data.containsKey("students")) continue;

      final String docYear =
          data["year"].toString().toLowerCase().trim();

      if (docYear != year) continue;

      final Map<String, dynamic> students =
          Map<String, dynamic>.from(data["students"]);

      if (!students.containsKey(rollNo)) continue;

      final Map<String, dynamic> student =
          Map<String, dynamic>.from(students[rollNo]);

      final bool present = student["present"] == true;

      final String subject = data["subject"];

      subjectMap.putIfAbsent(subject, () {
        return {
          "subject": subject,
          "attended": 0,
          "total": 0,
        };
      });

      subjectMap[subject]!["total"]++;

      if (present) {
        subjectMap[subject]!["attended"]++;
      }
    }

    return subjectMap.values.map((e) {
      final int attended = e["attended"];
      final int total = e["total"];

      final double pct = total == 0 ? 0 : attended / total;

      return {
        ...e,
        "percentage": pct,
        "status": pct >= 0.85
            ? "Good"
            : pct >= 0.75
                ? "Average"
                : "Poor",
      };
    }).toList();
  }

  // ===========================================
  // OVERALL %
  // ===========================================

  double overall(List<Map<String, dynamic>> subs) {
    if (subs.isEmpty) return 0;

    int total = 0;
    int attended = 0;

    for (final s in subs) {
      total += s["total"] as int;
      attended += s["attended"] as int;
    }

    return total == 0 ? 0 : attended / total;
  }Future<List<Map<String, dynamic>>> loadMonthlyAttendance(
  DateTime month,
) async {
  final userSnap = await _db
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();

  final String rollNo = userSnap["rollNo"].toString().trim();

  final start = DateTime(month.year, month.month, 1);
  final end = DateTime(month.year, month.month + 1, 0);

  // 🔵 Load Govt Holidays automatically
  final govtHolidays = await fetchIndianHolidays(month.year);

  final snap = await _db.collection("attendance").get();

  final Map<DateTime, int> presentPerDay = {};
  final Set<DateTime> holidaySet = {...govtHolidays};

  for (final d in snap.docs) {
    final data = d.data();

    if (!data.containsKey("date")) continue;
    if (!data.containsKey("students")) continue;

    DateTime docDate;

    try {
      docDate = DateTime.parse(data["date"]);
    } catch (_) {
      continue;
    }

    if (docDate.isBefore(start) || docDate.isAfter(end)) continue;

    final normalized =
        DateTime(docDate.year, docDate.month, docDate.day);

    final students = Map<String, dynamic>.from(data["students"]);

    if (!students.containsKey(rollNo)) continue;

    final student =
        Map<String, dynamic>.from(students[rollNo]);

    final bool present = student["present"] == true;

    presentPerDay[normalized] =
        (presentPerDay[normalized] ?? 0) + (present ? 1 : 0);
  }

  final Set<DateTime> allDays = {
    ...presentPerDay.keys,
    ...holidaySet,
  };

  return allDays.map((d) {
    return {
      "date": d,
      "presentCount": presentPerDay[d] ?? 0,
      "holiday": holidaySet.contains(d),
    };
  }).toList();
}

Future<Set<DateTime>> fetchIndianHolidays(int year) async {
  final url = Uri.parse(
      "https://date.nager.at/api/v3/PublicHolidays/$year/IN");

  final res = await http.get(url);

  if (res.statusCode != 200) {
    return {};
  }

  final List list = jsonDecode(res.body);

  final Set<DateTime> holidays = {};

  for (final e in list) {
    final d = DateTime.parse(e["date"]);
    holidays.add(DateTime(d.year, d.month, d.day));
  }

  return holidays;

}
// ===========================================
// ⏱ CHECK IF CURRENT PERIOD IS EDITABLE
// ===========================================

bool canEditAttendance(String timeRange) {
  try {
    final parts = timeRange.split("-");
    if (parts.length != 2) return false;

    final startParts = parts[0].trim().split(":");
    final endParts = parts[1].trim().split(":");

    final now = DateTime.now();

    final start = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(startParts[0]),
      int.parse(startParts[1]),
    );

    final end = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(endParts[0]),
      int.parse(endParts[1]),
    );

    return now.isAfter(start) && now.isBefore(end);
  } catch (_) {
    return false;
  }
}

}