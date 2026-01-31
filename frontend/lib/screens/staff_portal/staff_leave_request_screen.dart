import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class LeaveRequestScreen extends StatefulWidget {
  const LeaveRequestScreen({Key? key}) : super(key: key);


  @override
  State<LeaveRequestScreen> createState() => _LeaveRequestScreenState();
}


class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  final _formKey = GlobalKey<FormState>();


  String? _leaveType;
  DateTime? _startDate;
  DateTime? _endDate;


  final TextEditingController _startDateController =
      TextEditingController();
  final TextEditingController _endDateController =
      TextEditingController();
  final TextEditingController _reasonController =
      TextEditingController();


  final DateFormat _dateFormat = DateFormat('dd-MM-yyyy');


  Future<void> _pickDate({
    required bool isStartDate,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );


    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          _startDateController.text = _dateFormat.format(picked);
        } else {
          _endDate = picked;
          _endDateController.text = _dateFormat.format(picked);
        }
      });
    }
  }


  void _submitLeave() {
    if (_leaveType == null ||
        _startDate == null ||
        _endDate == null ||
        _reasonController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
        ),
      );
      return;
    }


    if (_endDate!.isBefore(_startDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('End date cannot be before start date'),
        ),
      );
      return;
    }


    // 🔥 Here you can call API
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Leave request submitted successfully'),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Text(
          'Leave Request',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  const Text(
                    "Submit Leave Request",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Fill in the details to request leave",
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),


                  const SizedBox(height: 18),


                  _label("Leave Type"),
                  DropdownButtonFormField<String>(
                    decoration: _inputDecoration("Select leave type"),
                    value: _leaveType,
                    items: const [
                      DropdownMenuItem(value: "Casual", child: Text("Casual Leave")),
                      DropdownMenuItem(value: "Sick", child: Text("Sick Leave")),
                      DropdownMenuItem(value: "Earned", child: Text("Earned Leave")),
                      DropdownMenuItem(value: "Maternity", child: Text("Maternity Leave")),
                      DropdownMenuItem(value: "Paternity", child: Text("Paternity Leave")),
                    ],
                    onChanged: (value) {
                      setState(() => _leaveType = value);
                    },
                  ),


                  const SizedBox(height: 14),


                  _label("Start Date"),
                  TextFormField(
                    controller: _startDateController,
                    readOnly: true,
                    onTap: () => _pickDate(isStartDate: true),
                    decoration: _inputDecoration("dd-mm-yyyy").copyWith(
                      suffixIcon: const Icon(Icons.calendar_today_outlined),
                    ),
                  ),


                  const SizedBox(height: 14),


                  _label("End Date"),
                  TextFormField(
                    controller: _endDateController,
                    readOnly: true,
                    onTap: () => _pickDate(isStartDate: false),
                    decoration: _inputDecoration("dd-mm-yyyy").copyWith(
                      suffixIcon: const Icon(Icons.calendar_today_outlined),
                    ),
                  ),


                  const SizedBox(height: 14),


                  _label("Reason"),
                  TextFormField(
                    controller: _reasonController,
                    maxLines: 3,
                    decoration: _inputDecoration(
                      "Enter reason for leave...",
                    ),
                  ),


                  const SizedBox(height: 22),


                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _submitLeave,
                      child: const Text(
                        "Submit Leave Request",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  static Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: const TextStyle(fontSize: 13)),
    );
  }


  static InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }
}
