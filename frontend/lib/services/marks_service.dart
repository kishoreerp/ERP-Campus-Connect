import 'package:cloud_firestore/cloud_firestore.dart';

class MarksService {
  MarksService._();
  static final MarksService instance = MarksService._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // =========================================================
  // DOC ID FORMAT (FINAL STABLE)
  // Example: IA1_CS501_1stYear
  // =========================================================
  String _buildDocId(String examType, String subjectCode, String year) {
    return '${examType.trim()}${subjectCode.trim()}${year.replaceAll(" ", "")}';
  }

  // =========================================================
  // SAVE MARKS
  // =========================================================
  Future<void> saveMarks({
    required String assessmentType,
    required String subjectCode,
    required String subjectName,
    required String year,
    required int maxMarks,
    required Map<String, int> marks,
  }) async {

    final docId = _buildDocId(assessmentType, subjectCode, year);

    await _firestore.collection('marks').doc(docId).set({
      'assessmentType': assessmentType.trim(),
      'subjectCode': subjectCode.trim(),
      'subjectName': subjectName.trim(),
      'year': year.trim(),
      'maxMarks': maxMarks,
      'marks': marks,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // =========================================================
  // LOAD MARKS (STAFF / REFRESH SAFE)
  // =========================================================
  Future<Map<String, int>> getMarks({
    required String assessmentType,
    required String subjectCode,
    required String year,
  }) async {

    final docId = _buildDocId(assessmentType, subjectCode, year);

    final doc =
        await _firestore.collection('marks').doc(docId).get();

    if (!doc.exists) return {};

    final data = doc.data();
    if (data == null || data['marks'] == null) return {};

    final raw = Map<String, dynamic>.from(data['marks']);
    final Map<String, int> result = {};

    raw.forEach((k, v) {
      if (v is num) result[k] = v.toInt();
    });

    return result;
  }

  // =========================================================
  // GET MARKS FOR EXAM (USED BY HOD / STAFF)
  // =========================================================
  Future<Map<String, int>> getMarksForExam({
    required String subjectCode,
    required String year,
    required String examType,
  }) async {
    return getMarks(
      assessmentType: examType,
      subjectCode: subjectCode,
      year: year,
    );
  }

  // =========================================================
  // STUDENT MARKS VIEW
  // =========================================================
  Future<Map<String, Map<String, int>>> getStudentMarks({
    required String regNo,
    required String studentYear,
  }) async {

    final snapshot = await _firestore.collection('marks').get();

    final Map<String, Map<String, int>> result = {};

    for (final doc in snapshot.docs) {

      final data = doc.data();

      final dbYear = (data['year'] ?? '').toString().trim();
      if (dbYear != studentYear.trim()) continue;

      if (!data.containsKey('marks')) continue;

      final marksMap = Map<String, dynamic>.from(data['marks']);

      if (!marksMap.containsKey(regNo)) continue;

      final value = marksMap[regNo];
      if (value is! num) continue;

      final subject = (data['subjectName'] ?? 'Unknown').toString().trim();
      final exam = (data['assessmentType'] ?? '').toString().trim();

      result.putIfAbsent(subject, () => {});
      result[subject]![exam] = value.toInt();
    }

    return result;
  }

  // =========================================================
  // HOD YEAR VIEW
  // =========================================================
  Future<Map<String, Map<String, Map<String, int>>>> getDepartmentYearMarks({
    required String year,
  }) async {

    final snapshot = await _firestore.collection('marks').get();

    final Map<String, Map<String, Map<String, int>>> result = {};

    for (final doc in snapshot.docs) {

      final data = doc.data();

      final dbYear = (data['year'] ?? '').toString().trim();
      if (dbYear != year.trim()) continue;

      if (!data.containsKey('marks')) continue;

      final subject = (data['subjectName'] ?? 'Unknown').toString().trim();
      final examType = (data['assessmentType'] ?? '').toString().trim();

      final raw = Map<String, dynamic>.from(data['marks']);
      final Map<String, int> marks = {};

      raw.forEach((k, v) {
        if (v is num) marks[k] = v.toInt();
      });

      if (marks.isEmpty) continue;

      result.putIfAbsent(subject, () => {});
      result[subject]![examType] = marks;
    }

    return result;
  }

  // =========================================================
  // SUBJECT LIST FOR YEAR (HOD)
  // =========================================================
  Future<List<String>> getSubjectsByYear(String year) async {

    final snapshot = await _firestore.collection('marks').get();

    final Set<String> subjects = {};

    for (final doc in snapshot.docs) {

      final data = doc.data();

      final dbYear = (data['year'] ?? '').toString().trim();
      if (dbYear != year.trim()) continue;

      final subject = (data['subjectName'] ?? '').toString().trim();
      if (subject.isEmpty) continue;

      subjects.add(subject);
    }

    final list = subjects.toList();
    list.sort();
    return list;
  }

  // =========================================================
  // SINGLE SUBJECT MARKS (HOD VIEW)
  // =========================================================
  Future<Map<String, Map<String, int>>> getSubjectMarks({
    required String year,
    required String subjectName,
  }) async {

    final snapshot = await _firestore.collection('marks').get();

    final Map<String, Map<String, int>> result = {};

    for (final doc in snapshot.docs) {

      final data = doc.data();

      final dbYear = (data['year'] ?? '').toString().trim();
      if (dbYear != year.trim()) continue;

      final subject = (data['subjectName'] ?? '').toString().trim();
      if (subject != subjectName.trim()) continue;

      final examType = (data['assessmentType'] ?? '').toString().trim();

      if (!data.containsKey('marks')) continue;

      final raw = Map<String, dynamic>.from(data['marks']);
      final Map<String, int> marks = {};

      raw.forEach((k, v) {
        if (v is num) marks[k] = v.toInt();
      });

      if (marks.isEmpty) continue;

      result[examType] = marks;
    }

    return result;
  }

  // =========================================================
  // CSV GENERATION (HOD DOWNLOAD)
  // =========================================================
  Future<String> generateSubjectCSV({
    required String year,
    required String subjectName,
  }) async {

    final data =
        await getSubjectMarks(year: year, subjectName: subjectName);

    final Set<String> students = {};

    for (final exam in data.values) {
      students.addAll(exam.keys);
    }

    final exams = data.keys.toList();

    String csv = "Register No,${exams.join(",")}\n";

    for (final reg in students) {

      final row = [reg];

      for (final exam in exams) {
        row.add(data[exam]?[reg]?.toString() ?? "0");
      }

      csv += "${row.join(",")}\n";
    }

    return csv;
  }
}