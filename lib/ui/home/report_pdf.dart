import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> generateInspectionPdf({
  required String reportNo,
  required String customer,
  required String vendor,
  required String factory,
  required String style,
  required bool workmanshipFail,
}) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Padding(
          padding: const pw.EdgeInsets.all(20),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "INSPECTION REPORT",
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 20),

              pw.Text("Report No: $reportNo"),
              pw.Text("Customer: $customer"),
              pw.Text("Vendor: $vendor"),
              pw.Text("Factory: $factory"),
              pw.Text("Style No: $style"),

              pw.SizedBox(height: 30),

              pw.Container(
                padding: const pw.EdgeInsets.all(10),
                color: workmanshipFail ? PdfColors.red : PdfColors.green,
                child: pw.Text(
                  workmanshipFail
                      ? "OVERALL RESULT: FAIL"
                      : "OVERALL RESULT: PASS",
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );

  final projectDir = Directory.current;
  final resultsDir = Directory(path.join(projectDir.path, 'results'));

  if (!resultsDir.existsSync()) {
    resultsDir.createSync(recursive: true);
  }

  final file = File(path.join(resultsDir.path, 'inspection_report.pdf'));

  await file.writeAsBytes(await pdf.save());

  print("PDF saved at: ${file.path}");
}
