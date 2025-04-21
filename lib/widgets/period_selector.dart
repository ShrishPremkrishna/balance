import 'package:flutter/material.dart';
import '../models/stats_data.dart';
import '../theme/app_theme.dart';

class PeriodSelector extends StatelessWidget {
  final StatsTimeframe timeframe;
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const PeriodSelector({
    super.key,
    required this.timeframe,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getTitle(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
                color: AppTheme.textLight,
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: _buildPeriodList(context),
          ),
        ],
      ),
    );
  }

  String _getTitle() {
    switch (timeframe) {
      case StatsTimeframe.day:
        return 'Select Day';
      case StatsTimeframe.week:
        return 'Select Week';
      case StatsTimeframe.month:
        return 'Select Month';
    }
  }

  Widget _buildPeriodList(BuildContext context) {
    final periods = _generatePeriods();
    return ListView.builder(
      itemCount: periods.length,
      itemBuilder: (context, index) {
        final period = periods[index];
        final isSelected = _isPeriodSelected(period);

        return ListTile(
          title: Text(
            _formatPeriod(period),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isSelected ? AppTheme.primaryGreen : AppTheme.textLight,
                ),
          ),
          trailing: isSelected
              ? const Icon(
                  Icons.check,
                  color: AppTheme.primaryGreen,
                )
              : null,
          onTap: () {
            onDateSelected(period);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  List<DateTime> _generatePeriods() {
    final now = DateTime.now();
    switch (timeframe) {
      case StatsTimeframe.day:
        // Generate last 30 days
        return List.generate(
          30,
          (index) => DateTime(
            now.year,
            now.month,
            now.day - index,
          ),
        );

      case StatsTimeframe.week:
        // Generate last 12 weeks
        return List.generate(
          12,
          (index) => DateTime(
            now.year,
            now.month,
            now.day - (index * 7),
          ),
        );

      case StatsTimeframe.month:
        // Generate last 12 months
        return List.generate(
          12,
          (index) => DateTime(
            now.year,
            now.month - index,
            1,
          ),
        );
    }
  }

  bool _isPeriodSelected(DateTime period) {
    switch (timeframe) {
      case StatsTimeframe.day:
        return period.year == selectedDate.year &&
            period.month == selectedDate.month &&
            period.day == selectedDate.day;

      case StatsTimeframe.week:
        final selectedWeekStart = selectedDate.subtract(
          Duration(days: selectedDate.weekday - 1),
        );
        final periodWeekStart = period.subtract(
          Duration(days: period.weekday - 1),
        );
        return periodWeekStart.isAtSameMomentAs(selectedWeekStart);

      case StatsTimeframe.month:
        return period.year == selectedDate.year &&
            period.month == selectedDate.month;
    }
  }

  String _formatPeriod(DateTime period) {
    switch (timeframe) {
      case StatsTimeframe.day:
        return _isToday(period)
            ? 'Today'
            : _isYesterday(period)
                ? 'Yesterday'
                : '${period.month}/${period.day}/${period.year}';

      case StatsTimeframe.week:
        final weekEnd = period.add(const Duration(days: 6));
        if (_isCurrentWeek(period)) {
          return 'This Week';
        } else if (_isLastWeek(period)) {
          return 'Last Week';
        }
        return '${period.month}/${period.day} - ${weekEnd.month}/${weekEnd.day}';

      case StatsTimeframe.month:
        if (period.year == DateTime.now().year) {
          return _getMonthName(period.month);
        }
        return '${_getMonthName(period.month)} ${period.year}';
    }
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  bool _isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  bool _isCurrentWeek(DateTime date) {
    final now = DateTime.now();
    final currentWeekStart = now.subtract(Duration(days: now.weekday - 1));
    final dateWeekStart = date.subtract(Duration(days: date.weekday - 1));
    return currentWeekStart.isAtSameMomentAs(dateWeekStart);
  }

  bool _isLastWeek(DateTime date) {
    final now = DateTime.now();
    final lastWeekStart = now
        .subtract(Duration(days: now.weekday - 1))
        .subtract(const Duration(days: 7));
    final dateWeekStart = date.subtract(Duration(days: date.weekday - 1));
    return lastWeekStart.isAtSameMomentAs(dateWeekStart);
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }
} 