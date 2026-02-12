import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AttendanceService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String today() =>
      DateFormat("yyyy-MM-dd").format(DateTime.now());

  // =====================================================
  // LOAD OR CREATE TODAY
  // =====================================================
  Future<List<Map<String, dynamic>>> loadToday() async {
    final date = today();

    final snap = await _db
        .collection("attendance")
        .where("date", isEqualTo: date)
        .orderBy("order")
        .get();

    if (snap.docs.isEmpty) {
      print("⚠ No docs — creating schedule...");
      await _createTodaySchedule(date);

      final again = await _db
          .collection("attendance")
          .where("date", isEqualTo: date)
          .orderBy("order")
          .get();

      return again.docs.map(_map).toList();
    }

    return snap.docs.map(_map).toList();
  }

  Map<String, dynamic> _map(QueryDocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return {...d, "id": doc.id};
  }

  // =====================================================
  // CREATE DAILY SCHEDULE
  // =====================================================
  Future<void> _createTodaySchedule(String date) async {
    print("🛠 Creating attendance docs...");

    final schedule = [
      {
        "hour": "1st Hour",
        "time": "09:00 - 10:00",
        "subject": "Data Structures",
        "code": "CS501",
        "year": "3rd Year",
        "order": 1,
        "status": "pending",
      },
      {
        "hour": "2nd Hour",
        "time": "10:00 - 11:00",
        "subject": "Algorithms",
        "code": "CS502",
        "year": "2nd Year",
        "order": 2,
        "status": "pending",
      },
      {
        "hour": "Interval",
        "time": "11:00 - 11:15",
        "order": 3,
        "status": "break",
      },
      {
        "hour": "3rd Hour",
        "time": "11:15 - 12:15",
        "subject": "DBMS",
        "code": "CS503",
        "year": "4th Year",
        "order": 4,
        "status": "pending",
      },
      {
        "hour": "4th Hour",
        "time": "12:15 - 13:15",
        "subject": "Web Development",
        "code": "CS504",
        "year": "1st Year",
        "order": 5,
        "status": "pending",
      },
      {
        "hour": "Lunch Break",
        "time": "13:15 - 14:15",
        "order": 6,
        "status": "break",
      },
      {
        "hour": "5th Hour",
        "time": "14:15 - 15:15",
        "subject": "AI",
        "code": "CS505",
        "year": "3rd Year",
        "order": 7,
        "status": "pending",
      },
    ];

    final batch = _db.batch();

    for (final h in schedule) {
      final String id =
          "${date}_${h["hour"]}".replaceAll(" ", "_");

      Map<String, dynamic> studentsMap = {};

      if (h["status"] != "break") {
        final QuerySnapshot studentsSnap = await _db
            .collection("students")
            .where("year", isEqualTo: h["year"])
            .get();

        for (final s in studentsSnap.docs) {
          studentsMap[s["rollNo"]] = {
            "name": s["name"],
            "dept": s["dept"],
            "present": false,
          };
        }
      }

      batch.set(
        _db.collection("attendance").doc(id),
        {
          ...h,
          "date": date,
          "students": studentsMap,
          "total": studentsMap.length,
          "present": 0,
          "absent": studentsMap.length,
          "updatedAt": FieldValue.serverTimestamp(),
        },
      );
    }

    await batch.commit();

    print("✅ Schedule created for $date");
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
    } catch (e) {
      return false;
    }
  }

  // =====================================================
  // UPDATE (LOCKED AFTER TIME)
  // =====================================================

  Future<void> updateAttendance(
    String docId,
    Map<String, dynamic> students,
  ) async {
    // 🔒 READ DOC FIRST
    final snap =
        await _db.collection("attendance").doc(docId).get();

    final data = snap.data();

    if (data == null) return;

    final String time = data["time"];

    // ⛔ BLOCK IF TIME OVER
    if (!canEditAttendance(time)) {
      throw Exception("Attendance time expired");
    }

    int present = 0;

    students.forEach((k, v) {
      if (v["present"] == true) present++;
    });

    await _db.collection("attendance").doc(docId).update({
      "students": students,
      "present": present,
      "absent": students.length - present,
      "status": "marked",
      "updatedAt": FieldValue.serverTimestamp(),
    });
  }
}