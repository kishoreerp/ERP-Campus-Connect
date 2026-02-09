import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'staff_leave_request_screen.dart';
import 'staff_requested_leave_screen.dart';


class StaffRequestLeaveScreen extends StatelessWidget {
  const StaffRequestLeaveScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Text(
          'Request Leave',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _leaveCard(
              title: 'Leave Request',
              subtitle: 'Submit a new leave request',
              icon: Icons.add_circle_outline,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                   builder: (_) => LeaveRequestScreen(),




                  ),
                );
              },
            ),
            _leaveCard(
              title: 'Requested Leave',
              subtitle: 'View Your Leave Request History',
              icon: Icons.history,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RequestedLeaveScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }


  Widget _leaveCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: Colors.blue),
        title: Text(
          title,
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.inter(fontSize: 13),
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}


