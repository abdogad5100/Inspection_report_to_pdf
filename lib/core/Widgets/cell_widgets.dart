import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// ===== HEADER CELL =====
Widget cellText(String text) {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.all(8),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16, // 👈 صغرناها عشان الجدول
      ),
    ),
  );
}

/// ===== FIXED INPUT CELL (Category / Code) =====
Widget cellInput(
  TextEditingController controller, {
  InputBorder? border,
  double? height,
  double fontSize = 24,
}) {
  return SizedBox(
    height: height ?? 48, // ارتفاع افتراضي 48 لو المستخدم ما حددش
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: fontSize),
        decoration: InputDecoration(
          border:
              border ??
              const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ), // 👈 افتراضي: حدود رمادية
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 12,
          ),
        ),
      ),
    ),
  );
}

/// ===== MULTILINE INPUT (Description) =====
Widget cellMultilineInput(TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: TextField(
      controller: controller,
      minLines: 1,
      maxLines: null,
      // 👈 يفتح على قد الكلام
      keyboardType: TextInputType.multiline,
      style: const TextStyle(fontSize: 24),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 10),

      ),
    ),
  );
}

/// ===== IMAGE CELL =====

/// ===== IMAGE CELL =====
Widget cellImage({
  required XFile? image,
  required VoidCallback onPick,

}) {
  return Padding(
    padding: const EdgeInsets.all(4),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        /// 👆 الصورة أو أيقونة اختيار صورة
        InkWell(
          onTap: onPick, // ✅ هنا لما تضغط هينادي callback لاختيار الصورة
          child: Container(
            height: 200, // ارتفاع مناسب داخل الجدول
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(6),
            ),
            child: image == null
                ? const Icon(Icons.add_a_photo, color: Colors.grey, size: 40)
                : ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.file(File(image.path), fit: BoxFit.cover),
            ),
          ),
        ),


      ],
    ),
  );
}
