import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ug_programs_screen.dart';
import 'Pg_programs_screen.dart';


class AdmissionScreen extends StatefulWidget {
  const AdmissionScreen({super.key});


  @override
  State<AdmissionScreen> createState() => _AdmissionScreenState();
}


class _AdmissionScreenState extends State<AdmissionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 246, 248),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('admission_forms')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }


            if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong"));
            }


            final docs = snapshot.data?.docs ?? [];


            final ugCount = docs
                .where((doc) => (doc.data() as Map)['program'] == 'UG')
                .length;


            final pgCount = docs
                .where((doc) => (doc.data() as Map)['program'] == 'PG')
                .length;


            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 


                  /// Header
                  const Text(
                    "Admissions",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                     
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    "Manage undergraduate and postgraduate applications",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),


                  const SizedBox(height: 15),


                  /// UG Card
                  _programCard(
                    icon: Icons.school_rounded,
                    iconColor: const Color(0xFF4A90E2),
                    title: "UG Programs",
                    subtitle: "Undergraduate Admissions",
                    applications: "$ugCount Applications",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const UgDepartmentsScreen(),
                        ),
                      );
                    },
                  ),


                  /// PG Card
                  _programCard(
                    icon: Icons.workspace_premium_rounded,
                    iconColor: const Color(0xFF7B61FF),
                    title: "PG Programs",
                    subtitle: "Postgraduate Admissions",
                    applications: "$pgCount Applications",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PgProgramsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }


  /// ================= MODERN PROGRAM CARD =================
  Widget _programCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String applications,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        elevation: 6,
        shadowColor: Colors.black.withOpacity(0.08),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                /// Icon Container
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 28,
                  ),
                ),


                const SizedBox(width: 16),


                /// Text Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 10),


                      /// Applications Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          applications,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
