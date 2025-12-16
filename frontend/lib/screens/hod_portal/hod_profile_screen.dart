import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class HODProfileScreen extends StatelessWidget {
  const HODProfileScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- Header ----------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Profile",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // TODO: Add settings action if needed
                    },
                    icon: const Icon(Icons.settings_outlined),
                  ),
                ],
              ),


              const SizedBox(height: 16),


              // ---------- Profile Card ----------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar
                    Container(
                      width: 55,
                      height: 55,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF3E8FF),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person_outline,
                        color: Colors.purpleAccent,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // HOD Info
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dr. Sarah Johnson",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "HOD12345",
                          style: GoogleFonts.inter(
                            color: Colors.grey[700],
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          "Computer Science",
                          style: GoogleFonts.inter(
                            color: Colors.grey[700],
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          "Head of Department",
                          style: GoogleFonts.inter(
                            color: Colors.grey[700],
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),


              const SizedBox(height: 16),


              // ---------- Details Card ----------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildDetailRow(Icons.email_outlined, "sarah.johnson@slec.edu"),
                    const SizedBox(height: 12),
                    _buildDetailRow(Icons.phone_outlined, "+1 234-567-8900"),
                    const SizedBox(height: 12),
                    _buildDetailRow(Icons.school_outlined, "Computer Science"),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      Icons.location_on_outlined,
                      "123 College Street, City, State 12345",
                    ),
                  ],
                ),
              ),


              const SizedBox(height: 24),


              // ---------- Logout Button ----------
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    // TODO: Implement logout logic
                  },
                  icon: const Icon(Icons.logout, color: Colors.black87, size: 20),
                  label: Text(
                    "Logout",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  // ---------- Helper Widget ----------
  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.black54),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}



