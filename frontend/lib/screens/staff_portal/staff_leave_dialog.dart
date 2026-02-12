import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


Future<void> showLeaveRequestDialog(BuildContext context, {required Null Function() onExit}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) {
      final startController = TextEditingController();
      final endController = TextEditingController();
      
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Leave Request",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Submit a new leave application",
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close),
                  )
                ],
              ),


              const SizedBox(height: 16),


              // Leave Type
              _label("Leave Type"),
              _dropdown("Select leave type"),


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

                  const SizedBox(height: 12),
                  _label("Reason"),
                  TextField(
                    maxLines: 3,
                    decoration:
                        _inputDecoration("Enter reason", null),
                  ),


                  const SizedBox(height: 16),


              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    startController.dispose();
                    endController.dispose();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.send, size: 18),
                  label: Text(
                    "Submit Request",
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),


              const SizedBox(height: 10),


              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}


// ---------- HELPERS (EXACT UI) ----------


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


Widget _label(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}


Widget _input(String hint,
    {IconData? icon, int maxLines = 1}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            hint,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Colors.grey[600],
            ),
          ),
        ),
        if (icon != null)
          Icon(icon, size: 18, color: Colors.grey),
      ],
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
      children: [
        Expanded(
          child: Text(
            hint,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Colors.grey[600],
            ),
          ),
        ),
        const Icon(Icons.keyboard_arrow_down_rounded,
            color: Colors.grey),
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

