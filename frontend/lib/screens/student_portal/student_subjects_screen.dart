import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';




class StudentSubjectsScreen extends StatelessWidget {
  const StudentSubjectsScreen({super.key});




  @override
  Widget build(BuildContext context) {
    // All subjects (mix of regular + arrear)
    final allSubjects = [
      {
        'name': 'Industrial Management',
        'code': 'CS501',
        'faculty': 'Dr. Sarah Johnson',
        'progress': 0.92,
        'integrated': false,
        'arrear': false,
      },
      {
        'name': 'Human Values and Professional Ethics',
        'code': 'CS502',
        'faculty': 'Prof. David Lee',
        'progress': 0.88,
        'integrated': false,
        'arrear': false,
      },
      {
        'name': 'Project Report Writing',
        'code': 'CS503',
        'faculty': 'Dr. Lisa Wong',
        'progress': 0.85,
        'integrated': false,
        'arrear': false,
      },
      {
        'name': 'English for Computative exams',
        'code': 'HS501',
        'faculty': 'Prof. Michael Brown',
        'progress': 0.90,
        'integrated': false,
        'arrear': false,
      },
    ];




    // Separate arrears automatically
    final regularSubjects =
        allSubjects.where((sub) => sub['arrear'] == false).toList();
    final arrearSubjects =
        allSubjects.where((sub) => sub['arrear'] == true).toList();




    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              _buildSemesterInfo(regularSubjects.length),
              const SizedBox(height: 16),




              // Regular Subjects
              ...regularSubjects.map((sub) => _buildSubjectCard(context, sub)),




              const SizedBox(height: 24),




              // Arrear Section (Dynamic)
              _buildArrearSection(context, arrearSubjects),
            ],
          ),
        ),
      ),
    );
 }


   // ---------------- SEMESTER INFO ----------------
  Widget _buildSemesterInfo(int count) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Current Semester',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600, fontSize: 15)),
              const SizedBox(height: 4),
              Text('$count Total Subjects',
                  style: GoogleFonts.inter(
                      fontSize: 13, color: Colors.grey[700])),
            ],
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.blue.shade50,
            ),
            child: Text('Semester 7',
                style: GoogleFonts.inter(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w600,
                    fontSize: 13)),
          ),
        ],
      ),
    );
  }




  // ---------------- SUBJECT CARD ----------------
  Widget _buildSubjectCard(BuildContext context, Map<String, dynamic> sub) {
    return GestureDetector(
      onTap: () => _showSubjectDetailsDialog(context, sub),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(sub['name'],
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600, fontSize: 15)),
                ),
                Row(
                  children: [
                   
                    const SizedBox(width: 6),
                    if (sub['integrated'])
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Integrated',
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87),
                        ),
                      ),
                    const SizedBox(width: 6),
                    const Icon(Icons.arrow_forward_ios_rounded,
                        size: 14, color: Colors.grey),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text('${sub['code']} • ${sub['faculty']}',
                style: GoogleFonts.inter(
                    fontSize: 13, color: Colors.grey[700])),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }




  // ---------------- ARREAR SECTION (Dynamic) ----------------
  Widget _buildArrearSection(
      BuildContext context, List<Map<String, dynamic>> arrears) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Arrear Papers',
            style: GoogleFonts.inter(
                color: Colors.redAccent,
                fontWeight: FontWeight.w600,
                fontSize: 15)),
        const SizedBox(height: 8),




        // If arrears exist
        if (arrears.isNotEmpty)
          ...arrears.map((sub) => GestureDetector(
                onTap: () => _showSubjectDetailsDialog(context, sub),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(sub['name'],
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Colors.redAccent)),
                          ),
                          const Icon(Icons.warning_amber_rounded,
                              color: Colors.redAccent),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text('${sub['code']} • ${sub['faculty']}',
                          style: GoogleFonts.inter(
                              fontSize: 13, color: Colors.grey[700])),
                    ],
                  ),
                ),
              ))
        else
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Text('No Arrear Papers! 🎉',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800])),
                const SizedBox(height: 4),
                Text('Keep up the good work!',
                    style: GoogleFonts.inter(
                        fontSize: 13, color: Colors.grey[700])),
              ],
            ),
          ),
      ],
    );
  }




  // ---------------- SUBJECT DETAILS POPUP ----------------
  void _showSubjectDetailsDialog(
      BuildContext context, Map<String, dynamic> sub) {
    final bool isArrear = sub['arrear'] ?? false;




    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(sub['name'],
                              style: GoogleFonts.inter(
                                  fontSize: 16, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 4),
                          Text(
                            "${sub['code']} • ${sub['faculty']}${sub['integrated'] ? ' • Integrated Course' : ''}",
                            style: GoogleFonts.inter(
                                color: Colors.grey[700], fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close, color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(height: 16),




                if (!isArrear) ...[
                  // Regular subject popup
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text('92%',
                              style: GoogleFonts.inter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent)),
                          Text('Attendance',
                              style: GoogleFonts.inter(
                                  fontSize: 13, color: Colors.grey[700])),
                        ],
                      ),
                      Column(
                        children: [
                          Text('3',
                              style: GoogleFonts.inter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green)),
                          Text('Study Materials',
                              style: GoogleFonts.inter(
                                  fontSize: 13, color: Colors.grey[700])),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 10),
                  Text('Internal Assessment Marks',
                      style: GoogleFonts.inter(
                          fontSize: 14, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _marksCard('Internal 1', '89/100', Colors.blueAccent),
                      _marksCard('Internal 2', '92/100', Colors.green),
                      _marksCard('Model Exam', '78/100', Colors.purpleAccent),
                    ],
                  ),
                ] else ...[
                  // Arrear subject popup
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.redAccent),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.warning_amber_rounded,
                            color: Colors.redAccent),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'This is an arrear subject. Internal marks not applicable.',
                            style: GoogleFonts.inter(
                              color: Colors.redAccent,
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],




                const SizedBox(height: 18),
                const Divider(),
                const SizedBox(height: 10),
                Text('Study Materials',
                    style: GoogleFonts.inter(
                        fontSize: 14, fontWeight: FontWeight.w700)),
                const SizedBox(height: 10),
                _materialTile('Unit 1 - Revision Notes', '2.1 MB'),
                _materialTile('Unit 2 - Practice Questions', '1.8 MB'),
                _materialTile('Unit 3 - Past Papers', '2.5 MB'),
              ],
            ),
          ),
        );
      },
    );
  }




  // ---------------- HELPERS ----------------
  Widget _marksCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(title,
                style: GoogleFonts.inter(
                    fontSize: 12.5,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            Text(value,
                style: GoogleFonts.inter(
                    color: color, fontSize: 14, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }




  Widget _materialTile(String title, String size) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          const Icon(Icons.insert_drive_file_outlined,
              color: Colors.blueAccent, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.inter(
                        fontSize: 13.5, fontWeight: FontWeight.w600)),
                Text(size,
                    style: GoogleFonts.inter(
                        fontSize: 12, color: Colors.grey[700])),
              ],
            ),
          ),
          const Icon(Icons.download_outlined, color: Colors.black87, size: 22),
        ],
      ),
    );
  }
}















