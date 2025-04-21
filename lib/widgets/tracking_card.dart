import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../theme/app_theme.dart';

class TrackingCard extends StatelessWidget {
  final String title;
  final String value;
  final int streak;
  final double progress;
  final VoidCallback onTap;
  final Color progressColor;

  const TrackingCard({
    super.key,
    required this.title,
    required this.value,
    required this.streak,
    required this.progress,
    required this.onTap,
    this.progressColor = AppTheme.primaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Streak: $streak Days',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              CircularPercentIndicator(
                radius: 30,
                lineWidth: 5,
                percent: progress.clamp(0.0, 1.0),
                progressColor: progressColor,
                backgroundColor: progressColor.withOpacity(0.2),
                circularStrokeCap: CircularStrokeCap.round,
                center: progress >= 1.0
                    ? const Icon(
                        Icons.check,
                        color: AppTheme.primaryGreen,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 