import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../services/document_service.dart';
import '../../services/student_pdf_service.dart';
import 'package:printing/printing.dart';



class StudentDetailsPdfView extends StatelessWidget {
  final String studentUid;

  const StudentDetailsPdfView({
    super.key,
    required this.studentUid,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(studentUid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;

        // 🔑 MAP FIRESTORE DATA → UI VARIABLES
        final String name = data['username'] ?? '';
        final String email = data['email'] ?? '';
        final String admissionNumber = data['studentId'] ?? '';
        final String department = data['department'] ?? '';
        final String studentPhone = data['phone'] ?? '';
        final String parentPhone = data['parentPhone'] ?? 'N/A';
        final String address = data['address'] ?? 'Not provided';
        final String status = data['status'] ?? 'active';
        return Scaffold(
          backgroundColor: Colors.grey.withOpacity(0.6),

          body: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ================= HEADER =================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Student Details - PDF View',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Complete student information and documents',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        
                        IconButton(
  icon: const Icon(Icons.picture_as_pdf),
  onPressed: () async {
    final pdfData = await StudentPdfService.generate(data);
    await Printing.layoutPdf(onLayout: (_) => pdfData);
  },
),
IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),

                      ],
                    ),

                    const SizedBox(height: 16),

                    // ================= PROFILE CARD =================
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFBFDBFE)),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.blue,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                email,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: status == 'active'
                                  ? Colors.black
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              status.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ================= PERSONAL INFO =================
                    _sectionCard(
                      title: 'Personal Information',
                      child: Column(
                        children: [
                          _rowInfo(
                            'Admission Number',
                            admissionNumber,
                            'Department',
                            department,
                          ),
                          const SizedBox(height: 10),
                          _rowInfo(
                            'Student Number',
                            studentPhone,
                            'Parent Number',
                            parentPhone,
                          ),
                          const SizedBox(height: 10),
                          _singleInfo('Address', address),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // ================= PARENT INFO =================
                   
                   
                   
                    _sectionCard(
                      title: 'Parent/Guardian Information',
                      child: _rowInfo(
                        'Parent Name',
                        data['parentName'] ?? 'Not available',
                        'Parent Mobile',
                        parentPhone,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _sectionCard(
  title: 'Student Documents',
  child: Column(
    children: [
      _docTile('Aadhaar Card', data['documents']?['aadhaar']),
      _docTile('Transfer Certificate', data['documents']?['tc']),
      _docTile('Marksheet', data['documents']?['marksheet']),
    ],
  ),
),

const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ================= HELPERS =================

  Widget _sectionCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _rowInfo(
      String leftTitle, String leftValue, String rightTitle, String rightValue) {
    return Row(
      children: [
        Expanded(child: _info(leftTitle, leftValue)),
        const SizedBox(width: 12),
        Expanded(child: _info(rightTitle, rightValue)),
      ],
    );
  }

  Widget _singleInfo(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _info(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
  Widget _docTile(String title, String? path) {
  if (path == null) {
    return ListTile(
      title: Text(title),
      subtitle: const Text('Not uploaded'),
    );
  }

  return ListTile(
    title: Text(title),
    trailing: const Icon(Icons.download),
    onTap: () {
      DocumentService.downloadAndOpen(path);
    },
  );
}

}
