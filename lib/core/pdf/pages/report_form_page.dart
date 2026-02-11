import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../Providers/reportData.dart';

class ReportFormPdfPage {
  static pw.Widget build(ReportData data) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [_leftInfo(data), pw.SizedBox(width: 30), _rightInfo(data)],
        ),

        pw.SizedBox(height: 30),

        /// ===== SHIPPING + PRODUCTION =====
        _shippingAndProductionRow(data),
      ],
    );
  }

  // ================= LEFT INFO =================
  static pw.Widget _leftInfo(ReportData data) {
    return pw.Expanded(
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          infoRow("Customer", data.fields["Customer"]!.text),
          infoRow("Prod. Mgr", data.fields["Prod.Mgr"]!.text),
          infoRow("Auditor", data.fields["Auditor"]!.text),
          infoRow("Insp Date", data.fields["Insp Date"]!.text),
          infoRow("Vendor", data.fields["Vendor"]!.text),
          infoRow("Factory", data.fields["Factory"]!.text),
        ],
      ),
    );
  }

  // ================= RIGHT INFO =================
  static pw.Widget _rightInfo(ReportData data) {
    return pw.Expanded(
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          infoRow("S/O No", data.fields["S/O No"]!.text),
          infoRow("Art Descr", data.fields["Art Descr"]!.text),
          infoRow("Style No", data.fields["Style No"]!.text),
          infoRow("Style Desc", data.fields["Sytle Desc"]!.text),
          infoRow("Fabrication", data.fields["Fabrication"]!.text),
          infoRow("Color", data.fields["Color"]!.text),
        ],
      ),
    );
  }

  static pw.Widget infoRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Row(
        children: [
          pw.SizedBox(
            width: 80,
            child: pw.Text("$label:", style: pw.TextStyle(fontSize: 10)),
          ),
          pw.Expanded(
            child: pw.Text(
              value,
              style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // ================= SHIPPING + PRODUCTION ROW =================
  static pw.Widget _shippingAndProductionRow(ReportData data) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        /// ===== SHIPPING TABLE =====
        pw.Expanded(
          flex: 3,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "Cut / POs Details List",
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 8),
              shippingTable(data),
            ],
          ),
        ),

        pw.SizedBox(width: 20),

        /// ===== PRODUCTION STATUS =====
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            children: [
              pw.Text(
                "Production Status",
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 8),
              productionStatus(data),
            ],
          ),
        ),
      ],
    );
  }

  // ================= SHIPPING TABLE =================
  static pw.Widget shippingTable(ReportData data) {
    return pw.Table(
      border: pw.TableBorder.all(width: 0.5),
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey300),
          children: [
            cell("PO Number", bold: true),
            cell("Units", bold: true),
            cell("Shipping Date", bold: true),
          ],
        ),
        ...data.shippingRows.map(
          (row) => pw.TableRow(
            children: [
              cell(row.po),
              cell(row.units.toString()),
              cell(row.date),
            ],
          ),
        ),
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey200),
          children: [
            cell("Total Units", bold: true),
            cell(data.totalUnits.toString(), bold: true),
            cell(""),
          ],
        ),
      ],
    );
  }

  // ================= PRODUCTION STATUS =================
  static pw.Widget productionStatus(ReportData data) {
    return pw.Container(
      decoration: pw.BoxDecoration(border: pw.Border.all(width: 0.5)),
      child: pw.Column(
        children: [
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(8),
            child: pw.Text(
              "percentage (%) completed",
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Table(
            border: pw.TableBorder.all(width: 0.5),
            children: [
              pw.TableRow(
                children: [
                  cell("Cut"),
                  cell(data.statusRows["Cut"]!.text),
                  cell("Pressed"),
                  cell(data.statusRows["Pressed"]!.text),
                ],
              ),
              pw.TableRow(
                children: [
                  cell("Sewn"),
                  cell(data.statusRows["Sewn"]!.text),
                  cell("Packed"),
                  cell(data.statusRows["Packed"]!.text),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget cell(String text, {bool bold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(6),
      child: pw.Text(
        text,
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(
          fontSize: 10,
          fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }
}
