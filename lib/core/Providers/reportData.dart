import 'package:flutter/material.dart';

import '../../ui/model/shipping_model.dart';

class ReportData extends ChangeNotifier {
  // ===== Fields for TextFields =====
  final reportPeriod = TextEditingController();
  final reportCode = TextEditingController();
  final Map<String, TextEditingController> fields = {
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
  List<ShippingRow> shippingRows = [ShippingRow(date: '', po: '', units: 0)];

  // ===== Production Status =====
  final Map<String, TextEditingController> statusRows = {
    "Cut": TextEditingController(),
    "Sewn": TextEditingController(),
    "Pressed": TextEditingController(),
    "Packed": TextEditingController(),
  };

  // ===== Text Fields =====
  void updateField(String key, String value) {
    if (fields.containsKey(key)) {
      fields[key]!.text = value;
      notifyListeners();
    }
  }

  // ===== Shipping Rows =====

  /// تحديث صف واحد
  void updateShippingRow(int index, ShippingRow newRow) {
    if (index < shippingRows.length) {
      shippingRows[index] = newRow;
      notifyListeners();
    }
  }

  /// إضافة صف
  void addShippingRow() {
    shippingRows.add(ShippingRow(po: '', units: 0, date: ''));
    notifyListeners();
  }

  /// حذف صف
  void deleteShippingRow(int index) {
    if (shippingRows.length > 1 && index < shippingRows.length) {
      shippingRows.removeAt(index);
      notifyListeners();
    }
  }

  // ===== Status =====
  void updateStatus(String key, String value) {
    if (statusRows.containsKey(key)) {
      statusRows[key]!.text = value;
      notifyListeners();
    }
  }

  // ===== Calculations =====
  int get totalUnits => shippingRows.fold(0, (sum, row) => sum + row.units);

  // ===== Dispose =====
  @override
  void dispose() {
    reportPeriod.dispose();
    reportCode.dispose();

    for (final c in fields.values) {
      c.dispose();
    }
    for (final c in statusRows.values) {
      c.dispose();
    }
    super.dispose();
  }
}
