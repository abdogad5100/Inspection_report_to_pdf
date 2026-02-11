import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/Providers/worksman_ship_defect.dart';
import '../../core/Widgets/image_dropdown_card.dart';
import '../../core/pdf/report_pdf_generator.dart';

class WorkmanShipDefectList extends StatelessWidget {
  static const String routeName = 'DefectList';

  const WorkmanShipDefectList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WorksmanShipDefect>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Workmanship Defects"),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            tooltip: "Generate PDF",
            onPressed: () async {
              await generateReportPdf(context);
            },
          ),
        ],
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Align(
          alignment: AlignmentGeometry.bottomLeft,
          child: FloatingActionButton(
            heroTag: 'backBtn',
            onPressed: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: provider.images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            return ImageDropdownCard(
              image: provider.images[index],
              items: provider.dropdownItems,
              selectedValue: provider.selectedValues[index],

              onPickImage: () => provider.pickImage(index),

              onChanged: (val) => provider.setDropdownValue(index, val),

              onAdd: provider.addCard,
              onDelete: () => provider.deleteCard(index),
            );
          },
        ),
      ),
    );
  }
}
