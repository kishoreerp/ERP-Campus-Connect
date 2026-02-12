import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  }

  // ===========================================
  // LOAD MONTHLY CALENDAR DATA
  // ===========================================

Future<List<Map<String, dynamic>>> loadMonthlyAttendance(
  DateTime month,
) async {
  final userSnap = await _db
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();

  final String rollNo = userSnap["rollNo"].toString().trim();

  final start = DateTime(month.year, month.month, 1);
  final end = DateTime(month.year, month.month + 1, 0);

  final snap = await _db.collection("attendance").get();

  /// 👉 date -> presentCount for whole day
  final Map<DateTime, int> presentPerDay = {};
  final Set<DateTime> holidaySet = {};

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

    // 👉 accumulate per day
    presentPerDay[normalized] =
        (presentPerDay[normalized] ?? 0) + (present ? 1 : 0);

    if (data["status"] == "holiday") {
      holidaySet.add(normalized);
    }
  }

  return presentPerDay.entries.map((e) {
    return {
      "date": e.key,
      "presentCount": e.value,
      "holiday": holidaySet.contains(e.key),
    };
  }).toList();
}
}