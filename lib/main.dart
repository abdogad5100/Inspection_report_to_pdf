import 'package:flutter/material.dart';
import 'package:inspection_report_project/ui/Screens/defects_table_screen.dart';
import 'package:inspection_report_project/ui/Screens/overAll_result_section.dart';
import 'package:inspection_report_project/ui/Screens/report_page_form.dart';
import 'package:inspection_report_project/ui/Screens/workmanship_defectList.dart';
import 'package:provider/provider.dart';

import 'core/Providers/reportData.dart';
import 'core/Providers/report_overall_result.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ReportData()),
        ChangeNotifierProvider(create: (_) => ReportOverallResult()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: ReportFormPage.routeName,
      routes: {
        ReportFormPage.routeName: (context) => const ReportFormPage(),
        OverallResultSection.routeName: (context) =>
            const OverallResultSection(),
        WorkmanShipDefectList.routeName: (context) =>
            const WorkmanShipDefectList(),
        DefectsTableScreen.routeName: (context) => const DefectsTableScreen(),
      },
    );
  }
}
