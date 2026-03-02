import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';


class AdmissionStudentDetailScreen extends StatelessWidget {
  final String documentId;
  final String departmentName;
  final String program;   // PG
  final String degree;  
  final Map<String, dynamic> studentData;


  const AdmissionStudentDetailScreen({
    super.key,
    required this.documentId,
    required this.studentData,
    required this.departmentName,
    required this.program,
    required this.degree,
  });


  Future<void> _updateStatus(
      BuildContext context, String status) async {
    try {
      // 1️⃣ Update Firestore status
      await FirebaseFirestore.instance
          .collection('admission_forms')
          .doc(documentId)
          .update({'status': status});


      // 2️⃣ Call Cloud Function to send mail
      final callable = FirebaseFunctions.instance
          .httpsCallable('sendAdmissionStatusEmail');


      await callable.call({
        'email': studentData['email'],
        'status': status,
        'documentId': documentId,
      });


      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Student $status successfully")),
      );


      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final name = studentData['name'] ?? '';
    final email = studentData['email'] ?? '';
    final department = studentData['department'] ?? '';
    final phone = studentData['phone'] ?? '';
    final parentPhone = studentData['fatherMobile'] ?? '';
    final status = studentData['status'] ?? 'pending';


          return Scaffold(
  backgroundColor: Colors.white,
  appBar: AppBar(
  elevation: 0,
  backgroundColor: Colors.white,
  foregroundColor: Colors.black,
  titleSpacing: 0,
  title: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "$program - $degree",
        style: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
          fontWeight: FontWeight.w600,
        ),
      ),
      Text(
        departmentName,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  ),
),


  body: SingleChildScrollView(
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


      // ================= HEADER =================
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  studentData['name'] ?? '',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  studentData['email'] ?? '',
                  style: const TextStyle(
                      color: Colors.grey),
                ),
              ],
            ),
          ),
          _statusBadge(studentData['status'] ?? 'pending'),
        ],
      ),


      const SizedBox(height: 20),


      // ================= PROGRAM =================
      _sectionTitle("Program Details"),
      _infoRow("Program", studentData['program']),
      _infoRow("Degree", studentData['degree']),
      _infoRow("Department", studentData['department']),


      // ================= PERSONAL =================
      _sectionTitle("Personal Information"),
      _infoRow("DOB", studentData['dob']),
      _infoRow("Gender", studentData['gender']),
      _infoRow("Blood Group", studentData['bloodGroup']),
      _infoRow("Aadhaar", studentData['aadhaar']),
      _infoRow("Phone", studentData['phone']),


      // ================= ADDRESS =================
      _sectionTitle("Address"),
      _infoRow("Address", studentData['address']),


      // ================= ACADEMIC =================
      _sectionTitle("Academic Details"),
      _infoRow("Previous Education", studentData['previousEducation']),
      _infoRow("12th School", studentData['12thSchool']),
      _infoRow("12th Board", studentData['12thBoard']),
      _infoRow("12th Year", studentData['12thYear']),
      _infoRow("12th Mark", studentData['12thMark']),
      _infoRow("12th Percentage", studentData['12thPercentage']),
       _infoRow("10th School", studentData['10thSchool']),
      _infoRow("10th Board", studentData['10thBoard']),
      _infoRow("10th Year", studentData['10thYear']),
      _infoRow("10th Mark", studentData['10thMark']),
      _infoRow("10th Percentage", studentData['10thPercentage']),
      _infoRow("College Name",studentData['collegeName'] ),
      _infoRow("University", studentData['university']),
      _infoRow("Degree Year", studentData['degreeYear']),
      _infoRow("Degree Percentage", studentData['degreePercentage']),


      // ================= CERTIFICATES =================
_sectionTitle("Community & Certificates"),
_infoRow("EMIS ID", studentData['emisId']),
_infoRow("Religion", studentData['religion']),
_infoRow("Caste", studentData['caste']),
_infoRow("Community", studentData['community']),
_infoRow("Community Cert No", studentData['communityCertNo']),
_infoRow("Annual Income", studentData['annualIncome']),
_infoRow("Income Cert No", studentData['incomeCertNo']),
_infoRow("First Graduate",
    studentData['isFirstGraduate'] == true ? "Yes" : "No"),
_infoRow("First Graduate Cert No",
    studentData['firstGraduateCertNo']),
_infoRow("Nativity Certificate",
    studentData['hasNativityCert'] == true ? "Yes" : "No"),
_infoRow("Nativity Cert No",
    studentData['nativityCertNo']),
      const SizedBox(height: 20),


      // ================= DOCUMENTS =================
      _sectionTitle("Uploaded Documents"),
      _documentLink(context, "Photo", studentData['photoUrl']),
      _documentLink(context, "Signature", studentData['signatureUrl']),
      _documentLink(context, "10th Mark Sheet",
          studentData['mark10Url']),
      _documentLink(context, "12th Mark Sheet",
          studentData['mark12Url']),
      _documentLink(context, "Transfer Certificate",
          studentData['transferCertUrl']),
      _documentLink(context, "Degree Marksheet",
          studentData['degreeMarksheetUrl']),
      _documentLink(context, "Community Certificate",
          studentData['communityCertUrl']),
      _documentLink(context, "Income Certificate",
          studentData['incomeCertUrl']),
      _documentLink(context, "First Graduate Cert",
          studentData['firstGraduateCertUrl']),
      _documentLink(context, "Nativity Certificate",
          studentData['nativityCertUrl']),


      const SizedBox(height: 30),


      // ================= ACTION BUTTONS =================
      if ((studentData['status'] ?? 'pending') == 'pending')
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () =>
                    _updateStatus(context, 'approved'),
                child: const Text("Approve"),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () =>
                    _updateStatus(context, 'rejected'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red),
                child: const Text("Reject"),
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
 Widget _infoRow(String title, dynamic value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: Text(
            value?.toString() ?? "-",
          ),
        ),
      ],
    ),
  );
}
Widget _sectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 10),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
Widget _statusBadge(String status) {
  Color color;


  switch (status) {
    case 'approved':
      color = Colors.green;
      break;
    case 'rejected':
      color = Colors.red;
      break;
    default:
      color = Colors.orange;
  }


  return Container(
    padding: const EdgeInsets.symmetric(
        horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withOpacity(0.15),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      status.toUpperCase(),
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600),
    ),
  );


}
Widget _documentLink(BuildContext context,String title, String? url) {
  if (url == null || url.isEmpty) {
    return const SizedBox();
  }


  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
      title: Text(title),
      trailing: const Icon(Icons.visibility),
      onTap: () async {


        // 🌐 WEB
        if (kIsWeb) {
          final uri = Uri.parse(url);
          await launchUrl(
            uri,
            mode: LaunchMode.platformDefault,
          );
        }


        // 📱 ANDROID / IOS
        else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PdfViewerScreen(
                url: url,
                title: title,
              ),
            ),
          );
        }
      },
    ),
  );
}
}
class PdfViewerScreen extends StatefulWidget {
  final String url;
  final String title;


  const PdfViewerScreen({
    super.key,
    required this.url,
    required this.title,
  });


  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}


class _PdfViewerScreenState extends State<PdfViewerScreen> {
  String? localPath;
  bool isLoading = true;


  @override
  void initState() {
    super.initState();
    _downloadFile();
  }


  Future<void> _downloadFile() async {
    try {
      final response = await http.get(Uri.parse(widget.url));
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/temp.pdf');
      await file.writeAsBytes(response.bodyBytes);


      setState(() {
        localPath = file.path;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : localPath != null
              ? PDFView(filePath: localPath!)
              : const Center(child: Text("Failed to load PDF")),
    );
  }
}
