import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StaffRequestLeaveScreen extends StatelessWidget {
  const StaffRequestLeaveScreen({super.key});

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
              context,
              title: 'Apply Leave',
              subtitle: 'Submit a new leave request',
              icon: Icons.add_circle_outline,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (_) => const StaffLeaveManagementSheet(),
                );
              },
            ),
            _leaveCard(
              context,
              title: 'Leave History',
              subtitle: 'View previously applied leaves',
              icon: Icons.history,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Leave history coming soon')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _leaveCard(
    BuildContext context, {
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
        title: Text(title,
            style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle,
            style: GoogleFonts.inter(fontSize: 13)),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

// ---------------- BOTTOM SHEET ----------------
class StaffLeaveManagementSheet extends StatelessWidget {
  const StaffLeaveManagementSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Apply Leave',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),

          TextField(
            decoration: const InputDecoration(
              labelText: 'Leave Reason',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),

          TextField(
            decoration: const InputDecoration(
              labelText: 'From Date',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),

          TextField(
            decoration: const InputDecoration(
              labelText: 'To Date',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Leave request submitted')),
                );
              },
              child: Text(
                'Submit',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
