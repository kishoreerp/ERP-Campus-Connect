import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'application_form_screen.dart';



class AdmissionPortalScreen extends StatelessWidget {
  const AdmissionPortalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // keep white below the header
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // HEADER (gradient + back + avatar + title)
            _Header(),

            // CONTENT
            Expanded(
              child: Container(
                // this white container gives the "card" style under the header
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),

                      // "Shape your future" and intro
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Shape Your Future',
                              style: GoogleFonts.inter(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Join Kerala\'s premier engineering institution',
                              style: GoogleFonts.inter(
                                  fontSize: 13, color: Colors.grey[700]),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),

                      // Why choose SLEC - 2x2 grid cards
                      Text(
                        'Why Choose SLEC?',
                        style: GoogleFonts.inter(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: const [
                          _MiniFeatureCard(
                              icon: Icons.verified_outlined,
                              title: 'NAAC A+ Accredited',
                              subtitle: 'Highest quality standards'),
                          _MiniFeatureCard(
                              icon: Icons.people_outline,
                              title: 'Expert Faculty',
                              subtitle: '200+ experienced professors'),
                          _MiniFeatureCard(
                              icon: Icons.book_outlined,
                              title: 'Modern Curriculum',
                              subtitle: 'Industry-aligned programs'),
                          _MiniFeatureCard(
                              icon: Icons.computer_outlined,
                              title: 'State-of-Art Infrastructure',
                              subtitle: 'Labs, library & facilities'),
                        ],
                      ),

                      const SizedBox(height: 18),

                      // Available Programs label
                      Text(
                        'Available Programs',
                        style: GoogleFonts.inter(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 12),

                      // Programs list
                      _ProgramCard(
                        icon: Icons.laptop_mac_outlined,
                        title: 'Computer Science & Engineering',
                        subtitle:
                            'Software development, AI, Machine Learning, modern computing technologies',
                        duration: 'Duration: 4 Years',
                        seats: 'Seats: 60',
                        onTap: () {
                          // placeholder action
                          // real flow: navigate to program details or application
                        },
                      ),
                      _ProgramCard(
                        icon: Icons.electrical_services_outlined,
                        title: 'Electronics & Communication Engineering',
                        subtitle:
                            'Electronics, Communication systems, and Signal processing',
                        duration: 'Duration: 4 Years',
                        seats: 'Seats: 60',
                      ),
                      _ProgramCard(
                        icon: Icons.precision_manufacturing_outlined,
                        title: 'Mechanical Engineering',
                        subtitle:
                            'Manufacturing, Automotive, and Industrial engineering',
                        duration: 'Duration: 4 Years',
                        seats: 'Seats: 60',
                      ),
                      _ProgramCard(
                        icon: Icons.apartment_outlined,
                        title: 'Civil Engineering',
                        subtitle:
                            'Construction, Infrastructure, and Environmental Engineering',
                        duration: 'Duration: 4 Years',
                        seats: 'Seats: 60',
                      ),

                      const SizedBox(height: 20),

                      // Simple 4-step process
                      Text(
                        'Simple 4-Step Process',
                        style: GoogleFonts.inter(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 12),

                      Column(
                        children: const [
                          _StepTile(number: 1, title: 'Online Application', subtitle: 'Fill the application form'),
                          SizedBox(height: 8),
                          _StepTile(number: 2, title: 'Document Upload', subtitle: 'Upload academic documents'),
                          SizedBox(height: 8),
                          _StepTile(number: 3, title: 'Fee Payment', subtitle: 'Pay application fee online'),
                          SizedBox(height: 8),
                          _StepTile(number: 4, title: 'Admission Review', subtitle: 'Application review & confirmation'),
                        ],
                      ),

                      const SizedBox(height: 22),

                      // CTA big gradient box
                      _CtaBox(
                        onApplyTap: () {
                          // Navigate to a placeholder application screen (or implement flow)
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ApplicationFormScreen()),

                          );
                        },
                      ),

                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ---------------- Header widget ----------------
class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height tuned to match screenshots
      height: 180,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E88E5), Color(0xFF10B981)], // blue -> green gradient
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        ),
      ),
      child: Stack(
        children: [
          // back button top-left
          Positioned(
            top: 14,
            left: 12,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Text('Back', style: GoogleFonts.inter(color: Colors.white)),
              ],
            ),
          ),

          // center icon badge + title + subtitle
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // circular badge
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.school, color: Colors.white70, size: 28),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'ST. LOURDES ENGINEERING COLLEGE',
                  style: GoogleFonts.inter(
                      color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text('Admissions 2024-25',
                    style: GoogleFonts.inter(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- Mini feature card used in Why choose ----------------
class _MiniFeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _MiniFeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    // fixed width so two cards fit per row on narrow phones
    return Container(
      width: (MediaQuery.of(context).size.width - 64) / 2, // approximate
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6)],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.blueAccent),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 4),
                Text(subtitle, style: GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// ---------------- Program card ----------------
class _ProgramCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String duration;
  final String seats;
  final VoidCallback? onTap;

  const _ProgramCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.seats,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.blue.shade50,
                child: Icon(icon, color: Colors.blueAccent),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 14)),
                    const SizedBox(height: 6),
                    Text(subtitle, style: GoogleFonts.inter(color: Colors.grey[700], fontSize: 12)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(duration, style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 12)),
                        const SizedBox(width: 12),
                        Text(seats, style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 12)),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- Step tile used in 4-step process ----------------
class _StepTile extends StatelessWidget {
  final int number;
  final String title;
  final String subtitle;

  const _StepTile({
    required this.number,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.blue.shade50,
            child: Text(number.toString(), style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: Colors.blueAccent)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(subtitle, style: GoogleFonts.inter(color: Colors.grey[700], fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- CTA gradient box ----------------
class _CtaBox extends StatelessWidget {
  final VoidCallback onApplyTap;

  const _CtaBox({required this.onApplyTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      // gradient card
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF16A34A), Color(0xFF10B981)], begin: Alignment.centerLeft, end: Alignment.centerRight),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
      child: Column(
        children: [
          Text(
            'Ready to Apply?',
            style: GoogleFonts.inter(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            'Apply now for Academic Year 2024-25',
            style: GoogleFonts.inter(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onApplyTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text('Start Application', style: GoogleFonts.inter(color: Colors.black, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- Placeholder application screen ----------------
class _ApplicationPlaceholder extends StatelessWidget {
  const _ApplicationPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Text('Application flow placeholder', style: GoogleFonts.inter(fontSize: 16)),
      ),
    );
  }
}