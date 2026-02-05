import 'package:flutter/material.dart';
import 'ug_years_screen.dart';
import 'pg_years_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'student_details_pdf_view.dart';



class AdmissionViewAllStudentsScreen extends StatefulWidget {
  const AdmissionViewAllStudentsScreen({super.key});

  @override
  State<AdmissionViewAllStudentsScreen> createState() =>
      _AdmissionViewAllStudentsScreenState();
}
class _AdmissionViewAllStudentsScreenState
    extends State<AdmissionViewAllStudentsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchText = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 12,
        title: Row(
          children: [
            
            
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'View All Students',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Select program type',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      // ================= BODY =================
      body:
       Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [TextField(
  controller: _searchController,
  decoration: InputDecoration(
    hintText: 'Search by student name or roll number',
    prefixIcon: const Icon(Icons.search),
    filled: true,
    fillColor: Colors.grey.shade100,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),
  onChanged: (value) {
    setState(() {
      searchText = value.trim();
    });
  },
),
const SizedBox(height: 16),

           
            
if (searchText.isNotEmpty)
  StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'student')
        .snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: 5,
    itemBuilder: (context, index) {
      return _skeletonCard();
    },
  );
}


      final results = snapshot.data!.docs.where((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final name =
            (data['username'] ?? '').toString().toLowerCase();
        final roll =
            (data['rollNo'] ?? '').toString().toLowerCase();

        return name.contains(searchText.toLowerCase()) ||
            roll.contains(searchText.toLowerCase());
      }).toList();

      if (results.isEmpty) {
        return Column(
  children: const [
    SizedBox(height: 40),
    Icon(Icons.search_off, size: 48, color: Colors.grey),
    SizedBox(height: 8),
    Text(
      'No students found',
      style: TextStyle(color: Colors.grey),
    ),
  ],
);

      }

      return AnimatedSwitcher(
  duration: const Duration(milliseconds: 250),
  child: ListView.builder(
    key: ValueKey(results.length),
        shrinkWrap: true,
        itemCount: results.length,
        itemBuilder: (context, index) {
          final doc = results[index];
          final data = doc.data() as Map<String, dynamic>;

  final String program = data['program'] ?? '';
final String year = data['year'] ?? '';

return InkWell(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StudentDetailsPdfView(studentUid: doc.id),
      ),
    );
  },
  borderRadius: BorderRadius.circular(14),
  child: Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: const Color(0xFFEFF6FF),
          child: const Icon(Icons.person, color: Color(0xFF2563EB)),
        ),
        const SizedBox(width: 14),

        // -------- STUDENT INFO --------
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data['username'] ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Roll No: ${data['rollNo'] ?? ''}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 6),

              // -------- BADGE --------
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$program • $year',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2563EB),
                  ),
                ),
              ),
            ],
          ),
        ),

        const Icon(Icons.chevron_right, color: Colors.grey),
      ],
    ),
  ),
);


        },
  ),  
      );
    },
  )
else
  Column(
    children: [
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('role', isEqualTo: 'student')
            .where('program', isEqualTo: 'UG')
            .snapshots(),
        builder: (context, snapshot) {
          final count =
              snapshot.hasData ? snapshot.data!.docs.length : 0;

          return _programCard(
            title: 'UG Programs',
            subtitle: 'Undergraduate Students',
            count: '$count Students',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const UgYearsScreen(),
                ),
              );
            },
          );
        },
      ),

      const SizedBox(height: 16),

      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('role', isEqualTo: 'student')
            .where('program', isEqualTo: 'PG')
            .snapshots(),
        builder: (context, snapshot) {
          final count =
              snapshot.hasData ? snapshot.data!.docs.length : 0;

          return _programCard(
            title: 'PG Programs',
            subtitle: 'Postgraduate Students',
            count: '$count Students',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PgYearsScreen(),
                ),
              );
            },
          );
        },
      ),
    ],
  ),


                // Navigate to PG students list
              
            
          ],
        ),
      ),
    );
  }

  // ================= PROGRAM CARD =================
  Widget _programCard({
    required String title,
    required String subtitle,
    required String count,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      count,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
  Widget _skeletonCard() {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: [
        Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _skeletonLine(width: 120),
              const SizedBox(height: 8),
              _skeletonLine(width: 160),
              const SizedBox(height: 8),
              _skeletonLine(width: 80, height: 16),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _skeletonLine({double width = double.infinity, double height = 12}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(6),
    ),
  );
}

}
