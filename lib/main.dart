import 'package:flutter/material.dart';
import 'package:inspection_report_project/ui/home/overAll_result_section.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OverallResultSection(),
    );
  }
}
