import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NumberSelector extends StatelessWidget {
  final String label;
  final int value;
  final int minValue;
  final int maxValue;
  final Function(int) onChanged;
  final String? suffix;

  const NumberSelector({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.minValue = 0,
    this.maxValue = 999,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Label
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          // Minus button
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: value > minValue ? () => onChanged(value - 1) : null,
            iconSize: 20,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
          ),
          // Value
          SizedBox(
            width: 32,
            child: Text(
              value.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          // Plus button
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: value < maxValue ? () => onChanged(value + 1) : null,
            iconSize: 20,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
          ),
          // Suffix
          if (suffix != null)
            Expanded(
              child: Text(
                suffix!,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
        ],
      ),
    );
  }
} 