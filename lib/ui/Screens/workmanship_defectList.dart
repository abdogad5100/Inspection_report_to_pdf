import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/Widgets/image_dropdown_card.dart';

class WorkmanShipDefectList extends StatefulWidget {
  static const String routeName = 'DefectList';

  const WorkmanShipDefectList({super.key});

  @override
  State<WorkmanShipDefectList> createState() => _WorkmanShipDefectListState();
}

class _WorkmanShipDefectListState extends State<WorkmanShipDefectList> {
  final ImagePicker picker = ImagePicker();

  List<XFile?> images = [null];
  List<String?> selectedValues = [null];

  final List<String> dropdownItems = [
    "Shipping Marks",
    "Shipping Stickers",
    "Packing methods",
    "Polybag and its Sticker",
    "Price Tickets",
    "Main Label",
    "Care Label",
    "Art Placement",
    "Bulk Sample",
  ];

  void addCard() {
    setState(() {
      images.add(null);
      selectedValues.add(null);
    });
  }

  void deleteCard(int index) {
    if (images.length == 1) return;
    setState(() {
      images.removeAt(index);
      selectedValues.removeAt(index);
    });
  }

  Future<void> pickImage(int index) async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        images[index] = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Workmanship Defects")),

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
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),

        /// ✅ GRID
        child: GridView.builder(
          itemCount: images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 👈 عدد الأعمدة
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.1, // شكل الكارت
          ),
          itemBuilder: (context, index) {
            return ImageDropdownCard(
              image: images[index],
              items: dropdownItems,
              selectedValue: selectedValues[index],

              onPickImage: () => pickImage(index),

              onChanged: (val) {
                setState(() {
                  selectedValues[index] = val;
                });
              },

              onAdd: addCard,
              onDelete: () => deleteCard(index),
            );
          },
        ),
      ),
    );
  }
}
