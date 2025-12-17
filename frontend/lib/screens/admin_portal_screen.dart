import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'hod_portal/hod_portal_screen.dart';
import 'staff_portal/staff_portal_screen.dart';
import 'hod_portal/hod_portal_screen.dart';
import 'reset_password/admin_reset_email_screen.dart';

class AdminPortalScreen extends StatefulWidget {
  const AdminPortalScreen({super.key});

  @override
  State<AdminPortalScreen> createState() => _AdminPortalScreenState();
}

class _AdminPortalScreenState extends State<AdminPortalScreen> {
  String? selectedRole;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final roles = ['Principal', 'HOD', 'Staff', 'Clerk'];

void _handleLogin() {
  // Basic validation
  if (selectedRole == null ||
      usernameController.text.isEmpty ||
      passwordController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please fill in all fields.'),
        backgroundColor: Colors.redAccent,
      ),
    );
    return;
  }

  // Navigate based on role
  if (selectedRole == 'Staff') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StaffPortalScreen(username: usernameController.text),
      ),
    );
  } else if (selectedRole == 'HOD') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HODPortalScreen(username: usernameController.text),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Login for $selectedRole coming soon!'),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: _cardStyle(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select your administrative role to access the system',
                        style: GoogleFonts.inter(color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 16),
                      Text('Administrative Role',
                          style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      _buildDropdown(),
                      const SizedBox(height: 16),
                      Text('Username',
                          style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                       const SizedBox(height: 6),
                      _buildTextField(
                          controller: usernameController,
                          hint: 'Enter your username',
                          icon: Icons.person_outline),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Password',
                              style:
                                  GoogleFonts.inter(fontWeight: FontWeight.w600)),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const AdminResetEmailScreen()),
                            ),
                            child: Text('Forgot Password?',
                                style: GoogleFonts.inter(
                                    color: Colors.blue[700],
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      _buildTextField(
                        controller: passwordController,
                        hint: 'Enter your password',
                        icon: Icons.lock_outline,
                        obscure: true,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: _handleLogin,
                          child: Text('Access Admin Panel',
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white10,
            child: Icon(Icons.school_outlined, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 12),
          Text('SLEC Admin Panel',
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          Text('Administrative Access Portal',
              style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedRole,
          hint: Text('Select your role', style: GoogleFonts.inter()),
          items: roles.map((role) {
            return DropdownMenuItem(value: role, child: Text(role));
          }).toList(),
          onChanged: (val) => setState(() => selectedRole = val),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  BoxDecoration _cardStyle() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      );
}
