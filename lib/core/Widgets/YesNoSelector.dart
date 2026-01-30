import 'package:flutter/material.dart';

class YesNoNaSelector extends StatelessWidget {
  final String label;
  final String? value;
  final Function(String value) onChanged;

  const YesNoNaSelector({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 440,
          child: Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final choice in ['Yes', 'No', 'NA']) ...[
              Radio<String>(
                value: choice,
                groupValue: value,
                onChanged: (val) => onChanged(val!),
              ),
              Text(choice),
              const SizedBox(width: 8), // مسافة بسيطة بينهم
            ],
          ],
        ),
      ],
    );
  }
}
