import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HODMarkAttendanceScreen extends StatelessWidget {
  const HODMarkAttendanceScreen({super.key});
  

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.grey[50],

    // ================= APP BAR =================
    appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hourly Attendance",
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          Text(
            "Mark attendance for each class hour",
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ),

    // ================= BODY =================
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          _infoBox(),
          const SizedBox(height: 20),

          _hourCardMarked(
            context,
            hour: "1st Hour",
            time: "09:00 - 10:00",
            subject: "Data Structures",
            code: "CS501",
            year: "2nd Year",
            total: "45",
            cse: "30",
            it: "15",
            present: "42",
            absent: "3",
            percent: "93%",
          ),

          _hourCardMarked(
            context,
            hour: "2nd Hour",
            time: "10:00 - 11:00",
            subject: "Algorithms",
            code: "CS502",
            year: "3rd Year",
            total: "38",
            present: "36",
            absent: "2",
            percent: "95%",
          ),

          _breakCard("Interval", "11:00 - 11:15", "Break"),

          _hourCardPending(
            context,
            hour: "3rd Hour",
            time: "11:15 - 12:15",
            subject: "Database Systems",
            code: "CS503",
            year: "Final Year",
            total: "42",
          ),

          _hourCardPending(
            context,
            hour: "4th Hour",
            time: "12:15 - 13:15",
            subject: "Operating Systems",
            code: "CS505",
            year: "3rd Year",
            total: "35",
          ),

          _breakCard("Lunch Break", "13:15 - 14:15", "Lunch"),

          _hourCardPending(
            context,
            hour: "5th Hour",
            time: "14:15 - 15:15",
            subject: "Web Development",
            code: "CS504",
            year: "1st Year",
            total: "50",
            cse: "30",
            it: "20",
          ),

          _hourCardUpcoming(
            hour: "6th Hour",
            time: "15:15 - 16:15",
            subject: "Computer Networks",
            code: "CS506",
            year: "2nd Year",
            total: "40",
          ),

          const SizedBox(height: 40),
        ],
      ),
    ),
  );
}

  }

  

  // ---------------- INFO BOX ----------------
  Widget _infoBox() => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue.shade100),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.blue.shade700),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Hod Hourly Attendance\nMark attendance per hour.Once marked,you can only view it.',
                style:
                    GoogleFonts.inter(color: Colors.blue.shade800, fontSize: 13.5),
              ),
            ),
          ],
        ),
      );

  // ---------------- CARD FACTORIES (they require context to show dialogs) ----------------
  Widget _hourCardMarked(BuildContext context,
          {required String hour,
          required String time,
          required String subject,
          required String code,
          required String year,
          required String total,
          String? cse,
          String? it,
          required String present,
          required String absent,
          required String percent}) =>
      _hourCardTemplate(
        context: context,
        hour: hour,
        time: time,
        subject: subject,
        code: code,
        year: year,
        total: total,
        tag: "Marked",
        tagColor: Colors.green,
        tagBg: Colors.green.shade50,
        buttonLabel: "View Attendance",
        buttonColor: Colors.white,
        textColor: Colors.black,
        showStats: true,
        present: present,
        absent: absent,
        percent: percent,
        cse: cse,
        it: it,
      );

  Widget _hourCardPending(BuildContext context,
          {required String hour,
          required String time,
          required String subject,
          required String code,
          required String year,
          required String total,
          String? cse,
          String? it}) =>
      _hourCardTemplate(
        context: context,
        hour: hour,
        time: time,
        subject: subject,
        code: code,
        year: year,
        total: total,
        tag: "Pending",
        tagColor: Colors.orange,
        tagBg: Colors.orange.shade50,
        buttonLabel: "Mark Attendance",
        buttonColor: Colors.black,
        textColor: Colors.white,
        showStats: false,
        cse: cse,
        it: it,
      );

  Widget _hourCardUpcoming(
          {required String hour,
          required String time,
          required String subject,
          required String code,
          required String year,
          required String total}) =>
      _hourCardTemplate(
        context: null,
        hour: hour,
        time: time,
        subject: subject,
        code: code,
        year: year,
        total: total,
        tag: "Upcoming",
        tagColor: Colors.blue,
        tagBg: Colors.blue.shade50,
        buttonLabel: "Not Available",
        buttonColor: Colors.grey,
        textColor: Colors.white,
        showStats: false,
      );

  // ------------------- BREAK CARD -------------------
  Widget _breakCard(String title, String time, String tag) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Icon(Icons.access_time, color: Colors.grey[700]),
              const SizedBox(width: 6),
              Text(title,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600, fontSize: 15)),
            ]),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8)),
              child: Text(tag,
                  style: GoogleFonts.inter(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                      fontSize: 12)),
            )
          ]),
          const SizedBox(height: 4),
          Text(time, style: GoogleFonts.inter(color: Colors.grey[700])),
        ],
      ),
    );
  }

  // ---------------- CARD TEMPLATE ----------------
  Widget _hourCardTemplate({
    required BuildContext? context,
    required String hour,
    required String time,
    required String subject,
    required String code,
    required String year,
    required String total,
    required String tag,
    required Color tagColor,
    required Color tagBg,
    required String buttonLabel,
    required Color buttonColor,
    required Color textColor,
    required bool showStats,
    String? present,
    String? absent,
    String? percent,
    String? cse,
    String? it,
  }) {
    // if context is null (for upcoming) we simply render the design with disabled button behavior
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            Icon(Icons.access_time, color: tagColor, size: 20),
            const SizedBox(width: 6),
            Text(hour,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600, fontSize: 15)),
          ]),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: tagBg, borderRadius: BorderRadius.circular(8)),
            child: Text(tag,
                style: GoogleFonts.inter(
                    color: tagColor, fontWeight: FontWeight.w600, fontSize: 12)),
          ),
        ]),
        const SizedBox(height: 4),
        Text(time, style: GoogleFonts.inter(color: Colors.grey[700], fontSize: 13)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(children: [
            Row(children: [
              Expanded(child: Text("Subject\n$subject", style: GoogleFonts.inter(fontSize: 13.5))),
              Expanded(child: Text("Subject Code\n$code", style: GoogleFonts.inter(fontSize: 13.5))),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(child: Text("Class Year\n$year", style: GoogleFonts.inter(fontSize: 13.5))),
              Expanded(child: Text("Total Students\n$total", style: GoogleFonts.inter(fontSize: 13.5))),
            ]),
            if (cse != null && it != null) ...[
              const SizedBox(height: 8),
              Row(children: [
                Text("Department-wise:", style: GoogleFonts.inter(fontSize: 13)),
                const SizedBox(width: 8),
                _deptChip("CSE: $cse"),
                const SizedBox(width: 6),
                _deptChip("IT: $it"),
              ])
            ],
          ]),
        ),
        if (showStats) ...[
          const SizedBox(height: 10),
          Row(children: [
            _statusChip("Present: $present", Colors.green),
            const SizedBox(width: 8),
            _statusChip("Absent: $absent", Colors.redAccent),
            const Spacer(),
            Text(percent ?? "", style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: Colors.green)),
          ])
        ],
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: Builder(
            builder: (bContext) {
              final btnOnPressed = (context == null)
                  ? null
                  : () {
                      if (buttonLabel == "View Attendance") {
                        _showViewAttendanceDialog(context);
                      } else if (buttonLabel == "Mark Attendance") {
                        _showMarkAttendanceDialog(context, hour: hour, subject: subject, code: code, year: year, total: total, cse: cse, it: it);
                      }
                    };

              // choose icon color for white button
              final iconColor = (buttonColor == Colors.white) ? Colors.black87 : Colors.white;

              return ElevatedButton.icon(
                onPressed: btnOnPressed,
                icon: Icon(
                  buttonLabel == "View Attendance" ? Icons.visibility_outlined : (buttonLabel == "Not Available" ? Icons.block : Icons.person_outline),
                  size: 18,
                  color: iconColor,
                ),
                label: Text(buttonLabel, style: GoogleFonts.inter(color: textColor, fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              );
            },
          ),
        )
      ]),
    );
  }

  // ---------------------- HELPERS ----------------------
  Widget _deptChip(String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(text, style: GoogleFonts.inter(fontSize: 12, color: Colors.black87)),
      );

  Widget _statusChip(String text, Color color) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
        child: Text(text, style: GoogleFonts.inter(color: color, fontWeight: FontWeight.w600, fontSize: 12)),
      );

  Widget _summaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: GoogleFonts.inter(color: Colors.grey[700], fontSize: 13)),
        const SizedBox(height: 4),
        Text(value, style: GoogleFonts.inter(color: color, fontWeight: FontWeight.w700)),
      ],
    );
  }

  // ---------------------- DIALOGS ----------------------

  // View Attendance dialog (matches your screenshots)
  void _showViewAttendanceDialog(BuildContext context) {
    // dummy list: 45 students; first 30 CSE then 15 IT; last 3 absent as in screenshot
    final students = List.generate(45, (index) {
      final isIT = index >= 30;
      final name = isIT
          ? [
              'Pooja Joshi',
              'Rakesh Mehta',
              'Simran Verma',
              'Tarun Das',
              'Varun Agarwal',
              'Zoya Prasad',
              'Sonal Patel',
              'Nikhil Roy',
              'Ritika Jain',
              'Adil Khan',
              'Maya Singh',
              'Zeenat Ali',
              'Karan Mehra',
              'Ria Kapoor',
              'Vikram S.'
            ][index - 30] // pick names for IT (15)
          : [
              'Aarav Kumar',
              'Advait Sharma',
              'Ananya Patel',
              'Arjun Reddy',
              'Diya Singh',
              'Ishaan Gupta',
              'Kavya Nair',
              'Krishna Iyer',
              'Meera Desai',
              'Nisha Joshi',
              'Pranav Mehta',
              'Riya Verma'
            ][index % 12];

      return {
        'name': name,
        'roll': isIT ? 'IT${(index - 29).toString().padLeft(3, '0')}' : 'CSE${(index + 1).toString().padLeft(3, '0')}',
        'dept': isIT ? 'IT' : 'CSE',
        'status': index >= 42 ? 'Absent' : 'Present',
      };
    });

    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(16),
          constraints: const BoxConstraints(maxHeight: 600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text("View Attendance - 1st Hour", style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 16)),
                      Text("Data Structures (CS501) • 2nd Year", style: GoogleFonts.inter(color: Colors.grey[700], fontSize: 13.5)),
                    ]),
                  ),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: Colors.black54))
                ],
              ),
              const SizedBox(height: 12),


              // Summary card
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade300)),
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    _summaryItem("Total Students", "45", Colors.black87),
                    _summaryItem("Present", "42", Colors.green),
                    _summaryItem("Absent", "3", Colors.redAccent),
                  ]),
                  const SizedBox(height: 8),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [_deptChip("CSE: 30 students"), _deptChip("IT: 15 students")]),
                ]),
              ),
              const SizedBox(height: 14),


              Text("Student List", style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15)),
              const SizedBox(height: 10),


              // Student list scroll area
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade300)),
                  child: Scrollbar(
                    thumbVisibility: true,
                    radius: const Radius.circular(10),
                    thickness: 8,
                    child: ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final s = students[index];
                        final isPresent = s['status'] == 'Present';
                        final bg = isPresent ? Colors.green.withOpacity(0.06) : Colors.red.withOpacity(0.05);
                        final tagColor = isPresent ? Colors.green : Colors.redAccent;
                        return Container(
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300)), color: bg),
                          child: ListTile(
                            dense: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            title: Text("${index + 1}. ${s['name']}", style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14)),
                            subtitle: Text("${s['roll']} • ${s['dept']}", style: GoogleFonts.inter(color: Colors.grey[700], fontSize: 13)),
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(color: tagColor, borderRadius: BorderRadius.circular(20)),
                              child: Text(s['status'] ?? "Absent", style: GoogleFonts.inter(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w600)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  // Mark Attendance dialog (interactive, toggles present/absent)
  void _showMarkAttendanceDialog(BuildContext context,
      {required String hour, required String subject, required String code, required String year, required String total, String? cse, String? it}) {
    // sample 50 students (first 30 CSE then 20 IT)
    List<Map<String, dynamic>> students = List.generate(50, (index) {
      final isIT = index >= 30;
      final name = isIT
          ? [
              'Yug Reddy',
              'Ziya Singh',
              'Avi Ali',
              'Bina Iyer',
              'Chirag Nair',
              'Divit Das',
              'Rohit S.',
              'Sneha P.',
              'Ankit K.',
              'Reema L',
              'Tarun B.',
              'Shweta N',
              'Vishal M',
              'Nikita R',
              'Gaurav P',
              'Sonal D',
              'Rakesh H',
              'Naveen K',
              'Pooja V',
              'Ritu S'
            ][index - 30]
          : [
              'Aarushi Shah',
              'Ayaan Malik',
              'Bhumi Patel',
              'Dev Sharma',
              'Eesha Singh',
              'Faiz Khan',
              'Gargi Nair',
              'Harsh Pillai',
              'Ira Reddy',
              'Jiya Iyer',
              'Kiaan Desai',
              'Lina Joshi',
              'Mukul Rao',
              'Nisha S.',
              'Ojas K',
              'Pallavi T',
              'Qasim A',
              'Riya G',
              'Sahil D',
              'Tina M',
              'Uday P',
              'Vani R',
              'Waseem Z',
              'Xenia L',
              'Yash N',
              'Zara K',
              'Abhay R',
              'Bipin S',
              'Chetan D',
              'Dipti V'
            ][index % 30]; // fallback


      return {
        'name': name,
        'roll': isIT ? 'IT${(index - 29).toString().padLeft(3, '0')}' : 'CSE${(index + 1).toString().padLeft(3, '0')}',
        'dept': isIT ? 'IT' : 'CSE',
        'present': false, // default absent
      };
    });


    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          int presentCount = students.where((s) => s['present']).length;
          int absentCount = students.length - presentCount;


          void markAll(bool val) {
            setState(() {
              for (var s in students) s['present'] = val;
            });
          }


          return Dialog(
            insetPadding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Container(
              padding: const EdgeInsets.all(16),
              constraints: const BoxConstraints(maxHeight: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // header
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text("Mark Attendance - $hour", style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 16)),
                        Text("$subject ($code) • $year", style: GoogleFonts.inter(color: Colors.grey[700], fontSize: 13.5)),
                      ]),
                    ),
                    IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: Colors.black54))
                  ]),
                  const SizedBox(height: 12),


                  // summary
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade300)),
                    child: Column(children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                        _summaryItem("Total Students", students.length.toString(), Colors.black87),
                        _summaryItem("Present", presentCount.toString(), Colors.green),
                        _summaryItem("Absent", absentCount.toString(), Colors.red),
                      ]),
                      const SizedBox(height: 8),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                        _deptChip("CSE: ${cse ?? '30'} students"),
                        _deptChip("IT: ${it ?? '20'} students"),
                      ])
                    ]),
                  ),
                  const SizedBox(height: 12),


                  // mark all buttons
                  Row(children: [
                    Expanded(
                        child: OutlinedButton(
                      onPressed: () => markAll(true),
                      style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey.shade400)),
                      child: Text("Mark All Present", style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                    )),
                    const SizedBox(width: 10),
                    Expanded(
                        child: OutlinedButton(
                      onPressed: () => markAll(false),
                      style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey.shade400)),
                      child: Text("Mark All Absent", style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                    )),
                  ]),
                  const SizedBox(height: 12),


                  Text("Student List", style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15)),
                  const SizedBox(height: 8),


                  // list
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade300)),
                      child: Scrollbar(
                        thumbVisibility: true,
                        radius: const Radius.circular(10),
                        thickness: 8,
                        child: ListView.builder(
                          itemCount: students.length,
                          itemBuilder: (context, index) {
                            final s = students[index];
                            final isPresent = s['present'] as bool;
                            return Container(
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
                              child: ListTile(
                                dense: true,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                title: Text("${index + 1}. ${s['name']}", style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14)),
                                subtitle: Text("${s['roll']} • ${s['dept']}", style: GoogleFonts.inter(color: Colors.grey[700], fontSize: 13)),
                                trailing: FittedBox(
                               fit: BoxFit.scaleDown,
                                child: Row(
                               mainAxisSize: MainAxisSize.min,
                                children: [
                                 Text(isPresent ? "Present" : "Absent",
                                style: GoogleFonts.inter(
                                     color: isPresent ? Colors.green : Colors.red,
                                   fontWeight: FontWeight.w600,
                                    ),),
                                  const SizedBox(width: 6),
                                  Transform.scale(scale: 0.8,
                               child: Switch(
                               value: isPresent,
                                   activeColor: Colors.white,
                                 activeTrackColor: Colors.green,
                                 inactiveThumbColor: Colors.white,
                                 inactiveTrackColor: const Color.fromARGB(255, 184, 182, 182),
                                 materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  onChanged: (val) {
                                  setState(() {
                                 s['present'] = val;
                                });
                              },),
                                  ),
                              ],),),
                              ),
                            );
                          },                      
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),


                  // submit
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Attendance Submitted")));
                      },
                      icon: const Icon(Icons.check_circle_outline, color: Colors.white),
                      label: Text("Submit Attendance", style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600)),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    ),
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }
