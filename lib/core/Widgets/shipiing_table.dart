// widgets/shipping_table.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/reportData.dart';

class ShippingTable extends StatelessWidget {
  final String tableTitle;

  const ShippingTable({Key? key, required this.tableTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reportData = context.watch<ReportData>();
    final rows = reportData.shippingRows;

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
            tableTitle,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          /// ===== HEADER =====
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
                      "P.O",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Units",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Date",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 60),
              ],
            ),
          ),

          const SizedBox(height: 8),

          /// ===== ROWS =====
          Column(
            children: List.generate(rows.length, (index) {
              final row = rows[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [


                    Expanded(
                      child: TextFormField(
                        initialValue: row.po,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(12),
                        ),
                        onChanged: (value) {
                          reportData.updateShippingRow(
                            index,
                            row.copyWith(po: value),
                          );
                        },
                      ),
                    ),

                    const SizedBox(width: 8),


                    Expanded(
                      child: TextFormField(
                        initialValue: row.units.toString(),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(12),
                        ),
                        onChanged: (value) {
                          reportData.updateShippingRow(
                            index,
                            row.copyWith(
                              units: int.tryParse(value) ?? 0,
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        initialValue: row.date,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(12),
                        ),
                        onChanged: (value) {
                          reportData.updateShippingRow(
                            index,
                            row.copyWith(date: value),
                          );
                        },
                      ),
                    ),

                    SizedBox(
                      width: 50,
                      child: IconButton(
                        onPressed: () => reportData.deleteShippingRow(index),
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),

          const SizedBox(height: 16),

          /// ===== ADD ROW =====
          ElevatedButton.icon(
            onPressed: reportData.addShippingRow,
            icon: const Icon(Icons.add),
            label: const Text('Add Row'),
          ),

          const SizedBox(height: 16),

          /// ===== TOTAL =====
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
                  reportData.totalUnits.toString(),
                  style: const TextStyle(
                    fontSize: 20,
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
