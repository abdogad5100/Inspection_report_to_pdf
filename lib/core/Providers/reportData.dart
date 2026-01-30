import 'package:flutter/material.dart';

import '../../ui/model/shipping_model.dart';

class ReportData extends ChangeNotifier {
  // ===== Fields for TextFields =====
  Map<String, TextEditingController> fields = {
    "Customer": TextEditingController(),
    "Prod.Mgr": TextEditingController(),
    "Auditor": TextEditingController(),
    "Insp Date": TextEditingController(),
    "Vendor": TextEditingController(),
    "Factory": TextEditingController(),
    "S/O No": TextEditingController(),
    "Art Descr": TextEditingController(),
    "Style No": TextEditingController(),
    "Sytle Desc": TextEditingController(),
    "Fabrication": TextEditingController(),
    "Color": TextEditingController(),
  };

  // ===== Shipping Table =====
  List<ShippingRow> shippingRows = [ShippingRow(date: '', po: '', units: '')];

  // ===== Production Status =====
  Map<String, TextEditingController> statusRows = {
    "Cut": TextEditingController(),
    "Sewn": TextEditingController(),
    "Pressed": TextEditingController(),
    "Packed": TextEditingController(),
  };

  // ===== Methods =====

  // تحديث TextFields
  void updateField(String key, String value) {
    if (fields.containsKey(key)) {
      fields[key]!.text = value;
      notifyListeners();
    }
  }

  // تحديث ShippingRows
  void updateShippingRows(List<ShippingRow> newRows) {
    shippingRows = newRows;
    notifyListeners();
  }

  // إضافة صف Shipping
  void addShippingRow() {
    shippingRows.add(ShippingRow(date: '', po: '', units: ''));
    notifyListeners();
  }

  // حذف صف Shipping
  void deleteShippingRow(int index) {
    if (index < shippingRows.length) {
      shippingRows.removeAt(index);
      notifyListeners();
    }
  }

  // تحديث Status
  void updateStatus(String key, String value) {
    if (statusRows.containsKey(key)) {
      statusRows[key]!.text = value;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    for (var c in fields.values) {
      c.dispose();
    }
    for (var c in statusRows.values) {
      c.dispose();
    }

    super.dispose();
  }
}
