import 'package:flutter/material.dart';

class ExamCellExamScreen extends StatelessWidget {
  const ExamCellExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// Allow Internals
            _buildCard(
              context,
              title: "Allow Internals",
              subtitle: "Enable internal exam marks entry",
              icon: Icons.verified_user_outlined,
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AllowInternalsScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

 /// Schedule Exam
_buildCard(
  context,
  title: "Schedule Exam",
  subtitle: "Create and schedule a new exam",
  icon: Icons.event_available_outlined,
  color: Colors.orange,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ProgramSelectionScreen(), // ✅ UPDATED
      ),
    );
  },
),

            const SizedBox(height: 16),

            /// Scheduled Exams
            _buildCard(
              context,
              title: "Scheduled Exams",
              subtitle: "View all scheduled exams",
              icon: Icons.list_alt_outlined,
              color: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProgramSelectionScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(                     
    color: Colors.grey.shade300,          
    width: 1.2,
  ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}

/// ===============================
/// COMMON PROGRAM UI (UI ONLY)
/// ===============================

class _ProgramScreen extends StatelessWidget {
  final String title;
  final VoidCallback onUGTap;
  final VoidCallback onPGTap;

  const _ProgramScreen({
    required this.title,
    required this.onUGTap,
    required this.onPGTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildCard("UG (Undergraduate)", Colors.blue, onUGTap),
            const SizedBox(height: 20),
            _buildCard("PG (Postgraduate)", Colors.green, onPGTap),
          ],
        ),
      ),
    );
  }

 Widget _buildCard(String text, Color color, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(14),
    child: Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.school_outlined,
            color: color,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text, 
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey.shade600,
          ),
        ],
      ),
    ),
  );
}
}

/// ===============================
/// ALLOW INTERNALS (GRID STYLE)
/// ===============================

class AllowInternalsScreen extends StatelessWidget {
  const AllowInternalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Allow Internals"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// ===============================
            /// UNDERGRADUATE SECTION
            /// ===============================

            const Text(
              "Undergraduate",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 16),

            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [

                _buildYearCard(context, "UG", "1st Year", Colors.blue),
                _buildYearCard(context, "UG", "2nd Year", Colors.blue),
                _buildYearCard(context, "UG", "3rd Year", Colors.blue),
                _buildYearCard(context, "UG", "4th Year", Colors.blue),

              ],
            ),

            const SizedBox(height: 32),

            /// ===============================
            /// POSTGRADUATE SECTION
            /// ===============================

            const Text(
              "Postgraduate",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 16),

            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [

                _buildYearCard(context, "PG", "1st Year", Colors.purple),
                _buildYearCard(context, "PG", "2nd Year", Colors.purple),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYearCard(
      BuildContext context,
      String program,
      String year,
      Color color,
      ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => InternalTypeScreen(
              programYear: "$program - $year",
            ),
          ),
        );
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            CircleAvatar(
              radius: 26,
              backgroundColor: color.withOpacity(0.15),
              child: Icon(
                Icons.school,
                color: color,
                size: 24,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              year,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

  Widget _buildProgramCard(
    BuildContext context, {
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 65,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.school_outlined, color: color),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

/// ===============================
/// SCHEDULE EXAM (CLEAN & CORRECT)
/// ===============================

class ScheduleExamDetailsScreen extends StatefulWidget {
  final String program;

  const ScheduleExamDetailsScreen({
    super.key,
    required this.program,
  });

  @override
  State<ScheduleExamDetailsScreen> createState() =>
      _ScheduleExamDetailsScreenState();
}

class _ScheduleExamDetailsScreenState
    extends State<ScheduleExamDetailsScreen> {

  /// 🔹 Internal Assessment
  String selectedInternal = "Internal Assessment 1";

  final List<String> internalOptions = [
    "Internal Assessment 1",
    "Internal Assessment 2",
    "Model",
  ];

  /// 🔹 Year Selection
  late List<String> yearOptions;
  late String selectedYear;

  /// 🔹 Department Selection
  late List<String> departmentOptions;
  late String selectedDepartment;

  /// 🔹 Dynamic Exam Forms
  final List<ExamFormModel> examForms = [ExamFormModel()];

  void addNewForm() {
    setState(() {
      examForms.add(ExamFormModel());
    });
  }

  void removeForm(int index) {
    setState(() {
      if (examForms.length > 1) {
        examForms.removeAt(index);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.program == "UG") {
      yearOptions = [
        "1st Year",
        "2nd Year",
        "3rd Year",
        "4th Year",
      ];

      departmentOptions = [
        "Information Technology",
        "Computer Science and Engineering",
        "Cyber Security",
        "Electronics and Communication Engineering",
        "Artificial Intelligence and Data Science",
      ];
    } else {
      yearOptions = ["1st Year", "2nd Year"];

      departmentOptions = [
        "M.Sc Computer Science",
        "Master of Education (M.Ed)",
      ];
    }

    selectedYear = yearOptions.first;
    selectedDepartment = departmentOptions.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule Exam - ${widget.program}"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          /// ===============================
          /// Dropdown Section
          /// ===============================

          _buildHeader("Select Internal Assessment"),
          _buildDropdownTile(
            value: selectedInternal,
            items: internalOptions,
            onChanged: (val) {
              setState(() {
                selectedInternal = val!;
              });
            },
          ),

          _buildHeader("Select Year"),
          _buildDropdownTile(
            value: selectedYear,
            items: yearOptions,
            onChanged: (val) {
              setState(() {
                selectedYear = val!;
              });
            },
          ),

          _buildHeader("Select Department"),
          _buildDropdownTile(
            value: selectedDepartment,
            items: departmentOptions,
            onChanged: (val) {
              setState(() {
                selectedDepartment = val!;
              });
            },
          ),

          const SizedBox(height: 20),

          /// ===============================
          /// SUBJECT LIST (FIRST INCLUDED)
          /// ===============================

          ...List.generate(examForms.length, (index) {
            return buildExamForm(index);
          }),

          const SizedBox(height: 20),

          /// ===============================
          /// ADD SUB BUTTON (ONLY ONCE)
          /// ===============================

         Align(
  alignment: Alignment.centerRight,
  child: GestureDetector(
    onTap: addNewForm,
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.black, // ✅ Black background
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.add,
            size: 18,
            color: Colors.white, // ✅ White icon
          ),
          SizedBox(width: 6),
          Text(
            "Add Sub",
            style: TextStyle(
              color: Colors.white, // ✅ White text
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  ),
),

          const SizedBox(height: 20),

          /// ===============================
          /// REQUEST BUTTON (ONLY ONCE)
          /// ===============================

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // submit logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Request for Approval",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  /// ===============================
  /// SUBJECT CARD WITH OUTER BOX
  /// ===============================

  Widget buildExamForm(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subject ${index + 1}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (examForms.length > 1)
                GestureDetector(
                  onTap: () => removeForm(index),
                  child: const Icon(
                    Icons.close,
                    color: Color.fromARGB(255, 0, 0, 0),
                    size: 20,
                  ),
                ),
            ],
          ),

          const SizedBox(height: 16),

          _buildHeader("Subject Code"),
          _buildTextField(
            examForms[index].subjectCodeController,
            "Enter Subject Code",
          ),

          _buildHeader("Subject Name"),
          _buildTextField(
            examForms[index].subjectNameController,
            "Enter Subject Name",
          ),

          _buildHeader("Examination Date"),
          _buildTextField(
            examForms[index].dateController,
            "Enter Examination Date",
          ),

          _buildHeader("Examination Time"),
          _buildTextField(
            examForms[index].timeController,
            "Enter Examination Time",
          ),
        ],
      ),
    );
  }
    }

  /// Header
  Widget _buildHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// Dropdown UI
  Widget _buildDropdownTile({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  /// TextField UI
 Widget _buildTextField(
  TextEditingController controller,
  String hintText,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.2,
        ),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: Colors.black, // Typed text color
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey.shade400, // ✅ Light grey hint text
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
        ),
      ),
    ),
  );
}
/// ===============================
/// SCHEDULED EXAMS
/// ===============================

class ScheduledExamsScreen extends StatelessWidget {
  const ScheduledExamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _ProgramScreen(
      title: "Scheduled Exams",
      onUGTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const ScheduledExamsYearScreen(isUG: true),
          ),
        );
      },
      onPGTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const ScheduledExamsYearScreen(isUG: false),
          ),
        );
      },
    );
  }
}

class ScheduledExamsYearScreen extends StatelessWidget {
  final bool isUG;

  const ScheduledExamsYearScreen({super.key, required this.isUG});

  @override
  Widget build(BuildContext context) {
    final years = isUG
        ? ["1st Year", "2nd Year", "3rd Year", "4th Year"]
        : ["1st Year", "2nd Year"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Scheduled Exams - ${isUG ? "UG" : "PG"}"),
      ),
    );
  }
}

/// ===============================
/// YEAR LIST UI
/// ===============================
Widget _buildYearList(
  BuildContext context,
  List<String> years,
  String module,
) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: years.map((year) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: InkWell(
            onTap: () {
              if (module == "Allow Internals") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => InternalTypeScreen(
                      programYear: year,
                    ),
                  ),
                );
              } else {
                print("$module - $year clicked");
              }
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
  color: Colors.white, // clean white
  borderRadius: BorderRadius.circular(14),
  border: Border.all(
    color: Colors.grey.shade300, // mild grey border
    width: 1.2,
  ),
),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      year,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}
/// ===============================
/// INTERNAL TYPE SCREEN WITH SWITCH
/// ===============================

class InternalTypeScreen extends StatefulWidget {
  final String programYear;

  const InternalTypeScreen({
    super.key,
    required this.programYear,
  });

  @override
  State<InternalTypeScreen> createState() => _InternalTypeScreenState();
}

class _InternalTypeScreenState extends State<InternalTypeScreen> {

  bool ia1 = false;
  bool ia2 = false;
  bool model = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Allow Internals - ${widget.programYear}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            _buildSwitchTile(
              title: "Internal Assessment 1",
              value: ia1,
              onChanged: (val) {
                setState(() {
                  ia1 = val;
                });
              },
            ),

            const SizedBox(height: 16),

            _buildSwitchTile(
              title: "Internal Assessment 2",
              value: ia2,
              onChanged: (val) {
                setState(() {
                  ia2 = val;
                });
              },
            ),

            const SizedBox(height: 16),

            _buildSwitchTile(
              title: "Model",
              value: model,
              onChanged: (val) {
                setState(() {
                  model = val;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

Widget _buildSwitchTile({
  required String title,
  required bool value,
  required ValueChanged<bool> onChanged,
}) {
  return Container(
    height: 68, // 👈 FIXED HEIGHT (important)
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: value
          ? const Color(0xFFF3EFFF) // very mild purple
          : Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(
        color: value
            ? const Color(0xFFB39DDB) // soft purple border
            : Colors.grey.shade300,
        width: 1.2, // SAME width always
      ),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: value
                  ? const Color(0xFF5E35B1)
                  : Colors.black87,
            ),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF5E35B1),
          inactiveThumbColor: Colors.grey.shade400,
          inactiveTrackColor: Colors.grey.shade300,
        ),
      ],
    ),
  );
}
}
/// ===============================
/// MODEL CLASS (MUST BE OUTSIDE ALL CLASSES)
/// ===============================

class ExamFormModel {
  final TextEditingController subjectCodeController =
      TextEditingController();

  final TextEditingController subjectNameController =
      TextEditingController();

  final TextEditingController dateController =
      TextEditingController();

  final TextEditingController timeController =
      TextEditingController();
}
class ProgramSelectionScreen extends StatelessWidget {
  const ProgramSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Schedule Exam")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [

            /// UG CARD
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const ScheduleExamDetailsScreen(program: "UG"),
                    ),
                  );
                },
                child: _buildProgramCard(
                  icon: Icons.school,
                  iconColor: Colors.green,
                  title: "UG",
                  subtitle: "Undergraduate",
                ),
              ),
            ),

            const SizedBox(width: 16),

            /// PG CARD
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const ScheduleExamDetailsScreen(program: "PG"),
                    ),
                  );
                },
                child: _buildProgramCard(
                  icon: Icons.workspace_premium,
                  iconColor: Colors.purple,
                  title: "PG",
                  subtitle: "Postgraduate",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgramCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          CircleAvatar(
            radius: 30,
            backgroundColor: iconColor.withOpacity(0.15),
            child: Icon(icon, color: iconColor, size: 28),
          ),

          const SizedBox(height: 16),

          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}