import 'package:flutter/material.dart';

class ReportOverallResult extends ChangeNotifier {
  // WORKMANSHIP
  final samplePull = TextEditingController();
  final major = TextEditingController();
  final passOn = TextEditingController();

  final minor = TextEditingController();
  final RejectOn = TextEditingController();
  final critical = TextEditingController();
  final totalDefective = TextEditingController();

  // MEASUREMENT
  final measurementSamplePull = TextEditingController();
  final acceptOn = TextEditingController();
  final rejectOn = TextEditingController();
  final totalMajor = TextEditingController();

  // COMMENTS
  final workmanshipComments = TextEditingController();
  final packingComments = TextEditingController();

  // PACKING Yes/No/NA
  final Map<String, String> packingResults = {};

  void setPackingResult(String key, String value) {
    packingResults[key] = value;
    notifyListeners();
  }

  Map<String, bool?> overallResults = {};

  String getPackingResult(String key) {
    return packingResults[key] ?? 'NA';
  }

  void setResult(String key, bool value) {
    overallResults[key] = value;
    notifyListeners();
  }

  bool? getResult(String key) => overallResults[key];

  @override
  void dispose() {
    samplePull.dispose();
    major.dispose();
    passOn.dispose();
    minor.dispose();
    RejectOn.dispose();
    critical.dispose();
    totalDefective.dispose();
    measurementSamplePull.dispose();
    acceptOn.dispose();
    rejectOn.dispose();
    totalMajor.dispose();
    workmanshipComments.dispose();
    packingComments.dispose();
  }
}
