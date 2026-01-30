import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/Providers/reportData.dart';
import '../../core/Widgets/build_field.dart';
import '../../core/Widgets/cell_widgets.dart';
import '../../core/Widgets/shipiing_table.dart';
import 'overAll_result_section.dart';

class ReportFormPage extends StatelessWidget {
  static const String routeName = 'report_form';

  const ReportFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Align(
        alignment: AlignmentGeometry.centerRight,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, OverallResultSection.routeName);
          },
          child: const Icon(Icons.arrow_forward),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Consumer<ReportData>(
          builder: (context, reportData, child) {
            return SingleChildScrollView(
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

                  // ===== Customer / Prod.Mgr / Auditor etc =====
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            BuildField(
                              label: "Customer",
                              controller: reportData.fields["Customer"]!,
                            ),
                            BuildField(
                              label: "Prod.Mgr",
                              controller: reportData.fields["Prod.Mgr"]!,
                            ),
                            BuildField(
                              label: "Auditor",
                              controller: reportData.fields["Auditor"]!,
                            ),
                            BuildField(
                              label: "Insp Date",
                              controller: reportData.fields["Insp Date"]!,
                            ),
                            BuildField(
                              label: "Vendor",
                              controller: reportData.fields["Vendor"]!,
                            ),
                            BuildField(
                              label: "Factory",
                              controller: reportData.fields["Factory"]!,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          children: [
                            BuildField(
                              label: "S/O No",
                              controller: reportData.fields["S/O No"]!,
                            ),
                            BuildField(
                              label: "Art Descr",
                              controller: reportData.fields["Art Descr"]!,
                            ),
                            BuildField(
                              label: "Style No",
                              controller: reportData.fields["Style No"]!,
                            ),
                            BuildField(
                              label: "Sytle Desc",
                              controller: reportData.fields["Sytle Desc"]!,
                            ),
                            BuildField(
                              label: "Fabrication",
                              controller: reportData.fields["Fabrication"]!,
                            ),
                            BuildField(
                              label: "Color",
                              controller: reportData.fields["Color"]!,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 50),

                  // ===== Shipping Table =====
                  ShippingTable(
                    tableTitle: "Cut / POs Details",
                    rows: reportData.shippingRows,
                    onRowsChanged: reportData.updateShippingRows,
                  ),

                  const SizedBox(height: 50),

                  // ===== Production Status =====
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "Production Status",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
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
                        Table(
                          border: TableBorder(
                            horizontalInside: const BorderSide(
                              color: Colors.grey,
                            ),
                            verticalInside: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          children: [
                            TableRow(
                              children: [
                                cellText("Cut"),
                                cellInput(
                                  reportData.statusRows["Cut"]!,
                                  border: InputBorder.none,
                                ),
                                cellText("Pressed"),
                                cellInput(
                                  reportData.statusRows["Pressed"]!,
                                  border: InputBorder.none,
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                cellText("Sewn"),
                                cellInput(
                                  reportData.statusRows["Sewn"]!,
                                  border: InputBorder.none,
                                ),
                                cellText("Packed"),
                                cellInput(
                                  reportData.statusRows["Packed"]!,
                                  border: InputBorder.none,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
