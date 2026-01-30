import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inspection_report_project/ui/Screens/workmanship_defectList.dart';

import '../../core/Widgets/defects_table.dart';

class DefectsTableScreen extends StatefulWidget {
  static const String routeName = 'Defect_list';

  const DefectsTableScreen({super.key});

  @override
  State<DefectsTableScreen> createState() => _DefectsTableScreenState();
}

class _DefectsTableScreenState extends State<DefectsTableScreen> {
  final ImagePicker picker = ImagePicker();

  List<List<TextEditingController>> rows = [
    List.generate(4, (_) => TextEditingController()),
  ];

  List<XFile?> images = [null];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Defects Table")),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: AlignmentGeometry.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: FloatingActionButton(
                heroTag: 'backBtn',
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back),
              ),
            ),
          ),
          Align(
            alignment: AlignmentGeometry.centerRight,
            child: FloatingActionButton(
              heroTag: 'actionBtn',
              onPressed: () {
                Navigator.pushNamed(context, WorkmanShipDefectList.routeName);
              },
              child: const Icon(Icons.arrow_forward),
            ),
          ),
        ],
      ),

      body: DefectsTable(
        rows: rows,
        images: images,

        onAddRow: () {
          setState(() {
            rows.add(List.generate(4, (_) => TextEditingController()));
            images.add(null);
          });
        },

        onDeleteRow: (index) {
          setState(() {
            for (var c in rows[index]) {
              c.dispose();
            }
            rows.removeAt(index);
            images.removeAt(index);
          });
        },

        onImageChanged: (index, image) {
          setState(() => images[index] = image);
        },
        onPickImage: (index) async {
          final picked = await picker.pickImage(source: ImageSource.gallery);
          if (picked != null) {
            setState(() => images[index] = picked);
          }
        },
      ),
    );
  }
}
