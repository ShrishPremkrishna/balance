import 'package:flutter/material.dart';
import '../../models/stats.dart';
import 'bar_chart.dart';

class StepsView extends StatelessWidget {
  final StepStats stats;
  final String timeRange;

  const StepsView({
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
          // Today's progress
          Text(
            'Today',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            stats.steps.toString(),
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Text(
            '${stats.steps} / ${stats.goal} steps',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 24),

          // Steps chart
          SizedBox(
            height: 200,
            child: BarChart(
              data: stats.hourlySteps.entries
                  .map((e) => BarChartData(
                        label: e.key,
                        value: e.value.toDouble(),
                        color: Theme.of(context).colorScheme.primary,
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 24),

          // Additional stats
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  title: 'Active Minutes',
                  value: '${stats.activeMinutes.inMinutes}',
                  unit: 'min',
                  icon: Icons.timer,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _StatCard(
                  title: 'Calories',
                  value: stats.calories.toString(),
                  unit: 'cal',
                  icon: Icons.local_fire_department,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              unit,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
} 