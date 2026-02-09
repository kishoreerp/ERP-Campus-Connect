import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNewStaffScreen extends StatefulWidget {
  const AddNewStaffScreen({super.key});

  @override
  State<AddNewStaffScreen> createState() => _AddNewStaffScreenState();
}

class _AddNewStaffScreenState extends State<AddNewStaffScreen> {

  String staffType = "Teaching Staff";

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  String? department;
  String? designation;

  final List<String> departments = [
    "Information Technology",
    "Computer Science",
    "Cyber Security",
    "AI & Data Science",
    "Electronics & Communication",
    "Mechanical Engineering",
    "Civil Engineering",
    "MBA",
    "Administration",
  ];

  final List<String> designations = [
    "Professor",
    "Professor & HOD",
    "Associate Professor",
    "Assistant Professor",
    "Lab Technician",
    "Office Staff",
    "Lecturer",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ================= HEADER =================
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Add New Staff",
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                      Text("Fill in staff details",
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.grey)),
                    ],
                  ),

                  const Spacer(),

                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text("Management Admin",
                        style: GoogleFonts.inter(fontSize: 12)),
                  )
                ],
              ),

              const SizedBox(height: 20),

              // ================= FORM CARD =================
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("Staff Information",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600)),

                    const SizedBox(height: 16),

                    // ---------- STAFF TYPE ----------
                    label("Staff Type *"),
                    Row(
                      children: [
                        staffTypeButton("Teaching Staff"),
                        const SizedBox(width: 10),
                        staffTypeButton("Non-Teaching Staff"),
                      ],
                    ),

                    // ---------- FULL NAME ----------
                    label("Full Name *"),
                    textField("Enter full name", nameController),

                    // ---------- EMAIL ----------
                    label("Email Address *"),
                    textField("email@slec.edu.in", emailController),

                    // ---------- PHONE ----------
                    label("Phone Number *"),
                    textField("+91 98765 43210", phoneController),

                    // ---------- DEPARTMENT ----------
                    label("Department *"),
                    buildDropdown(
                      value: department,
                      hint: "Select Department",
                      items: departments,
                      onChanged: (val) {
                        setState(() => department = val);
                      },
                    ),

                    // ---------- DESIGNATION ----------
                    label("Designation *"),
                    buildDropdown(
                      value: designation,
                      hint: "Select Designation",
                      items: designations,
                      onChanged: (val) {
                        setState(() => designation = val);
                      },
                    ),

                    // ---------- DATE ----------
                    label("Date of Joining *"),
                    TextField(
                      controller: dateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "31-01-2026",
                        suffixIcon: const Icon(Icons.calendar_month),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          initialDate: DateTime.now(),
                        );

                        if (picked != null) {
                          setState(() {
                            dateController.text =
                                "${picked.day}-${picked.month}-${picked.year}";
                          });
                        }
                      },
                    ),

                    const SizedBox(height: 22),

                    // ================= BUTTONS =================
                    Row(
                      children: [

                        // CANCEL
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: const BorderSide(color: Colors.grey),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        // ADD STAFF
                        Expanded(
                          child: ElevatedButton(
                            onPressed: addStaff,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade700,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Add Staff",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= ADD STAFF LOGIC =================
  void addStaff() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        department == null ||
        designation == null ||
        dateController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all required fields"),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Staff Added Successfully"),
      ),
    );

    Navigator.pop(context);
  }

  // ================= STAFF TYPE BUTTON =================
  Widget staffTypeButton(String text) {
    bool selected = staffType == text;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => staffType = text);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black),
          ),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.inter(
                color: selected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ================= LABEL =================
  Widget label(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 14, bottom: 6),
      child: Text(text, style: GoogleFonts.inter(fontSize: 12)),
    );
  }

  // ================= TEXTFIELD =================
  Widget textField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  // ================= DROPDOWN =================
  Widget buildDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(hint),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      items: items
          .map(
            (e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
