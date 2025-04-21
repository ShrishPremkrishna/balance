import 'package:flutter/material.dart';
import '../models/stats_data.dart';
import '../theme/app_theme.dart';

class StatsTypeToggle extends StatelessWidget {
  final StatsType selectedType;
  final Function(StatsType) onTypeChanged;

  const StatsTypeToggle({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildToggleButton(
            context: context,
            title: 'Steps',
            isSelected: selectedType == StatsType.steps,
            onTap: () => onTypeChanged(StatsType.steps),
          ),
          const SizedBox(width: 8),
          _buildToggleButton(
            context: context,
            title: 'Screen Time',
            isSelected: selectedType == StatsType.screenTime,
            onTap: () => onTypeChanged(StatsType.screenTime),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required BuildContext context,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primaryGreen : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? AppTheme.primaryGreen : AppTheme.textGrey,
            ),
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isSelected ? Colors.white : AppTheme.textGrey,
                ),
          ),
        ),
      ),
    );
  }
}

class TimeframeToggle extends StatelessWidget {
  final StatsTimeframe selectedTimeframe;
  final Function(StatsTimeframe) onTimeframeChanged;

  const TimeframeToggle({
    super.key,
    required this.selectedTimeframe,
    required this.onTimeframeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildToggleButton(
            context: context,
            title: 'Day',
            isSelected: selectedTimeframe == StatsTimeframe.day,
            onTap: () => onTimeframeChanged(StatsTimeframe.day),
          ),
          const SizedBox(width: 8),
          _buildToggleButton(
            context: context,
            title: 'Week',
            isSelected: selectedTimeframe == StatsTimeframe.week,
            onTap: () => onTimeframeChanged(StatsTimeframe.week),
          ),
          const SizedBox(width: 8),
          _buildToggleButton(
            context: context,
            title: 'Month',
            isSelected: selectedTimeframe == StatsTimeframe.month,
            onTap: () => onTimeframeChanged(StatsTimeframe.month),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required BuildContext context,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primaryGreen : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? AppTheme.primaryGreen : AppTheme.textGrey,
            ),
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isSelected ? Colors.white : AppTheme.textGrey,
                ),
          ),
        ),
      ),
    );
  }
}

class StatsToggleButtons extends StatelessWidget {
  final bool showSteps;
  final String timeframe;
  final Function(bool) onToggleDataType;
  final Function(String) onTimeframeChanged;

  const StatsToggleButtons({
    Key? key,
    required this.showSteps,
    required this.timeframe,
    required this.onToggleDataType,
    required this.onTimeframeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Data type toggle
        SegmentedButton<bool>(
          segments: const [
            ButtonSegment<bool>(
              value: true,
              label: Text('Steps'),
              icon: Icon(Icons.directions_walk),
            ),
            ButtonSegment<bool>(
              value: false,
              label: Text('Screen Time'),
              icon: Icon(Icons.phone_android),
            ),
          ],
          selected: {showSteps},
          onSelectionChanged: (Set<bool> newSelection) {
            onToggleDataType(newSelection.first);
          },
        ),
        const SizedBox(height: 8),
        // Timeframe toggle
        SegmentedButton<String>(
          segments: const [
            ButtonSegment<String>(
              value: 'day',
              label: Text('Day'),
            ),
            ButtonSegment<String>(
              value: 'week',
              label: Text('Week'),
            ),
            ButtonSegment<String>(
              value: 'month',
              label: Text('Month'),
            ),
          ],
          selected: {timeframe},
          onSelectionChanged: (Set<String> newSelection) {
            onTimeframeChanged(newSelection.first);
          },
        ),
      ],
    );
  }
} 