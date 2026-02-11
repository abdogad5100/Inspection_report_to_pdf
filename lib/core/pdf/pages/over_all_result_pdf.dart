import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../Providers/report_overall_result.dart';

class OverallResultPdfPage {
  static const List<String> packingItems = [
    "1.Garments testing completed",
    "2.Technical Spec & Approval Sample",
    "3.Shipping Mark & Carton Sticker",
    "4.Polybag and Assortment units",
    "5.Hangtags and Price Tickets",
    "6.Main Label placement & content",
    "7.Care Label placement & content",
    "8.Hanger & Size Cap",
  ];

  static pw.Widget build(ReportOverallResult data) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        overallHeader(data),
        pw.SizedBox(height: 15),
        workmanshipAndMeasurement(data),
        pw.SizedBox(height: 15),
        commentsSection(
          "Brief Comments for Workmanship and/or Measurement:",
          data.workmanshipComments.text,
        ),
        pw.SizedBox(height: 20),
        packingSection(data),
        pw.SizedBox(height: 10),
        commentsSection(
          "Brief Comments for Packing and/or Package:",
          data.packingComments.text,
        ),
      ],
    );
  }

  // ================= OVERALL RESULT =================
  static pw.Widget overallHeader(ReportOverallResult report) {
    final isPass = report.getResult("overall") == true;

    return pw.Row(
      children: [
        pw.Text(
          "OVERALL RESULT:",
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(width: 20),
        pw.Text(
          isPass ? "PASS" : "FAIL",
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
        ),
      ],
    );
  }

  // ================= WORKMANSHIP + MEASUREMENT =================
  static pw.Widget workmanshipAndMeasurement(ReportOverallResult report) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        /// ================= WORKMANSHIP =================
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  sectionTitle("WORKMANSHIP"),
                  pw.SizedBox(width: 12),
                  passFailRow(report.getResult("WORKMANSHIP")),
                ],
              ),
              pw.Divider(thickness: 1),
              pw.Container(
                padding: const pw.EdgeInsets.all(6),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    /// ===== LEFT COLUMN =====
                    pw.Expanded(
                      child: pw.Column(
                        children: [
                          valueRow("Sample Pull:", report.samplePull.text),
                          valueRow("Pass On:", report.passOn.text),
                          valueRow("Reject On:", report.RejectOn.text),
                          valueRow(
                            "Total Defective:",
                            report.totalDefective.text,
                            bold: true,
                          ),
                        ],
                      ),
                    ),
                    pw.SizedBox(width: 12),

                    /// ===== RIGHT COLUMN =====
                    pw.Expanded(
                      child: pw.Column(
                        children: [
                          valueRow("Major:", report.major.text),
                          valueRow("Minor:", report.minor.text),
                          valueRow("Critical:", report.critical.text),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        pw.SizedBox(width: 30),

        /// ================= MEASUREMENT =================
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  sectionTitle("MEASUREMENT"),
                  pw.SizedBox(width: 12),
                  passFailRow(report.getResult("MEASUREMENT")),
                ],
              ),
              pw.Divider(thickness: 1),
              pw.SizedBox(height: 6),
              valueRow("Sample Pull:", report.measurementSamplePull.text),
              valueRow("Accept On:", report.acceptOn.text),
              valueRow("Reject On:", report.rejectOn.text),
              valueRow("Total Major:", report.totalMajor.text),
            ],
          ),
        ),
      ],
    );
  }

  // ================= PACKING =================
  static pw.Widget packingSection(ReportOverallResult report) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            sectionTitle("PACKING and PACKAGING"),
            passFailRow(report.getResult("PACKING and PACKAGING")),
          ],
        ),
        pw.Divider(),

        ...packingItems.map((key) {
          final value = report.packingResults[key] ?? "NA";

          return pw.Row(
            children: [
              pw.Expanded(child: pw.Text(key)),
              check(value == "Yes"),
              pw.Text(" Yes  "),
              check(value == "No"),
              pw.Text(" No  "),
              check(value == "NA"),
              pw.Text(" NA"),
            ],
          );
        }),
      ],
    );
  }

  // ================= HELPERS =================
  static pw.Widget sectionTitle(String title) {
    return pw.Text(
      "- $title",
      style: pw.TextStyle(
        fontSize: 12,
        fontWeight: pw.FontWeight.bold,
        color: PdfColors.grey700,
      ),
    );
  }

  static pw.Widget valueRow(String label, String value, {bool bold = false}) {
    return pw.Row(
      children: [
        pw.Expanded(child: pw.Text(label)),
        pw.Text(
          value.isEmpty ? "0" : value,
          style: pw.TextStyle(
            fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        ),
      ],
    );
  }

  static pw.Widget passFailRow(bool? value) {
    final result = value ?? false;

    return pw.Row(
      children: [
        check(result == true),
        pw.Text(" Pass "),
        check(result == false),
        pw.Text(" Fail "),
      ],
    );
  }

  // ================= COMMENTS =================
  static pw.Widget commentsSection(String title, String value) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 5),
        pw.Text(value.isEmpty ? "0" : value),
      ],
    );
  }

  static pw.Widget check(bool checked) {
    return pw.Container(
      width: 10,
      height: 10,
      decoration: pw.BoxDecoration(
        color: checked ? PdfColors.grey : PdfColors.white,

        border: pw.Border.all(width: 1),
      ),
    );
  }
}
