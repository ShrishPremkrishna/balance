import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TrendInsight extends StatelessWidget {
  final String insightText;
  final VoidCallback onTap;

  const TrendInsight({
    super.key,
    required this.insightText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Top Trend',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                insightText,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textLight,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 