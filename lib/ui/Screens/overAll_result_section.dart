import 'package:flutter/material.dart';
import 'package:inspection_report_project/core/Providers/report_overall_result.dart';
import 'package:inspection_report_project/core/Widgets/YesNoSelector.dart';
import 'package:inspection_report_project/core/Widgets/build_field.dart';
import 'package:inspection_report_project/ui/Screens/defects_table_screen.dart';
import 'package:provider/provider.dart';

import '../../core/Widgets/resultOptionWidget.dart';

class OverallResultSection extends StatefulWidget {
  static const String routeName = 'over_all_section';

  const OverallResultSection({super.key});

  @override
  State<OverallResultSection> createState() => _OverallResultSectionState();
}

class _OverallResultSectionState extends State<OverallResultSection> {
  bool? workmanshipResult;

  @override
  Widget build(BuildContext context) {
    final report = context.watch<ReportOverallResult>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Overall Result Section"),
      ),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: FloatingActionButton(
              heroTag: 'backBtn',
              onPressed: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back),
            ),
          ),
          FloatingActionButton(
            heroTag: 'actionBtn',
            onPressed: () {
              Navigator.pushNamed(context, DefectsTableScreen.routeName);
            },
            child: const Icon(Icons.arrow_forward),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// ================= WORKMANSHIP & MEASUREMENT =================
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const ResultOptionWidget(label: "WORKMANSHIP"),
                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Expanded(
                            child: BuildField(
                              label: "Sample Pull:",
                              controller: report.samplePull,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: BuildField(
                              label: "Major",
                              controller: report.major,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: BuildField(
                              label: "Pass On:",
                              controller: report.passOn,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: BuildField(
                              label: "Minor:",
                              controller: report.minor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: BuildField(
                              label: "Reject On:",
                              controller: report.RejectOn,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: BuildField(
                              label: "Critical:",
                              controller: report.critical,
                            ),
                          ),
                        ],
                      ),

                      BuildField(
                        label: "Total Defective Garment Units:",
                        controller: report.totalDefective,
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 100),

                Expanded(
                  child: Column(
                    children: [
                      const ResultOptionWidget(label: "MEASUREMENT"),
                      const SizedBox(height: 10),

                      BuildField(
                        label: "Sample Pull:",
                        controller: report.measurementSamplePull,
                      ),
                      BuildField(
                        label: "Accept On:",
                        controller: report.acceptOn,
                      ),
                      BuildField(
                        label: "Reject On:",
                        controller: report.rejectOn,
                      ),
                      BuildField(
                        label: "Total Major:",
                        controller: report.totalMajor,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// ================= COMMENTS =================
            BuildField(
              label: "Brief Comments for Workmanship and/or Measurement:",
              controller: report.workmanshipComments,
            ),

            const SizedBox(height: 50),

            /// ================= PACKING =================
            Column(
              children: [
                const ResultOptionWidget(label: "PACKING and PACKAGING"),

                YesNoNaSelector(
                  label: "1. Garments testing completed",
                  value: report.packingResults["Garments testing completed"],
                  onChanged: (v) =>
                      report.setPackingResult("Garments testing completed", v),
                ),

                YesNoNaSelector(
                  label: "2. Technical Spec & Approval Sample",
                  value:
                      report.packingResults["Technical Spec & Approval Sample"],
                  onChanged: (v) => report.setPackingResult(
                    "Technical Spec & Approval Sample",
                    v,
                  ),
                ),

                YesNoNaSelector(
                  label: "3. Shipping Mark & Carton Sticker",
                  value:
                      report.packingResults["Shipping Mark & Carton Sticker"],
                  onChanged: (v) => report.setPackingResult(
                    "Shipping Mark & Carton Sticker",
                    v,
                  ),
                ),

                YesNoNaSelector(
                  label: "4. Polybag and Assortment units",
                  value: report.packingResults["Polybag and Assortment units"],
                  onChanged: (v) => report.setPackingResult(
                    "Polybag and Assortment units",
                    v,
                  ),
                ),

                YesNoNaSelector(
                  label: "5. Hangtags and Price Tickets",
                  value: report.packingResults["Hangtags and Price Tickets"],
                  onChanged: (v) =>
                      report.setPackingResult("Hangtags and Price Tickets", v),
                ),

                YesNoNaSelector(
                  label: "6. Main Label placement & content",
                  value:
                      report.packingResults["Main Label placement & content"],
                  onChanged: (v) => report.setPackingResult(
                    "Main Label placement & content",
                    v,
                  ),
                ),

                YesNoNaSelector(
                  label: "7. Care Label placement & content",
                  value:
                      report.packingResults["Care Label placement & content"],
                  onChanged: (v) => report.setPackingResult(
                    "Care Label placement & content",
                    v,
                  ),
                ),

                YesNoNaSelector(
                  label: "8. Hanger & Size Cap",
                  value: report.packingResults["Hanger & Size Cap"],
                  onChanged: (v) =>
                      report.setPackingResult("Hanger & Size Cap", v),
                ),

                BuildField(
                  label: "Brief Comments for Packing and/or Package:",
                  controller: report.packingComments,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
