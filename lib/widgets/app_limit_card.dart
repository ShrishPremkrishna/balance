import 'package:flutter/material.dart';
import '../models/app_limit.dart';
import '../theme/app_theme.dart';

class AppLimitCard extends StatelessWidget {
  final AppLimit limit;
  final Function(bool) onToggle;
  final VoidCallback onTap;

  const AppLimitCard({
    super.key,
    required this.limit,
    required this.onToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.apps,
                  color: AppTheme.primaryGreen,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      limit.appName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDuration(limit.timeLimit),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textLight.withOpacity(0.7),
                          ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: limit.isEnabled,
                onChanged: onToggle,
                activeColor: AppTheme.primaryGreen,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    if (hours > 0) {
      return '$hours hour${hours == 1 ? '' : 's'} ${minutes > 0 ? '$minutes minute${minutes == 1 ? '' : 's'}' : ''}';
    } else {
      return '$minutes minute${minutes == 1 ? '' : 's'}';
    }
  }
} 