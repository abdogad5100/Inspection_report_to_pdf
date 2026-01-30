import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReportDefectTable extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();

  List<List<TextEditingController>> rows = [
    List.generate(4, (_) => TextEditingController()),
  ];

  List<XFile?> images = [null];

  void addRow() {
    rows.add(List.generate(4, (_) => TextEditingController()));
    images.add(null);
    notifyListeners();
  }

  void deleteRow(int index) {
    for (var c in rows[index]) {
      c.dispose();
    }
    rows.removeAt(index);
    images.removeAt(index);
    notifyListeners();
  }

  Future<void> pickImage(int index) async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      images[index] = picked;
      notifyListeners();
    }
  }

  List<Map<String, dynamic>> exportData() {
    return List.generate(rows.length, (i) {
      return {
        "category": rows[i][0].text,
        "code": rows[i][1].text,
        "description": rows[i][2].text,
        "image": images[i],
      };
    });
  }

  @override
  void dispose() {
    for (var row in rows) {
      for (var c in row) {
        c.dispose();
      }
    }
    super.dispose();
  }
}
