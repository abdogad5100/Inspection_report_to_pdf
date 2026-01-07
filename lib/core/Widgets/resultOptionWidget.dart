import 'package:flutter/material.dart';

class ResultOptionWidget extends StatefulWidget {
  final String label; // النص اللي هيظهر
  const ResultOptionWidget({super.key, required this.label});

  @override
  State<ResultOptionWidget> createState() => _ResultOptionWidgetState();
}

class _ResultOptionWidgetState extends State<ResultOptionWidget> {
  bool? selectedValue; // true = PASS, false = FAIL

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          Row(
            children: [
              Radio<bool>(
                value: true,
                groupValue: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
              ),
              const Text(
                "PASS",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),

          Row(
            children: [
              Radio<bool>(
                value: false,
                groupValue: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
              ),
              const Text(
                "FAIL",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
