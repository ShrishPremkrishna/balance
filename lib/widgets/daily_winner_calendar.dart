import 'package:flutter/material.dart';
import '../models/friend_models.dart';
import '../theme/app_theme.dart';

class DailyWinnerCalendar extends StatelessWidget {
  final List<DailyWinner> winners;
  final ComparisonMetric selectedMetric;

  const DailyWinnerCalendar({
    super.key,
    required this.winners,
    required this.selectedMetric,
  });

  Color _getWinnerColor(WinnerType winner) {
    switch (winner) {
      case WinnerType.you:
        return AppTheme.primaryBlue;
      case WinnerType.friend:
        return AppTheme.primaryGreen;
      case WinnerType.tie:
        return AppTheme.textLight.withOpacity(0.5);
      case WinnerType.none:
        return AppTheme.cardBackground.withOpacity(0.2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Daily Winner',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: winners.map((winner) {
              final winnerType = selectedMetric == ComparisonMetric.steps
                  ? winner.stepsWinner
                  : winner.screenTimeWinner;
              
              return Column(
                children: [
                  Text(
                    _formatDate(winner.date),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textLight.withOpacity(0.7),
                        ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 24,
                    height: 24,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: _getWinnerColor(winnerType),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month) {
      if (date.day == now.day) return '${date.day}';
      if (date.day == now.day - 1) return '${date.day}';
    }
    
    final weekday = switch (date.weekday) {
      1 => 'Mon',
      2 => 'Tue',
      3 => 'Wed',
      4 => 'Thu',
      5 => 'Fri',
      6 => 'Sat',
      7 => 'Sun',
      _ => '',
    };
    return weekday;
  }
} 