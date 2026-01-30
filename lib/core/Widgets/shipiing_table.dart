// widgets/shipping_table.dart

import 'package:flutter/material.dart';

import '../../ui/model/shipping_model.dart';

class ShippingTable extends StatefulWidget {
  final String tableTitle;
  final List<ShippingRow> rows;
  final Function(List<ShippingRow>) onRowsChanged;

  const ShippingTable({
    Key? key,
    required this.tableTitle,
    required this.rows,
    required this.onRowsChanged,
  }) : super(key: key);

  @override
  _ShippingTableState createState() => _ShippingTableState();
}

class _ShippingTableState extends State<ShippingTable> {
  List<ShippingRow> get rows => widget.rows;

  void updateRow(int index, ShippingRow newRow) {
    setState(() {
      rows[index] = newRow;
      widget.onRowsChanged(rows);
    });
  }

  void addRow() {
    setState(() {
      rows.add(ShippingRow(date: '', po: '', units: ''));
      widget.onRowsChanged(rows);
    });
  }

  void removeRow(int index) {
    setState(() {
      if (rows.length > 1) {
        rows.removeAt(index);
        widget.onRowsChanged(rows);
      }
    });
  }

  int get totalUnits {
    int total = 0;
    for (var row in rows) {
      total += int.tryParse(row.units) ?? 0;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.tableTitle,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Date",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "P.O",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Units",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                ),
                SizedBox(width: 60),
              ],
            ),
          ),

          const SizedBox(height: 8),

          Column(
            children: List.generate(rows.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(12),
                        ),
                        initialValue: rows[index].date,
                        onChanged: (value) {
                          updateRow(
                            index,
                            ShippingRow(
                              date: value,
                              po: rows[index].po,
                              units: rows[index].units,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 8),

                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(12),
                        ),
                        initialValue: rows[index].po,
                        onChanged: (value) {
                          updateRow(
                            index,
                            ShippingRow(
                              date: rows[index].date,
                              po: value,
                              units: rows[index].units,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 8),

                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(12),
                        ),
                        initialValue: rows[index].units,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          updateRow(
                            index,
                            ShippingRow(
                              date: rows[index].date,
                              po: rows[index].po,
                              units: value,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 8),

                    SizedBox(
                      width: 50,
                      child: IconButton(
                        onPressed: () => removeRow(index),
                        icon: const Icon(Icons.delete, color: Colors.red),
                        tooltip: 'Delete row',
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),

          const SizedBox(height: 16),

          ElevatedButton.icon(
            onPressed: addRow,
            icon: const Icon(Icons.add),
            label: const Text('Add Row'),
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Units:",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  totalUnits.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
