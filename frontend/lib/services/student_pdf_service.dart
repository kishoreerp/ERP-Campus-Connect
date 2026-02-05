import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class StudentPdfService {
  static Future<Uint8List> generate(Map<String, dynamic> data) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Student Details',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 12),

              _row('Name', data['username']),
              _row('Email', data['email']),
              _row('Student ID', data['studentId']),
              _row('Department', data['department']),
              _row('Year', data['year']),
              _row('Phone', data['phone']),
              _row('Address', data['address'] ?? ''),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _row(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Row(
        children: [
          pw.Expanded(
              flex: 2,
              child: pw.Text(label,
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
          pw.Expanded(flex: 3, child: pw.Text(value)),
        ],
      ),
    );
  }
}
