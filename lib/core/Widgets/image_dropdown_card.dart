import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageDropdownCard extends StatelessWidget {
  final XFile? image;
  final String? selectedValue;
  final List<String> items;

  final VoidCallback onAdd;
  final VoidCallback onDelete;
  final VoidCallback onPickImage;
  final ValueChanged<String?> onChanged;

  const ImageDropdownCard({
    super.key,
    required this.image,
    required this.items,
    required this.onAdd,
    required this.onDelete,
    required this.onPickImage,
    required this.onChanged,
    this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          /// DROPDOWN
          SizedBox(
            width: double.infinity,
            child: DropdownButtonFormField<String>(
              value: selectedValue,
              hint: const Text("Select type"),
              items: items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: onChanged,
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
              ),
            ),
          ),

          const SizedBox(height: 8),

          /// IMAGE
          Expanded(
            child: InkWell(
              onTap: onPickImage,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: image == null
                    ? const Icon(
                        Icons.add_a_photo,
                        size: 40,
                        color: Colors.grey,
                      )
                    : Image.file(File(image!.path), fit: BoxFit.cover),
              ),
            ),
          ),

          const SizedBox(height: 8),

          /// BUTTONS
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onAdd,
                  child: const Icon(Icons.add),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: onDelete,
                  child: const Icon(Icons.delete),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
