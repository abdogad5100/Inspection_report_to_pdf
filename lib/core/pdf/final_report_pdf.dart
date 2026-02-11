import 'dart:io';

import 'package:flutter/services.dart';
import 'package:inspection_report_project/core/pdf/pages/over_all_result_pdf.dart';
import 'package:inspection_report_project/core/pdf/pages/report_form_page.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Providers/reportData.dart';
import '../Providers/report_overall_result.dart';

class FinalReportPdf {
  static Future<File> generate({
    required ReportData data,
    required ReportOverallResult overall,
    required String fileName,
    required Directory saveDir,
  }) async {
    final pdf = pw.Document();

    final Uint8List logoBytes = (await rootBundle.load(
      'assets/images/logo.jpg',
    )).buffer.asUint8List();

    final pw.MemoryImage logoImage = pw.MemoryImage(logoBytes);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.fromLTRB(24, 8, 24, 24),

        /// ===== HEADER =====
        header: (context) {
          return pw.Container(
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,

              children: [
                pw.Image(logoImage, width: 150, fit: pw.BoxFit.fitWidth),

                /// ===== LEFT TEXT =====
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text(
                      "INSPECTION REPORT",
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),

                    pw.Text(
                      "Final Random Inspection",
                      style: const pw.TextStyle(fontSize: 10),
                    ),
                  ],
                ),

                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Rep Period: ${data.reportPeriod.text}",
                      style: const pw.TextStyle(fontSize: 8),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Text(
                      "Repor No: ${data.reportCode.text}",
                      style: const pw.TextStyle(fontSize: 8),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Text(
                      "P Of Pages: ${context.pageNumber} / ${context.pagesCount}",
                      style: const pw.TextStyle(fontSize: 8),
                    ),
                  ],
                ),
              ],
            ),
          );
        },

        /// ===== CONTENT =====
        build: (context) => [
          ReportFormPdfPage.build(data),
          pw.SizedBox(height: 30),
          OverallResultPdfPage.build(overall),
        ],
      ),
    );

    if (!await saveDir.exists()) {
      await saveDir.create(recursive: true);
    }

    final file = File('${saveDir.path}${Platform.pathSeparator}$fileName.pdf');

    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
