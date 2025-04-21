import 'package:flutter/material.dart';
import '../models/stats_data.dart';

class StatsSummaryCard extends StatelessWidget {
  final StatsData data;
  final String timeframe;
  final String selectedPeriod;
  final VoidCallback onPeriodTap;

  const StatsSummaryCard({
    Key? key,
    required this.data,
    required this.timeframe,
    required this.selectedPeriod,
    required this.onPeriodTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: onPeriodTap,
              child: Row(
                children: [
                  Text(
                    selectedPeriod,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryItem(
                  context,
                  'Total',
                  data.totalValue.toStringAsFixed(0),
                ),
                _buildSummaryItem(
                  context,
                  'Average',
                  data.averageValue.toStringAsFixed(0),
                ),
                _buildSummaryItem(
                  context,
                  'Change',
                  '${data.changePercentage >= 0 ? '+' : ''}${data.changePercentage.toStringAsFixed(1)}%',
                  color: data.changePercentage >= 0 ? Colors.green : Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
    BuildContext context,
    String label,
    String value, {
    Color? color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
} 