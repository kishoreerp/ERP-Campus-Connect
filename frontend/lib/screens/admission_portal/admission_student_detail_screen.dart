import 'package:flutter/material.dart';

class AdmissionStudentDetailScreen extends StatelessWidget {
  final String name;
  final String email;
  final String department;
  final String year;
  final String admissionNumber;
  final String studentPhone;
  final String parentPhone;

  const AdmissionStudentDetailScreen({
    super.key,
    required this.name,
    required this.email,
    required this.department,
    required this.year,
    required this.admissionNumber,
    required this.studentPhone,
    required this.parentPhone,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      

      // ================= APP BAR =================
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 12,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              department,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Text(
              '1st Year Students',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
       
      ),

      // ================= BODY =================
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -------- HEADER --------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      name,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    const SizedBox(height: 2),
    Text(
      email,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 12,
      ),
    ),
  ],
),

                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Active',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // -------- INFO --------
              Row(
                children: [
                 _infoColumn('Admission Number', admissionNumber),
_infoColumn('Year', year),

                ],
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  _infoColumn('Department', department),
                ],
              ),

              const SizedBox(height: 12),

           Row(
  children: [
    _iconInfo(Icons.call, 'Student Number', studentPhone),
    const SizedBox(width: 12),
    _iconInfo(Icons.call, 'Parent Number', parentPhone),
  ],
),


              const SizedBox(height: 16),
              const Divider(),

              // -------- ACTIONS --------
              const Text(
                'Application Status',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.check, color: Colors.green),
                      label: const Text(
                        'Approve',
                        style: TextStyle(color: Colors.green),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.green),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.close),
                      label: const Text('Reject'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= HELPERS =================

  Widget _infoColumn(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(value,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }
}

class _iconInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _iconInfo(this.icon, this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style:
                      const TextStyle(fontSize: 12, color: Colors.grey)),
              Text(value,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
