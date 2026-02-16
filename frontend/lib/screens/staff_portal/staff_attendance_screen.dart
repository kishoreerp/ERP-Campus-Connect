import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/attendance_service.dart';


class StaffAttendanceScreen extends StatefulWidget {
  const StaffAttendanceScreen({super.key});


  @override
  State<StaffAttendanceScreen> createState() =>
      _StaffAttendanceScreenState();
}


class _StaffAttendanceScreenState
    extends State<StaffAttendanceScreen> {
  final _service = AttendanceService();


  bool loading = true;
  List<Map<String, dynamic>> records = [];


  @override
  void initState() {
    super.initState();
    _load();
  }


  Future<void> _load() async {
    final data = await _service.loadToday();


    if (!mounted) return;


    setState(() {
      records = data;
      loading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }


    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _header(),
          const SizedBox(height: 18),
          _infoBanner(),
          const SizedBox(height: 20),


          ...records.map((r) {
            if (r["status"] == "break") {
              return _breakCard(r);
            }
            return _hourCard(r);
          }).toList(),
        ],
      ),
    );
  }


  // ================= HEADER =================


  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Hourly Attendance",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 4),
        Text("Mark attendance for each class hour",
            style: TextStyle(color: Colors.grey)),
      ],
    );
  }


  Widget _infoBanner() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: const [
          Icon(Icons.info_outline, color: Colors.blue),
          SizedBox(width: 10),
          Expanded(
            child: Text(
             
              "Staff Hourly Attendance\nMark attendance per hour. Once marked, you can only view it.",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }


  // ================= CARDS =================


  Widget _hourCard(Map<String, dynamic> r) {
    final int present = r["present"] ?? 0;
    final int total = r["total"] ?? 0;
    final int absent = total - present;


    final students =
        Map<String, dynamic>.from(r["students"] ?? {});


    final deptCounts = _deptCounts(students);


    final percent =
        total == 0 ? 0 : (present / total) * 100;


    final bool isMarked = r["status"] == "marked";
    final bool canEdit = _service.canEditAttendance(r["time"]);






    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              blurRadius: 8,
              color: Colors.black12,
              offset: Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          // top row
          Row(
            children: [
              const Icon(Icons.access_time,
                  color: Colors.green),
              const SizedBox(width: 6),
              Text(r["hour"],
                  style: const TextStyle(
                      fontWeight: FontWeight.w600)),
              const Spacer(),
              if (isMarked) _statusChip(),
            ],
          ),


          const SizedBox(height: 6),
          Text(r["time"],
              style: const TextStyle(color: Colors.grey)),


          const SizedBox(height: 14),


          // subject grid
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                _infoCol("Subject", r["subject"]),
                _infoCol("Code", r["code"]),
                _infoCol("Year", r["year"]),
                _infoCol("Total", "$total"),
              ],
            ),
          ),


          const SizedBox(height: 8),


          Wrap(
            spacing: 8,
            children: deptCounts.entries.map((e) {
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius:
                      BorderRadius.circular(20),
                ),
                child: Text("${e.key}: ${e.value}"),
              );
            }).toList(),
          ),


          const SizedBox(height: 14),


          Row(
            children: [
              _pill(
                  "Present: $present",
                  Colors.green.shade100,
                  Colors.green),
              const SizedBox(width: 8),
              _pill(
                  "Absent: $absent",
                  Colors.red.shade100,
                  Colors.red),
              const Spacer(),
              Text(
                "${percent.toStringAsFixed(0)}%",
                style: const TextStyle(
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),


          const SizedBox(height: 14),


  SizedBox(
    width: double.infinity,
    height: 44,
    child: ElevatedButton.icon(


    icon: Icon(
  isMarked ? Icons.remove_red_eye : Icons.edit,
      size: 18,
      color: const Color.fromARGB(255, 16, 16, 16),
    ),


   label: Text(
  isMarked ? "View Attendance" : "Mark Attendance",
      style: const TextStyle(
        color: Color.fromARGB(255, 11, 5, 36),
        fontWeight: FontWeight.w600,
      ),
    ),


    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFF3F0FF),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
    ),


    onPressed: () => _openDialog(r),
  ),
),


        ],
      ),
    );
  }


  Widget _breakCard(Map<String, dynamic> r) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(r["hour"],
              style:
                  const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(r["time"]),
        ],
      ),
    );
  }


  // ================= DIALOG =================


  void _openDialog(Map<String, dynamic> record) async {
    final snap = await FirebaseFirestore.instance
        .collection("attendance")
        .doc(record["id"])
        .get();


    final students =
        Map<String, dynamic>.from(snap["students"]);


    final bool canEdit =
    _service.canEditAttendance(record["time"]);


showDialog(
  context: context,
  builder: (_) => _AttendanceDialog(
    hour: record["hour"],
    subject: record["subject"] ?? "",
    code: record["code"] ?? "",
    year: record["year"] ?? "",
    students: students,
    canEdit: canEdit,
    onSubmit: (updated) async {
      await _service.updateAttendance(record["id"], updated);
      Navigator.pop(context);
      _load();
    },
  ),
);


  }


  // ================= HELPERS =================


  Widget _statusChip() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        "Marked",
        style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w600),
      ),
    );
  }


  Widget _pill(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child:
          Text(text, style: TextStyle(color: fg)),
    );
  }


  Widget _infoCol(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                fontWeight: FontWeight.w600)),
      ],
    );
  }
}


// ================= DEPT COUNT =================


Map<String, int> _deptCounts(
    Map<String, dynamic> students) {
  final Map<String, int> counts = {};


  students.forEach((_, s) {
    final dept = s["dept"] ?? "Unknown";
    counts[dept] = (counts[dept] ?? 0) + 1;
  });


  return counts;
}


// ===================================================


class _AttendanceDialog extends StatefulWidget {
  final String hour;
  final String subject;
  final String code;
  final String year;


  final Map<String, dynamic> students;
  final Function(Map<String, dynamic>) onSubmit;
final bool canEdit;


  const _AttendanceDialog({
  required this.hour,
  required this.subject,
  required this.code,
  required this.year,
  required this.students,
  required this.onSubmit,
  required this.canEdit,
});




  @override
  State<_AttendanceDialog> createState() =>
      _AttendanceDialogState();
     


}


class _AttendanceDialogState
    extends State<_AttendanceDialog> {
  late Map<String, dynamic> students;


  @override
  void initState() {
    super.initState();
    students = Map.from(widget.students);
  }


  int get presentCount =>
      students.values.where((s) => s["present"] == true).length;


  int get absentCount =>
      students.length - presentCount;
      Map<String, int> get deptCount {
  final Map<String, int> map = {};


  students.forEach((_, s) {
    final d = s["dept"] ?? "Unknown";
    map[d] = (map[d] ?? 0) + 1;
  });


  return map;
}




  void markAll(bool val) {
    setState(() {
      for (var s in students.values) {
        s["present"] = val;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18)),
      child: SizedBox(
        height: 600,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            // ================= HEADER =================


            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mark Attendance - ${widget.hour}",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${widget.subject} (${widget.code}) • ${widget.year}",
                    style: const TextStyle(
                        color: Colors.grey),
                  ),
                ],
              ),
            ),


            const SizedBox(height: 8),


            // ================= SUMMARY =================


           Container(
  margin: const EdgeInsets.symmetric(horizontal: 16),
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.grey.shade100,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: Colors.grey.shade300),
  ),
  child: Column(
    children: [


      // ==== TOP COUNTS ====
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _stat("Total Students", students.length),
          _stat("Present", presentCount, Colors.green),
          _stat("Absent", absentCount, Colors.red),
        ],
      ),


      const SizedBox(height: 12),


      // ==== DEPT COUNTS ====
      Wrap(
        spacing: 10,
        runSpacing: 6,
        children: deptCount.entries.map((e) {
          return Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(
              "${e.key}: ${e.value} students",
              style: const TextStyle(fontSize: 12),
            ),
          );
        }).toList(),
      ),
    ],
  ),
),




            const SizedBox(height: 12),


            // ================= MARK ALL =================
           if (widget.canEdit)
           Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16),
  child: Row(
    children: [


      Expanded(
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            side: const BorderSide(color: Colors.deepPurple),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () => markAll(true),
          child: const Text(
            "Mark All Present",
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),


      const SizedBox(width: 14),


      Expanded(
  child: OutlinedButton(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 12),


      side: const BorderSide(color: Colors.deepPurple),


      backgroundColor:
          const Color.fromARGB(255, 245, 245, 246).withOpacity(0.06),


      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    onPressed: () => markAll(false),
    child: const Text(
      "Mark All Absent",
      style: TextStyle(
        color: Colors.deepPurple,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
),




    ],
  ),
),


const SizedBox(height: 14),




            // ================= STUDENT LIST =================


           Expanded(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [


      // ================= STUDENT LIST TITLE =================


      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Text(
          "Students List",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),


      // ================= TABLE CONTAINER =================


      Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: ListView(
            children: students.entries.map((e) {
              final s = e.value;
              final present = s["present"] == true;


              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: Colors.grey.shade200),
                  ),
                ),
                child: Row(
                  children: [


                    // ================= NAME COLUMN =================


                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            s["name"],
                            style: const TextStyle(
                                fontWeight:
                                    FontWeight.w600),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "${e.key} • ${s["dept"]}",
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),


                    // ================= STATUS + SWITCH =================


                    Row(children: [
                      Text(
                        present ? "Present" : "Absent",
                        style: TextStyle(
                          color: present
                              ? Colors.green
                              : Colors.red,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 10),
                     if (widget.canEdit)
  Switch(
    value: present,
    activeColor: Colors.green,
    onChanged: (val) {
      setState(() {
        s["present"] = val;
      });
    },
  ),


                    ])
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    ],
  ),
),


            // ================= SUBMIT =================


           Padding(
  padding: const EdgeInsets.all(16),
  child: SizedBox(
    width: double.infinity,
    height: 48,
    child: ElevatedButton.icon(
      icon: const Icon(Icons.check_circle_outline,
          color: Colors.white),


      label: const Text(
        "Submit Attendance",
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),


      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),


      onPressed:
    widget.canEdit ? () => widget.onSubmit(students) : null,


    ),
  ),
),


          ],
        ),
      ),
    );
  }


  static Widget _stat(String label, int v,
      [Color? c]) {
    return Column(
      children: [
        Text(label,
            style: const TextStyle(
                color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          "$v",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: c,
          ),
        ),
      ],
    );
  }
}
