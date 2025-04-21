import 'package:flutter/material.dart';

class BarChartData {
  final String label;
  final double value;
  final Color color;

  const BarChartData({
    required this.label,
    required this.value,
    required this.color,
  });
}

class BarChart extends StatelessWidget {
  final List<BarChartData> data;

  const BarChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final maxValue = data.map((e) => e.value).reduce((a, b) => a > b ? a : b);

    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: data.map((item) {
              final height = item.value / maxValue;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 160 * height,
                        decoration: BoxDecoration(
                          color: item.color,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: data.map((item) {
            return Expanded(
              child: Text(
                item.label,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
} 