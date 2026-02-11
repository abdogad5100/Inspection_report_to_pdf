import 'package:flutter/material.dart';
import 'package:inspection_report_project/ui/Screens/workmanship_defectList.dart';
import 'package:provider/provider.dart';

import '../../core/Providers/report_defect_table.dart';
import '../../core/Widgets/defects_table.dart';

class DefectsTableScreen extends StatelessWidget {
  static const String routeName = 'Defect_list';

  const DefectsTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReportDefectTable>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Defects Table"), automaticallyImplyLeading: false,),

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
              Navigator.pushNamed(
                context,
                WorkmanShipDefectList.routeName,
              );
            },
            child: const Icon(Icons.arrow_forward),
          ),
        ],
      ),

      body: DefectsTable(
        rows: provider.rows,
        images: provider.images,
        onAddRow: provider.addRow,
        onDeleteRow: provider.deleteRow,
        onPickImage: provider.pickImage,
        onImageChanged: (i, img) {},
      ),
    );
  }
}
