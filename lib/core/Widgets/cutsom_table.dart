import 'package:flutter/material.dart';

class DynamicTable extends StatefulWidget {
  final List<List<String>> initialData;

  const DynamicTable({super.key, this.initialData = const []});

  @override
  State<DynamicTable> createState() => _DynamicTableState();
}

class _DynamicTableState extends State<DynamicTable> {
  late List<List<TextEditingController>> rows;

  @override
  void initState() {
    super.initState();
    rows = widget.initialData
        .map(
          (row) =>
              row.map((cell) => TextEditingController(text: cell)).toList(),
        )
        .toList();

    if (rows.isEmpty) {
      _addRow();
    }
  }

  void _addRow() {
    setState(() {
      int columnCount = rows.isNotEmpty ? rows[0].length : 2;
      rows.add(List.generate(columnCount, (_) => TextEditingController()));
    });
  }

  void _removeRow(int index) {
    setState(() {
      rows[index].forEach((c) => c.dispose());
      rows.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          icon: const Icon(Icons.add_circle, color: Colors.green),
          onPressed: _addRow,
        ),
        // Scroll عمودي
        SizedBox(
          height: 300, // حدد ارتفاع الجدول
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Table(
                border: TableBorder.all(color: Colors.grey),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: rows.asMap().entries.map((entry) {
                  int rowIndex = entry.key;
                  List<TextEditingController> rowControllers = entry.value;

                  return TableRow(
                    children: [
                      ...rowControllers.map(
                        (ctrl) => Padding(
                          padding: const EdgeInsets.all(6),
                          child: SizedBox(
                            width: 150,
                            child: TextField(
                              controller: ctrl,
                              decoration: const InputDecoration(
                                isDense: true,
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.remove_circle,
                          color: Colors.red,
                        ),
                        onPressed: () => _removeRow(rowIndex),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
