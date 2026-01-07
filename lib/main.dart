import 'package:flutter/material.dart';
import 'package:inspection_report_project/ui/home/report_page_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: ReportFormPage.routeName,
      routes: {
        ReportFormPage.routeName: (context) => const ReportFormPage(),

      },
    );
  }
}
