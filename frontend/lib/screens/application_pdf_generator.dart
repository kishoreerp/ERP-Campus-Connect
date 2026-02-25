import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ApplicationPdfGenerator {
  static Future<Uint8List> generate({
    required Map<String, dynamic> data,
    Uint8List? photoBytes,
    Uint8List? signatureBytes,
    Uint8List? logoBytes,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) => [

          // ================= HEADER =================
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [

              if (logoBytes != null)
                pw.Container(
                  width: 70,
                  height: 70,
                  child: pw.Image(pw.MemoryImage(logoBytes)),
                ),

              pw.SizedBox(width: 15),

              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text(
  "ST. LOURDES ENGINEERING COLLEGE",
  style: pw.TextStyle(
    fontSize: 16,
    fontWeight: pw.FontWeight.bold,
    color: PdfColor.fromInt(0xFF800000), // Maroon
  ),
  textAlign: pw.TextAlign.center,
),

pw.SizedBox(height: 3),

pw.Text(
  "Approved by AICTE, New Delhi & Affiliated to Anna University, Chennai",
  style: const pw.TextStyle(fontSize: 9),
  textAlign: pw.TextAlign.center,
),

pw.SizedBox(height: 1),

pw.Text(
  "Thanir Arul Nagar, Perambalur - 621 212",
  style: const pw.TextStyle(fontSize: 9),
  textAlign: pw.TextAlign.center,
),

pw.SizedBox(height: 1),

pw.Text(
  "044-24748071 | 8181861735 | 8900500600",
  style: const pw.TextStyle(fontSize: 9),
  textAlign: pw.TextAlign.center,
),

pw.SizedBox(height: 1),

pw.Text(
  "www.slec.edu.in | info@slec.edu.in",
  style: const pw.TextStyle(fontSize: 9),
  textAlign: pw.TextAlign.center,
),


                    pw.SizedBox(height: 5),
                    pw.Text(
                      "ADMISSION APPLICATION FORM",
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              if (photoBytes != null)
                pw.Container(
                  width: 80,
                  height: 100,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(),
                  ),
                  child: pw.Image(pw.MemoryImage(photoBytes)),
                ),
            ],
          ),

          pw.Divider(),

          // ================= PROGRAM =================
          _section("Program Details", [
            _row("Program", data['program']),
            _row("Degree", data['degree']),
            _row("Department", data['department']),
          ]),

          // ================= PERSONAL =================
          _section("Personal Information", [
            _row("Full Name", data['fullName']),
            _row("Date of Birth", data['dob']),
            _row("Gender", data['gender']),
            _row("Blood Group", data['bloodGroup']),
            _row("Aadhaar", data['aadhaar']),
            _row("Email", data['email']),
            _row("Mobile", data['phone']),
            _row("Address", data['address']),
          ]),

          // ================= PARENTS =================
          _section("Parents / Guardian Details", [
            _row("Father Name", data['fatherName']),
            _row("Father Mobile", data['fatherMobile']),
            _row("Father Occupation", data['fatherOccupation']),
            _row("Mother Name", data['motherName']),
            _row("Mother Mobile", data['motherMobile']),
            _row("Mother Occupation", data['motherOccupation']),
            _row("Guardian Name", data['guardianName']),
            _row("Guardian Mobile", data['guardianMobile']),
            _row("Guardian Occupation", data['guardianOccupation']),
          ]),

          // ================= ACADEMIC =================
          _section("Academic Details", [
            _row("Previous Education", data['previousEducation']),
            _row("10th Mark", data['10thMark']),
            _row("12th Mark", data['12thMark']),
            _row("Degree Percentage", data['degreePercentage']),
          ]),

          // ================= COMMUNITY =================
          _section("Community & Certificates", [
            _row("EMIS ID", data['emisId']),
            _row("Religion", data['religion']),
            _row("Caste", data['caste']),
            _row("Community", data['community']),
            _row("Community Cert No", data['communityCertNo']),
            _row("Annual Income", data['annualIncome']),
            _row("Income Cert No", data['incomeCertNo']),
            _row("First Graduate", data['isFirstGraduate'] == true ? "Yes" : "No"),
            _row("First Graduate Cert No", data['firstGraduateCertNo']),
            _row("Nativity", data['hasNativityCert'] == true ? "Yes" : "No"),
            _row("Nativity Cert No", data['nativityCertNo']),
          ]),

          pw.SizedBox(height: 25),

          // ================= DECLARATION =================
          pw.Text(
            "Declaration",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 12,
            ),
          ),
          pw.SizedBox(height: 5),
          pw.Text(
            "I hereby declare that the above information is true and correct to the best of my knowledge.",
          ),

          pw.SizedBox(height: 40),

          // ================= SIGNATURE =================
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                children: [
                  if (signatureBytes != null)
                    pw.Image(
                      pw.MemoryImage(signatureBytes),
                      width: 100,
                      height: 40,
                    ),
                  pw.SizedBox(height: 5),
                  pw.Text("Applicant Signature"),
                ],
              ),
              pw.Column(
                children: [
                  pw.Text(data['formDate'] ?? ''),
                  pw.SizedBox(height: 5),
                  pw.Text("Date"),
                ],
              ),
            ],
          ),
        ],
      ),
    );

    return pdf.save();
  }

  // ================= SECTION BUILDER =================
  static pw.Widget _section(String title, List<pw.Widget> children) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(top: 15),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(),
      ),
      child: pw.Column(
        children: [
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(6),
            color: PdfColors.grey300,
            child: pw.Text(
              title,
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  static pw.Widget _row(String label, dynamic value) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          top: pw.BorderSide(),
        ),
      ),
      child: pw.Row(
        children: [
          pw.Container(
            width: 150,
            padding: const pw.EdgeInsets.all(6),
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                right: pw.BorderSide(),
              ),
            ),
            child: pw.Text(
              label,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Expanded(
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(6),
              child: pw.Text(
                value == null || value.toString().isEmpty
                    ? "-"
                    : value.toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}