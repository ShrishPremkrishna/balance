import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ComparisonMetricCard extends StatelessWidget {
  final String title;
  final String yourValue;
  final String friendValue;
  final double yourProgress;
  final double friendProgress;
  final Color yourColor;
  final Color friendColor;

  const ComparisonMetricCard({
    super.key,
    required this.title,
    required this.yourValue,
    required this.friendValue,
    required this.yourProgress,
    required this.friendProgress,
    this.yourColor = AppTheme.primaryBlue,
    this.friendColor = AppTheme.primaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textLight.withOpacity(0.7),
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      yourValue,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Kenny',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textLight.withOpacity(0.7),
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      friendValue,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Stack(
            children: [
              Container(
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.cardBackground.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: (yourProgress * 100).toInt(),
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: yourColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: (friendProgress * 100).toInt(),
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: friendColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
} 