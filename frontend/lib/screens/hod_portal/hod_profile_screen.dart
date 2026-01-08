import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HODProfileScreen extends StatefulWidget {
  const HODProfileScreen({super.key});

  @override
  State<HODProfileScreen> createState() => _HODProfileScreenState();
}

class _HODProfileScreenState extends State<HODProfileScreen> {
  String status = "Present";

  Color _statusColor() {
    switch (status) {
      case "Absent":
        return Colors.red;
      case "Permission":
        return Colors.orange;
      case "OD":
        return Colors.blue;
      default:
        return Colors.green;
    }
  }

  IconData _statusIcon() {
    switch (status) {
      case "Absent":
        return Icons.cancel;
      case "Permission":
        return Icons.access_time;
      case "OD":
        return Icons.work_outline;
      default:
        return Icons.check_circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= HEADER =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Profile",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings_outlined),
                    onPressed: () {},
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ================= PROFILE CARD =================
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: const Color(0xFFF3E8FF),
                      child: const Icon(
                        Icons.person_outline,
                        color: Colors.purpleAccent,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Dr. Sarah Johnson",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600)),
                        Text("HOD12345",
                            style: GoogleFonts.inter(
                                fontSize: 13, color: Colors.grey)),
                        Text("Computer Science",
                            style: GoogleFonts.inter(
                                fontSize: 13, color: Colors.grey)),
                        Text("Head of Department",
                            style: GoogleFonts.inter(
                                fontSize: 13, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // ================= STATUS CARD (NEW) =================
              InkWell(
                onTap: _showStatusPopup,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: _statusColor().withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(_statusIcon(), color: _statusColor()),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Status",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600)),
                          Text(
                            status,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: _statusColor(),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.chevron_right, color: Colors.grey),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ================= DETAILS =================
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: const Column(
                  children: [
                    _Detail(Icons.email_outlined, "sarah.johnson@slec.edu"),
                    _Detail(Icons.phone_outlined, "+1 234-567-8900"),
                    _Detail(Icons.school_outlined, "Computer Science"),
                    _Detail(Icons.location_on_outlined,
                        "123 College Street, City, State 12345"),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ================= LOGOUT =================
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.logout),
                  label: const Text("Logout"),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= STATUS POPUP =================
  void _showStatusPopup() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (_) => Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Update Status",
                      style: GoogleFonts.inter(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Text("Select your current attendance status",
                  style:
                      GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 16),

              _statusOption("Present", Icons.check_circle, Colors.green),
              _statusOption("Absent", Icons.cancel, Colors.red),
              _statusOption("Permission", Icons.access_time, Colors.orange),
              _statusOption("OD", Icons.work_outline, Colors.blue),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusOption(String value, IconData icon, Color color) {
    final selected = status == value;
    return InkWell(
      onTap: () {
        setState(() => status = value);
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Icon(icon, color: selected ? Colors.white : color),
            const SizedBox(width: 12),
            Text(
              value,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= DETAIL WIDGET =================
class _Detail extends StatelessWidget {
  final IconData icon;
  final String text;
  const _Detail(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
