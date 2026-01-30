import 'package:flutter/material.dart';

class BuildField extends StatelessWidget {
  final String label;
  final TextEditingController? controller; // 👈 أضفنا controller

  const BuildField({super.key, required this.label, this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        width: double.infinity, // ⭐ ده المهم
        child: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.black, fontSize: 16),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey, width: 2),
            ),
          ),
        ),
      ),
    );
  }
}
