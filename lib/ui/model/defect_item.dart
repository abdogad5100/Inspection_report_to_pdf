import 'dart:io';

class DefectItem {
  String item;
  String category;
  String code;
  String description;
  File? image;

  DefectItem({
    required this.item,
    required this.category,
    required this.code,
    required this.description,
    this.image,
  });
}
