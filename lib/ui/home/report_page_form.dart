import 'package:flutter/material.dart';
import 'package:inspection_report_project/core/Widgets/build_field.dart';

import '../../core/Widgets/shipiing_table.dart';
import '../model/shipping_model.dart';

class ReportFormPage extends StatefulWidget {
  const ReportFormPage({super.key});

  @override
  State<ReportFormPage> createState() => _ReportFormPageState();
}

class _ReportFormPageState extends State<ReportFormPage> {
  List<ShippingRow> shippingRows = [ShippingRow(date: '', po: '', units: '')];

  List<ShippingRow> table2Rows = [ShippingRow(date: '', po: '', units: '')];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: SizedBox(
              width: 1000,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "INSPECTION REPORT",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Final Random Inspection",
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(height: 50),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            BuildField(label: "Customer"),
                            BuildField(label: "Prod.Mgr"),
                            BuildField(label: "Auditor"),
                            BuildField(label: "Insp Date"),
                            BuildField(label: "Vendor"),
                            BuildField(label: "Factory"),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          children: [
                            BuildField(label: "S/O No"),
                            BuildField(label: "Art Descr"),
                            BuildField(label: "Style No"),
                            BuildField(label: "Sytle Desc"),
                            BuildField(label: "Fabrication"),
                            BuildField(label: "Color"),
                          ],
                        ),
                      ),
                    ],
                  ),

                  ShippingTable(
                    tableTitle: "Cut / POs Details",
                    rows: shippingRows,
                    onRowsChanged: (updatedRows) {
                      setState(() {
                        shippingRows = updatedRows;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
