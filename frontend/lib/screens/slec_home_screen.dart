import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'student_login_screen.dart';
import 'admin_portal_screen.dart';
import 'admission_portal_screen.dart';

class SlecHomeScreen extends StatelessWidget {
  const SlecHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
  child: Column(
    children: [
      const _HeaderSection(), // 🔒 FIXED (NO SCROLL)

      Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              SizedBox(height: 20),
              _WelcomeSection(),
              SizedBox(height: 16),
              _PortalSection(),
              SizedBox(height: 16),
              _WhyChooseSection(),
              SizedBox(height: 16),
              _FooterSection(),
            ],
          ),
        ),
      ),
    ],
  ),
),

    );
  }
}

// ---------------- HEADER ----------------
class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.school, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 10),
          Text(
            'ST. LOURDES ENGINEERING COLLEGE',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Excellence in Technical Education',
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.95),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, size: 14, color: Colors.white70),
              const SizedBox(width: 4),
              Text('Anagapathur, Chennai, India',
                  style: GoogleFonts.inter(color: Colors.white70, fontSize: 12)),
              const SizedBox(width: 10),
              const Icon(Icons.verified, size: 14, color: Colors.white70),
              const SizedBox(width: 4),
              Text('AICTE Approved',
                  style: GoogleFonts.inter(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------- WELCOME SECTION ----------------
class _WelcomeSection extends StatelessWidget {
  const _WelcomeSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text('Welcome to SLEC Portal',
              style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text('Choose your access point to get started',
              style: GoogleFonts.inter(color: Colors.grey[600])),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: const [
              _StatCard(value: '25+', label: 'Years Excellence', color: Color(0xFFE3F2FD)),
              _StatCard(value: '95%', label: 'Placement Rate', color: Color(0xFFE8F5E9)),
              _StatCard(value: '200+', label: 'Expert Faculty', color: Color(0xFFF3E5F5)),
              _StatCard(value: '50+', label: 'Industry Partners', color: Color(0xFFFFF3E0)),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value, label;
  final Color color;
  const _StatCard({required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(value,
              style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 17)),
          const SizedBox(height: 4),
          Text(label, style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[800])),
        ],
      ),
    );
  }
}

// ---------------- PORTALS ----------------
class _PortalSection extends StatelessWidget {
  const _PortalSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _PortalCard(
            color: const Color(0xFFDCFAE6),
            icon: Icons.assignment_turned_in_outlined,
            title: 'Admission Portal',
            subtitle: 'Apply for programs',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AdmissionPortalScreen()),
              );
            },
          ),
          _PortalCard(
            color: const Color(0xFFE4EBFF),
            icon: Icons.admin_panel_settings_outlined,
            title: 'Administrative Portal',
            subtitle: 'Faculty & staff access',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AdminPortalScreen()),
              );
            },
          ),
          _PortalCard(
            color: const Color(0xFFF4E8FF),
            icon: Icons.school_outlined,
            title: 'Student Portal',
            subtitle: 'Student dashboard',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StudentLoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PortalCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title, subtitle;
  final VoidCallback? onTap;
  const _PortalCard(
      {required this.color,
      required this.icon,
      required this.title,
      required this.subtitle,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 0.6,
      child: ListTile(
        leading: CircleAvatar(radius: 22, backgroundColor: color, child: Icon(icon)),
        title: Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: GoogleFonts.inter(color: Colors.grey[700])),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

// ---------------- WHY CHOOSE ----------------
class _WhyChooseSection extends StatelessWidget {
  const _WhyChooseSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: const [
          _FeatureItem(
              icon: Icons.verified_outlined,
              title: 'NAAC A+ Accredited',
              subtitle: 'Highest quality standards'),
          _FeatureItem(
              icon: Icons.business_outlined,
              title: 'Modern Infrastructure',
              subtitle: 'State-of-art facilities'),
          _FeatureItem(
              icon: Icons.auto_graph_outlined,
              title: 'Industry Aligned Curriculum',
              subtitle: 'Updated programs'),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  const _FeatureItem({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: GoogleFonts.inter(color: Colors.grey[700])),
      ),
    );
  }
}

// ---------------- FOOTER ----------------
class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      child: Column(
        children: [
          Text('📞 +91 471 2515623   ✉️ info@slec.ac.in',
              style: GoogleFonts.inter(color: Colors.grey[700], fontSize: 13),
              textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text('© 2024 ST. Lourdes Engineering College',
              style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 12),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}