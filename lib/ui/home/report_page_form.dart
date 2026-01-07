import 'package:flutter/material.dart';
import 'package:inspection_report_project/core/Widgets/build_field.dart';

import '../../core/Widgets/cell_widgets.dart';
import '../../core/Widgets/shipiing_table.dart';
import '../model/production_status.dart';
import '../model/shipping_model.dart';

class ReportFormPage extends StatefulWidget {
  static const String routeName = 'report_form';

  const ReportFormPage({super.key});

  @override
  State<ReportFormPage> createState() => _ReportFormPageState();
}

class _ReportFormPageState extends State<ReportFormPage> {
  List<ShippingRow> shippingRows = [ShippingRow(date: '', po: '', units: '')];
  final List<StatusRow> statusRows = [
    StatusRow(label: "Cut", controller: TextEditingController()),
    StatusRow(label: "Sewn", controller: TextEditingController()),
    StatusRow(label: "Pressed", controller: TextEditingController()),
    StatusRow(label: "Packed", controller: TextEditingController()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Align(
        alignment: AlignmentGeometry.centerRight,
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.arrow_forward),
        ),
      ),
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
                  SizedBox(height: 100),
                  Column(
                    children: [
                      ShippingTable(
                        tableTitle: "Cut / POs Details",
                        rows: shippingRows,
                        onRowsChanged: (updatedRows) {
                          setState(() {
                            shippingRows = updatedRows;
                          });
                        },
                      ),

                      SizedBox(height: 100),

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                "Production Status",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            // ===== Header =====
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: const BoxDecoration(
                                color: Color(0xFFE3F2FD),
                              ),
                              child: const Text(
                                "percentage (%) completed",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),

                            // ===== Table =====
                            Table(
                              border: TableBorder(
                                horizontalInside: BorderSide(
                                  color: Colors.grey,
                                ),
                                verticalInside: BorderSide(color: Colors.grey),
                              ),
                              children: [
                                TableRow(
                                  children: [
                                    cellText("Cut"),
                                    cellInput(statusRows[0].controller),
                                    cellText("Pressed"),
                                    cellInput(statusRows[2].controller),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    cellText("Sewn"),
                                    cellInput(statusRows[1].controller),
                                    cellText("Packed"),
                                    cellInput(statusRows[3].controller),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
