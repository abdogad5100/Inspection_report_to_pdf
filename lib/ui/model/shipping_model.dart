
class ShippingRow {
  String po;
  int units;
  String date;

  ShippingRow({required this.po, required this.units, required this.date});

  ShippingRow copyWith({String? po, int? units, String? date}) {
    return ShippingRow(
      po: po ?? this.po,
      units: units ?? this.units,
      date: date ?? this.date,
    );
  }
}