import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/report_overall_result.dart';

class ResultOptionWidget extends StatelessWidget {
  final String label;
  const ResultOptionWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final report = context.watch<ReportOverallResult>();
    bool? selectedValue = report.getResult(label);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(label, style: const TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold)),
          Row(
            children: [
              Radio<bool>(
                value: true,
                groupValue: selectedValue,
                onChanged: (value) {
                  if (value != null) report.setResult(label, value);
                },
              ),
              const Text("PASS", style: TextStyle(fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green)),
            ],
          ),
          Row(
            children: [
              Radio<bool>(
                value: false,
                groupValue: selectedValue,
                onChanged: (value) {
                  if (value != null) report.setResult(label, value);
                },
              ),
              const Text("FAIL", style: TextStyle(fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.red)),
            ],
          ),
        ],
      ),
    );
  }
}
