import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/reportData.dart';
import '../Providers/report_overall_result.dart';
import 'final_report_pdf.dart';

Future<void> generateReportPdf(BuildContext context) async {
  final reportData = context.read<ReportData>();
  final overallResult = context.read<ReportOverallResult>();

  Directory getDownloadsDirectory() {
    final home = Platform.environment['USERPROFILE'];
    return Directory('$home\\Downloads');
  }

  final downloadsDir = getDownloadsDirectory();

  final file = await FinalReportPdf.generate(
    data: reportData,
    overall: overallResult,
    fileName: 'inspection_report',
    saveDir: downloadsDir,
  );

  debugPrint("PDF generated: ${file.path}");
}
