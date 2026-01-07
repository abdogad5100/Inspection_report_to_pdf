import 'package:flutter/material.dart';

Widget cellText(String text) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
    ),
  );
}

Widget cellInput(TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: TextField(
      controller: controller,
      style: TextStyle(fontWeight: FontWeight.bold),
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        isDense: true,
      ),
    ),
  );
}
