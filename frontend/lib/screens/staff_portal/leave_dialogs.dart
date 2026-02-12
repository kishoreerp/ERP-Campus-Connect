import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// ===============================
/// LEAVE MANAGEMENT (1st SS)
/// ===============================
void showLeaveManagementDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _dialogHeader(context, "Leave Management",
                "Choose an option to manage your leave requests"),

            const SizedBox(height: 16),

            _optionCard(
              icon: Icons.add,
              iconColor: Colors.blue,
              title: "Leave Request",
              subtitle: "Submit a new leave application",
              onTap: () {
                Navigator.pop(context);
                showLeaveRequestDialog(context);
              },
            ),

            const SizedBox(height: 12),

            _optionCard(
              icon: Icons.history,
              iconColor: Colors.purple,
              title: "Requested Leave",
              subtitle: "View your leave request history",
              onTap: () {
                Navigator.pop(context);
                showLeaveHistoryDialog(context);
              },
            ),
          ],
        ),
      ),
    ),
  );
}

/// ===============================
/// LEAVE REQUEST (2nd SS)
/// ===============================
void showLeaveRequestDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      String? selectedLeaveType; // ✅ CORRECT PLACE
      final TextEditingController startController = TextEditingController();
      final TextEditingController endController = TextEditingController();

      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _dialogHeader(
                    context,
                    "Leave Request",
                    "Submit a new leave application",
                    showBack: true,
                  ),

                  const SizedBox(height: 12),

                  _label("Leave Type"),
                  DropdownButtonFormField<String>(
                    value: selectedLeaveType,
                    hint: const Text("Select leave type"),
                    items: const [
                      DropdownMenuItem(
                        value: "Annual Leave",
                        child: Text("Annual Leave"),
                      ),
                      DropdownMenuItem(
                        value: "Sick Leave",
                        child: Text("Sick Leave"),
                      ),
                      DropdownMenuItem(
                        value: "Casual Leave",
                        child: Text("Casual Leave"),
                      ),
                      DropdownMenuItem(
                        value: "Conference Leave",
                        child: Text("Conference Leave"),
                      ),
                      DropdownMenuItem(
                        value: "Other",
                        child: Text("Other"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedLeaveType = value;
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

               _label("Start Date"),
                  TextField(
                    controller: startController,
                    readOnly: true,
                    onTap: () => pickDate(context, true, startController),
                    decoration: _inputDecoration(
                        "dd-mm-yyyy", Icons.calendar_today_outlined),
                  ),

                  const SizedBox(height: 12),
                  _label("End Date"),
                  TextField(
                    controller: endController,
                    readOnly: true,
                    onTap: () => pickDate(context, false, endController),
                    decoration: _inputDecoration(
                        "dd-mm-yyyy", Icons.calendar_today_outlined),
                  ),

                  _label("Reason"),
                  TextField(
                    maxLines: 3,
                    decoration:
                        _inputDecoration("Enter reason", null),
                  ),


                  const SizedBox(height: 16),





                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.send),
                      label: const Text("Submit Request"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

/// ===============================
/// LEAVE HISTORY (3rd SS)
/// ===============================
void showLeaveHistoryDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _dialogHeader(
                context, "Leave History", "Your submitted leave requests",
                showBack: true),

            const SizedBox(height: 12),

            _historyCard(
              title: "Annual Leave",
              date: "2024-02-15 to 2024-02-17 (3 days)",
              reason: "Conference attendance",
              status: "Pending",
              statusColor: Colors.orange,
            ),

            const SizedBox(height: 10),

            _historyCard(
              title: "Sick Leave",
              date: "2024-01-20 to 2024-01-20 (1 day)",
              reason: "Medical appointment",
              status: "Approved",
              statusColor: Colors.green,
            ),
          ],
        ),
      ),
    ),
  );
}

/// ===============================
/// COMMON WIDGETS (DO NOT TOUCH)
/// ===============================
Widget _dialogHeader(BuildContext context, String title, String subtitle,
    {bool showBack = false}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (showBack)
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      Expanded(
        child: Column(
          children: [
            Text(title,
                style: GoogleFonts.inter(
                    fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(subtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      ),
    ],
  );
}

Widget _optionCard(
    {required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title,
                style:
                    GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14)),
            Text(subtitle,
                style: GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
          ]),
        ],
      ),
    ),
  );
}

Widget _label(String text) => Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 6),
      child:
          Text(text, style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
    );

Widget _input(String hint,
    {IconData? icon, int maxLines = 1}) {
  return TextField(
    maxLines: maxLines,
    decoration: InputDecoration(
      hintText: hint,
      suffixIcon: icon != null ? Icon(icon, size: 18) : null,
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    ),
  );
}

Widget _dropdown(String hint) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(hint, style: GoogleFonts.inter(color: Colors.grey)),
        const Icon(Icons.keyboard_arrow_down),
      ],
    ),
  );
}
Future<void> pickDate(BuildContext context, bool isStartDate, TextEditingController controller) async {
  final selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );
  
  if (selectedDate != null) {
    controller.text = "${selectedDate.day.toString().padLeft(2, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.year}";
  }
}
Widget _historyCard(
    {required String title,
    required String date,
    required String reason,
    required String status,
    required Color statusColor}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
                child: Text(title,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600))),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(status,
                  style: TextStyle(color: statusColor, fontSize: 12)),
            )
          ],
        ),
        const SizedBox(height: 4),
        Text(date, style: GoogleFonts.inter(fontSize: 12)),
        const SizedBox(height: 4),
        Text(reason,
            style: GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
      ],
    ),
  );
}

InputDecoration _inputDecoration(String hint, IconData? icon) {
  return InputDecoration(
    hintText: hint,
    hintStyle: GoogleFonts.inter(
      fontSize: 13,
      color: Colors.grey[600],
    ),
    suffixIcon: icon != null ? Icon(icon, size: 18, color: Colors.grey) : null,
    filled: true,
    fillColor: Colors.grey.shade100,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
  );
}