import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StaffLeaveRequestScreen extends StatelessWidget {
  const StaffLeaveRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Leave Request'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Submit Leave Request',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text('Fill in the details to request leave',
                  style: GoogleFonts.inter(
                      fontSize: 12, color: Colors.grey)),

              const SizedBox(height: 16),

              _field('Leave Type', 'Select leave type'),
              _field('Start Date', 'dd-mm-yyyy', icon: Icons.calendar_today),
              _field('End Date', 'dd-mm-yyyy', icon: Icons.calendar_today),
              _field('Reason', 'Enter reason for leave...', maxLines: 3),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Submit Leave Request'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(String label, String hint,
      {IconData? icon, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          TextField(
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: icon != null ? Icon(icon, size: 18) : null,
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
