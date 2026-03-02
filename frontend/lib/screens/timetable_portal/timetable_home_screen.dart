import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TTHomeScreen(username: "Prof. John Smith"),
    );
  }
}


////////////////////////////////////////////////////////////
/// HOME SCREEN
////////////////////////////////////////////////////////////


class TTHomeScreen extends StatelessWidget {
  final String username;


  const TTHomeScreen({super.key, required this.username});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildQuickActions(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 26,
            backgroundColor: Colors.white,
            child: Icon(Icons.person_outline,
                color: Colors.blueAccent, size: 30),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, $username!',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'TT12345 • Time Table Admin',
                style: GoogleFonts.inter(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  ////////////////////////////////////////////////////////////
  /// QUICK ACTIONS (ERROR-FREE VERSION)
  ////////////////////////////////////////////////////////////


 Widget _buildQuickActions(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Quick Actions",
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 16),


      Row(
        children: [
          _quickAction(
            context,
            Icons.calendar_month_outlined,
            "Academic Calendar",
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AcademicCalendarScreen(),
                ),
              );
            },
          ),
          const SizedBox(width: 12),
          _quickAction(
  context,
  Icons.menu_book_outlined,
  "Subject Schedule",
  () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SubjectScheduleHomeScreen(),
      ),
    );
  },
),
        ],
      ),
    ],
  );
}
Widget _quickAction(
  BuildContext context,
  IconData icon,
  String title,
  VoidCallback onTap,
) {
  return Expanded(
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 28, color: Colors.black87),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}
////////////////////////////////////////////////////////////
/// ACADEMIC CALENDAR PAGE
////////////////////////////////////////////////////////////
class AcademicCalendarScreen extends StatelessWidget {
  const AcademicCalendarScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,


      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            const SizedBox(height: 6),


/// BACK BUTTON + TITLE
Row(
  children: [
    GestureDetector(
      onTap: () => Navigator.pop(context),
      child: const Icon(Icons.arrow_back),
    ),
    const SizedBox(width: 12),
    Text(
      'Academic Calendar',
      style: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
  ],
),


const SizedBox(height: 4),


Text(
  'View and manage academic calendar',
  style: GoogleFonts.inter(
    fontSize: 12,
    color: Colors.grey,
  ),
),


            const SizedBox(height: 20),


            /// =====================
            /// UNDERGRADUATE
            /// =====================
            Text(
              'Undergraduate',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),


            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _YearCard(
  title: '1st Year',
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AcademicSchedulingScreen(
          title: "UG 1st Year",
        ),
      ),
    );
  },
),
                _YearCard(
  title: '2nd Year',
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AcademicSchedulingScreen(
          title: "UG 2nd Year",
        ),
      ),
    );
  },
),
                _YearCard(
                  title: '3rd Year',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AcademicSchedulingScreen(
                          title: "UG 3rd Year",
                        ),
                      ),
                    );
                  },
                ),
                _YearCard(
                  title: '4th Year',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AcademicSchedulingScreen(
                          title: "UG 4th Year",
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),


            const SizedBox(height: 14),


            /// =====================
            /// POSTGRADUATE
            /// =====================
            Text(
              'Postgraduate',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),


            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _YearCard(
  title: '1st Year',
  isPostGraduate: true,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AcademicSchedulingScreen(
          title: "PG 1st Year",
        ),
      ),
    );
  },
),
                _YearCard(
                  title: '2nd Year',
                  isPostGraduate: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AcademicSchedulingScreen(
                          title: "PG 2nd Year",
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class _YearCard extends StatelessWidget {
  final String title;
  final bool isPostGraduate;
  final VoidCallback onTap;


  const _YearCard({
    required this.title,
    required this.onTap,
    this.isPostGraduate = false,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school,
              size: 28,
              color: isPostGraduate
                  ? Colors.purpleAccent
                  : Colors.blueAccent,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


////////////////////////////////////////////////////////////
/// UG YEAR PAGE
////////////////////////////////////////////////////////////


class UGCalendarScreen extends StatelessWidget {
  const UGCalendarScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return _BaseScaffold(
      title: "UG Academic Calendar",
      subtitle: "Select year",
      children: [
        _ugYear(context, "1st Year"),
        _ugYear(context, "2nd Year"),
        _ugYear(context, "3rd Year"),
        _ugYear(context, "4th Year"),
      ],
    );
  }


  Widget _ugYear(BuildContext context, String year) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: _ProgramCard(
        icon: Icons.calendar_month,
        iconColor: Colors.green,
        backgroundColor: const Color(0xFFE8F5E9),
        title: year,
        subtitle: "View $year calendar",
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => DepartmentScreen(title: "UG $year")));
        },
      ),
    );
  }
}


class AcademicSchedulingScreen extends StatefulWidget {
  final String title;


  const AcademicSchedulingScreen({super.key, required this.title});


  @override
  State<AcademicSchedulingScreen> createState() =>
      _AcademicSchedulingScreenState();
}


class _AcademicSchedulingScreenState
    extends State<AcademicSchedulingScreen> {
  final _formKey = GlobalKey<FormState>();


  int? semester;
  DateTime? startDate;
  DateTime? endDate;


  List<Map<String, dynamic>> holidays = [];
  List<Map<String, dynamic>> programs = [];
  int get totalHolidays => holidays.length;
int get totalPrograms => programs.length;
int get totalSundays {
  if (startDate == null || endDate == null) return 0;


  int count = 0;
  for (DateTime date = startDate!;
      date.isBefore(endDate!.add(const Duration(days: 1)));
      date = date.add(const Duration(days: 1))) {
    if (date.weekday == DateTime.sunday) {
      count++;
    }
  }
  return count;
}


  int workingDays = 0;
  bool _submitting = false;


  bool get isOdd =>
      semester != null && [1, 3, 5, 7].contains(semester);


  bool get isEven =>
      semester != null && [2, 4, 6, 8].contains(semester);


Future<DateTime?> _pickDate(
    DateTime first, DateTime last) async {
  return await showDatePicker(
    context: context,
    firstDate: first,
    lastDate: last,
    initialDate: first,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Colors.black,
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
          dialogBackgroundColor: Colors.white,
        ),
        child: child!,
      );
    },
  );
}
  void _calculateWorkingDays() {
    if (startDate == null || endDate == null) return;


    int count = 0;


    for (DateTime date = startDate!;
        date.isBefore(endDate!.add(const Duration(days: 1)));
        date = date.add(const Duration(days: 1))) {


      if (date.weekday == DateTime.sunday) continue;


      bool isHoliday = holidays.any((h) {
        DateTime d = h["date"];
        return d.year == date.year &&
            d.month == date.month &&
            d.day == date.day;
      });


      if (!isHoliday) count++;
    }


    setState(() => workingDays = count);
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      foregroundColor: Colors.black87,
      title: Text(
        widget.title,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(height: 1),
      ),
    ),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
            horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            /// ===== SEMESTER =====
            _sectionTitle("Semester"),
            const SizedBox(height: 7),
            DropdownButtonFormField<int>(
              value: semester,
              decoration: _cleanInputDecoration(),
              items: List.generate(
                8,
                (i) => DropdownMenuItem(
                  value: i + 1,
                  child: Text(
                    "Semester ${i + 1}",
                    style: GoogleFonts.inter(),
                  ),
                ),
              ),
              onChanged: (val) =>
                  setState(() => semester = val),
            ),


            if (semester != null) ...[
              const SizedBox(height: 8),
              Text(
                isOdd ? "Odd Semester" : "Even Semester",
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
            ],


            const SizedBox(height: 22),


            /// ===== START DATE =====
            _sectionTitle("Start Date"),
            const SizedBox(height: 7),
            _cleanDateField(
              value: startDate,
              hint: "Select start date",
              onTap: () async {
                final picked = await _pickDate(
                    DateTime(2023), DateTime(2035));
                if (picked != null) {
                  setState(() => startDate = picked);
                }
              },
            ),


            const SizedBox(height: 17),


            /// ===== EVENTS =====
            _sectionTitle("Academic Events"),
            const SizedBox(height: 10),


            Row(
  children: [
    Expanded(
      child: ElevatedButton(
        onPressed: () =>
            _showAddDialog(isHoliday: true),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF2F2F2),
          elevation: 0,
          padding:
              const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          "Add Holiday",
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
    const SizedBox(width: 12),
    Expanded(
      child: ElevatedButton(
        onPressed: () =>
            _showAddDialog(isHoliday: false),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF2F2F2),
          elevation: 0,
          padding:
              const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          "Add Program",
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  ],
),


            const SizedBox(height: 15),


/// =======================
/// HOLIDAY LIST
/// =======================
if (holidays.isNotEmpty) ...[
  _listHeader("Holiday List", totalHolidays),
  const SizedBox(height: 7),


  ...holidays.map(
    (e) => _minimalEventTile(
      title: e["title"],
      date: e["date"],
      type: "Holiday",
      onDelete: () {
        setState(() {
          holidays.remove(e);
          _calculateWorkingDays();
        });
      },
    ),
  ),


  const SizedBox(height: 8),
],


/// =======================
/// PROGRAM LIST
/// =======================
if (programs.isNotEmpty) ...[
  _listHeader("Program List", totalPrograms),
  const SizedBox(height: 7),


  ...programs.map(
    (e) => _minimalEventTile(
      title: e["title"],
      date: e["date"],
      type: "Program",
      onDelete: () {
        setState(() {
          programs.remove(e);
        });
      },
    ),
  ),
],
            const SizedBox(height: 8),


            /// ===== END DATE =====
            _sectionTitle("End Date"),
            const SizedBox(height: 5),
            _cleanDateField(
              value: endDate,
              hint: "Select end date",
              onTap: () async {
                if (startDate == null) return;
                final picked = await _pickDate(
                    startDate!, DateTime(2035));
                if (picked != null) {
                  setState(() => endDate = picked);
                  _calculateWorkingDays();
                }
              },
            ),


            const SizedBox(height: 17),




Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: const Color(0xFFF8F8F8),
    borderRadius: BorderRadius.circular(12),
  ),
  child: Column(
    children: [


      _summaryRow("Working Days", workingDays),
const SizedBox(height: 10),
_summaryRow("Sundays", totalSundays),
const SizedBox(height: 10),
_summaryRow("Declared Holidays", totalHolidays),
const SizedBox(height: 10),
_summaryRow("Total Programs", totalPrograms),
    ],
  ),
),


            const SizedBox(height: 10),


            /// ===== ACTIONS =====
            Row(
  children: [
    Expanded(
      child: ElevatedButton(
        onPressed: _pickPdf,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding:
              const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          "Upload PDF",
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
    const SizedBox(width: 14),
    Expanded(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding:
              const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          "Publish Calendar",
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  ],
),
          ],
        ),
      ),
    ),
  );
}
Widget _sectionTitle(String text) {
  return Text(
    text,
    style: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
  );
}


InputDecoration _cleanInputDecoration() {
  return InputDecoration(
    filled: true,
    fillColor: const Color(0xFFF5F5F5), // light grey
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
  );
}
Widget _summaryRow(String label, int value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 13,
          color: Colors.grey[700],
        ),
      ),
      Text(
        value.toString(),
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}
Widget _listHeader(String title, int count) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          count.toString(),
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );
}


Widget _cleanDateField({
  required DateTime? value,
  required String hint,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
  color: const Color(0xFFF5F5F5),
  borderRadius: BorderRadius.circular(8),
),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value == null
                ? hint
                : value.toString().split(' ')[0],
            style: GoogleFonts.inter(),
          ),
          const Icon(Icons.calendar_today,
              size: 18, color: Colors.grey),
        ],
      ),
    ),
  );
}


Widget _minimalEventTile({
  required String title,
  required DateTime date,
  required String type, // "Holiday" or "Program"
  required VoidCallback onDelete,
}) {
  final bool isHoliday = type == "Holiday";


  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 40,
              decoration: BoxDecoration(
                color: isHoliday ? Colors.red : Colors.blue,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "$type • ${date.toString().split(' ')[0]}",
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
        IconButton(
          onPressed: onDelete,
          icon: const Icon(Icons.close,
              size: 18, color: Colors.grey),
        ),
      ],
    ),
  );
}
Future<void> _pickPdf() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );


  if (result != null) {
    final file = result.files.first;


    // 30 KB = 30 * 1024 bytes
    const maxSize = 30 * 1024;


    if (file.size > maxSize) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "File must be less than 30 KB",
            style: GoogleFonts.inter(),
          ),
        ),
      );
      return;
    }


    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "PDF Selected: ${file.name}",
          style: GoogleFonts.inter(),
        ),
      ),
    );


    // TODO: Upload to backend here
  }
}
Future<void> _showAddDialog({required bool isHoliday}) async {
  if (startDate == null) return;


  DateTime? selectedDate;
  TextEditingController titleCtrl = TextEditingController();


  await showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.2),
    builder: (_) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 24, vertical: 24),
          child: StatefulBuilder(
            builder: (context, setDialogState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  /// Title
                  Text(
                    isHoliday ? "Add Holiday" : "Add Program",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),


                  const SizedBox(height: 6),


                  Text(
                    isHoliday
                        ? "Create a holiday entry"
                        : "Create a program or exam entry",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),


                  const SizedBox(height: 24),


                  /// Name Field
                  TextField(
                    controller: titleCtrl,
                    decoration: InputDecoration(
                      hintText: isHoliday
                          ? "Holiday name"
                          : "Program title",
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      contentPadding:
                          const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),


                  const SizedBox(height: 16),


                  /// Date Picker Button
                  InkWell(
                    onTap: () async {
                      final picked = await _pickDate(
                        startDate!,
                        endDate ?? DateTime(2035),
                      );
                      if (picked != null) {
                        setDialogState(() {
                          selectedDate = picked;
                        });
                      }
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
                        children: [
                          Text(
                            selectedDate == null
                                ? "Select Date"
                                : selectedDate!
                                    .toString()
                                    .split(' ')[0],
                            style: GoogleFonts.inter(),
                          ),
                          const Icon(
                            Icons.calendar_today,
                            size: 18,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  ),


                  const SizedBox(height: 28),


                  /// Buttons Row
                  Row(
                    children: [


                      /// Cancel
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () =>
                              Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color:
                                    Colors.grey.shade300),
                            padding:
                                const EdgeInsets.symmetric(
                                    vertical: 14),
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                      10),
                            ),
                          ),
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.inter(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),


                      const SizedBox(width: 12),


                      /// Add Button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (titleCtrl
                                    .text.isNotEmpty &&
                                selectedDate != null) {
                              setState(() {
                                if (isHoliday) {
                                  holidays.add({
                                    "title":
                                        titleCtrl.text,
                                    "date":
                                        selectedDate
                                  });
                                } else {
                                  programs.add({
                                    "title":
                                        titleCtrl.text,
                                    "date":
                                        selectedDate
                                  });
                                }
                              });


                              Navigator.pop(context);
                              _calculateWorkingDays();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.black,
                            padding:
                                const EdgeInsets.symmetric(
                                    vertical: 14),
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                      10),
                            ),
                          ),
                          child: Text(
                            "Add",
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      );
    },
  );
}  Widget _label(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );
  }


  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFFF6F7F9),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }


  Widget _dateButton(
      {required String text, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F7F9),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(text, style: GoogleFonts.inter()),
      ),
    );
  }
}


class SubjectScheduleHomeScreen extends StatelessWidget {
  const SubjectScheduleHomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            const SizedBox(height: 6),


            /// BACK + TITLE
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 12),
                Text(
                  'Subject Schedule',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),


            const SizedBox(height: 20),


            /// =====================
            /// UNDERGRADUATE
            /// =====================
            Text(
              'Undergraduate',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),


            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _SubjectYearCard(title: '1st Year', program: "UG"),
                _SubjectYearCard(title: '2nd Year', program: "UG"),
                _SubjectYearCard(title: '3rd Year', program: "UG"),
                _SubjectYearCard(title: '4th Year', program: "UG"),
              ],
            ),


            const SizedBox(height: 16),


            /// =====================
            /// POSTGRADUATE
            /// =====================
            Text(
              'Postgraduate',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),


            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _SubjectYearCard(title: '1st Year', program: "PG"),
                _SubjectYearCard(title: '2nd Year', program: "PG"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class _SubjectYearCard extends StatelessWidget {
  final String title;
  final String program;


  const _SubjectYearCard({
    required this.title,
    required this.program,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SubjectEntryScreen(
                title: "$program $title",
              ),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.menu_book, size: 26),
            const SizedBox(height: 6),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class SubjectEntryScreen extends StatelessWidget {
  final String title;


  const SubjectEntryScreen({super.key, required this.title});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text(
          title,
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1),
        ),
      ),
      body: const Center(
        child: Text("Subject entry form here"),
      ),
    );
  }
}
////////////////////////////////////////////////////////////
/// DEPARTMENT PAGE (FOR UG YEARS)
////////////////////////////////////////////////////////////


class DepartmentScreen extends StatelessWidget {
  final String title;


  const DepartmentScreen({super.key, required this.title});


  @override
  Widget build(BuildContext context) {
    return _BaseScaffold(
     
      title: title,
      subtitle: "Select department",
      children: const [
        DepartmentCard("Computer Science", "CSC Department",
            Colors.blue, Color(0xFFE3F2FD)),
        DepartmentCard("Information Technology", "IT Department",
            Colors.green, Color(0xFFE8F5E9)),
        DepartmentCard("Cyber Security", "Cyber Department",
            Colors.red, Color(0xFFFFEBEE)),
        DepartmentCard("AI & Data Science", "AIDS Department",
            Colors.deepPurple, Color(0xFFF3E8FF)),
        DepartmentCard("Electronics & Communication", "ECE Department",
            Colors.orange, Color(0xFFFFF3E0)),
      ],
    );
  }
}


class DepartmentCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color iconColor;
  final Color bgColor;


  const DepartmentCard(
      this.title, this.subtitle, this.iconColor, this.bgColor,
      {super.key});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: _ProgramCard(
        icon: Icons.menu_book,
        iconColor: iconColor,
        backgroundColor: bgColor,
        title: title,
        subtitle: subtitle,
        onTap: () {},
      ),
    );
  }
}


////////////////////////////////////////////////////////////
/// PG PROGRAM PAGE
////////////////////////////////////////////////////////////


class PGCalendarScreen extends StatelessWidget {
  const PGCalendarScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return _BaseScaffold(
      title: "PG Academic Calendar",
      subtitle: "Select program",
      children: [
        _ProgramCard(
          icon: Icons.school,
          iconColor: Colors.purple,
          backgroundColor: const Color(0xFFF3E8FF),
          title: "MBA",
          subtitle: "Master of Business Administration",
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const PGYearScreen(title: "MBA Academic Calendar")));
          },
        ),
        const SizedBox(height: 16),
        _ProgramCard(
          icon: Icons.school,
          iconColor: Colors.blue,
          backgroundColor: const Color(0xFFE3F2FD),
          title: "M.E",
          subtitle: "Master of Engineering",
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const PGYearScreen(title: "ME Academic Calendar")));
          },
        ),
      ],
    );
  }
}


////////////////////////////////////////////////////////////
/// PG YEAR PAGE (MBA & ME)
////////////////////////////////////////////////////////////


class PGYearScreen extends StatelessWidget {
  final String title;


  const PGYearScreen({super.key, required this.title});


  @override
  Widget build(BuildContext context) {
    return _BaseScaffold(
      title: title,
      subtitle: "Select year",
      children: const [
        YearCard("1st Year"),
        YearCard("2nd Year"),
      ],
    );
  }
}


class YearCard extends StatelessWidget {
  final String year;


  const YearCard(this.year, {super.key});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: _ProgramCard(
        icon: Icons.calendar_month,
        iconColor: Colors.green,
        backgroundColor: const Color(0xFFE8F5E9),
        title: year,
        subtitle: "View $year calendar",
        onTap: () {},
      ),
    );
  }
}


////////////////////////////////////////////////////////////
/// BASE SCAFFOLD
////////////////////////////////////////////////////////////


class _BaseScaffold extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;


  const _BaseScaffold({
    required this.title,
    required this.subtitle,
    required this.children,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                      Text(subtitle,
                          style: GoogleFonts.inter(
                              fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(children: children),
              ),
            )
          ],
        ),
      ),
    );
  }
}


////////////////////////////////////////////////////////////
/// REUSABLE CARD
////////////////////////////////////////////////////////////


class _ProgramCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;


  const _ProgramCard({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: GoogleFonts.inter(
                          fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}