import 'package:flutter/material.dart';
import '../../models/stats.dart';
import 'pie_chart.dart';

class ScreenTimeView extends StatelessWidget {
  final ScreenTimeStats stats;
  final String timeRange;

  const ScreenTimeView({
    super.key,
    required this.stats,
    required this.timeRange,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Today's usage
          Text(
            'Today',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            _formatDuration(stats.totalTime),
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Text(
            '${_formatDuration(stats.totalTime)} / ${_formatDuration(stats.goal)}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 24),

          // Category usage pie chart
          Text(
            'Usage by Category',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: PieChart(
              data: stats.categoryUsage.entries
                  .map((e) => PieChartData(
                        label: e.key,
                        value: e.value.inMinutes.toDouble(),
                        color: _getCategoryColor(e.key, context),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 24),

          // Top apps list
          Text(
            'Most Used Apps',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          ...stats.appUsage.entries
              .map((e) => ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      // TODO: Replace with actual app icon
                      child: const Icon(Icons.apps),
                    ),
                    title: Text(e.key),
                    trailing: Text(_formatDuration(e.value)),
                  ))
              .toList(),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }

  Color _getCategoryColor(String category, BuildContext context) {
    final colors = [
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.secondary,
      Theme.of(context).colorScheme.tertiary,
    ];

    switch (category.toLowerCase()) {
      case 'social':
        return colors[0];
      case 'entertainment':
        return colors[1];
      default:
        return colors[2];
    }
  }
} 