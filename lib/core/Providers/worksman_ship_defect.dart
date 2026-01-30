import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class WorksmanShipDefect extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();

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
    images.add(null);
    selectedValues.add(null);
    notifyListeners();
  }

  void deleteCard(int index) {
    if (images.length == 1) return;
    images.removeAt(index);
    selectedValues.removeAt(index);
    notifyListeners();
  }

  Future<void> pickImage(int index) async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      images[index] = picked;
      notifyListeners();
    }
  }

  void setDropdownValue(int index, String? value) {
    selectedValues[index] = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> exportData() {
    return List.generate(images.length, (i) {
      return {"type": selectedValues[i], "image": images[i]};
    });
  }
}
