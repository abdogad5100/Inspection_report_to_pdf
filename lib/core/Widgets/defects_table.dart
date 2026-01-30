import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'cell_widgets.dart';

class DefectsTable extends StatelessWidget {
  final List<List<TextEditingController>> rows;
  final List<XFile?> images;

  final VoidCallback onAddRow;
  final void Function(int index) onDeleteRow;
  final void Function(int index) onPickImage;
  final void Function(int index, XFile? image) onImageChanged;

  const DefectsTable({
    super.key,
    required this.rows,
    required this.images,
    required this.onAddRow,
    required this.onDeleteRow,
    required this.onPickImage,
    required this.onImageChanged,
  });

  static const double itemColumnWidth = 90;

  /// 👇 توزيع الأعمدة (لازم ثابت)
  static const List<int> columnFlex = [
    1, // Category
    1, // Code
    2, // Description (أعرض)
    1, // Picture
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// ================= HEADER =================
        Container(
          color: Colors.grey[300],
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              SizedBox(width: itemColumnWidth, child: cellText("Item")),
              Expanded(flex: columnFlex[0], child: cellText("Category")),
              Expanded(flex: columnFlex[1], child: cellText("Code")),
              Expanded(flex: columnFlex[2], child: cellText("Description")),
              Expanded(flex: columnFlex[3], child: cellText("Picture")),
              const SizedBox(width: 48),
            ],
          ),
        ),

        /// ================= BODY =================
        Expanded(
          child: ListView.builder(
            itemCount: rows.length + 1,
            itemBuilder: (context, index) {
              /// ADD ROW
              if (index == rows.length) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text("Add Row"),
                      onPressed: onAddRow,
                    ),
                  ),
                );
              }

              return Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                constraints: const BoxConstraints(minHeight: 60),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ITEM
                    SizedBox(
                      width: itemColumnWidth,
                      child: Center(
                        child: Text(
                          'Item ${index + 1}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),

                    /// CATEGORY
                    Expanded(
                      flex: columnFlex[0],
                      child: cellInput(rows[index][0]),
                    ),

                    /// CODE
                    Expanded(
                      flex: columnFlex[1],
                      child: cellInput(rows[index][1]),
                    ),

                    /// DESCRIPTION (multiline)
                    Expanded(
                      flex: columnFlex[2],
                      child: cellMultilineInput(rows[index][2]),
                    ),

                    /// IMAGE
                    Expanded(
                      flex: columnFlex[3],
                      child: cellImage(
                        image: images[index],
                        onPick: () => onPickImage(index),
                      ),
                    ),

                    /// DELETE
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => onDeleteRow(index),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
