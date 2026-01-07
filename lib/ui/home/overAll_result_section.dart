import 'package:flutter/material.dart';
import 'package:inspection_report_project/core/Widgets/build_field.dart';

import '../../core/Widgets/resultOptionWidget.dart';

class OverallResultSection extends StatefulWidget {
  const OverallResultSection({super.key});

  @override
  State<OverallResultSection> createState() => _OverallResultSectionState();
}

class _OverallResultSectionState extends State<OverallResultSection> {
  bool? workmanshipResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Overall Result Section")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // العمود الأول: قسمناه لصف فيه عمودين صغيرين
              Expanded(
                child: Column(
                  children: [
                    const ResultOptionWidget(label: "Workmanship"),
                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        Expanded(child: BuildField(label: "Sample Pull 1")),
                        SizedBox(width: 10),
                        Expanded(child: BuildField(label: "Sample Pull 2")),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 100), // مسافة بين الأعمدة
              // العمود الثاني: ممكن يخلي BuildField عمودي
              Expanded(
                child: Column(
                  children: const [
                    ResultOptionWidget(label: "Workmanship"),
                    SizedBox(height: 10),
                    BuildField(label: "Sample Pull"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
