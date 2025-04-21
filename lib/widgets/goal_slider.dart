import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GoalSlider extends StatelessWidget {
  final String title;
  final String value;
  final double sliderValue;
  final double minValue;
  final double maxValue;
  final String minLabel;
  final String maxLabel;
  final Function(double) onChanged;
  final double stepSize;

  const GoalSlider({
    super.key,
    required this.title,
    required this.value,
    required this.sliderValue,
    required this.minValue,
    required this.maxValue,
    required this.minLabel,
    required this.maxLabel,
    required this.onChanged,
    this.stepSize = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppTheme.textLight,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppTheme.primaryGreen,
              inactiveTrackColor: AppTheme.primaryGreen.withOpacity(0.2),
              thumbColor: AppTheme.primaryGreen,
              overlayColor: AppTheme.primaryGreen.withOpacity(0.2),
              trackHeight: 4.0,
              thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 12.0,
                elevation: 4.0,
              ),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 24.0),
            ),
            child: Slider(
              value: sliderValue,
              min: minValue,
              max: maxValue,
              divisions: ((maxValue - minValue) / stepSize).round(),
              onChanged: onChanged,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  minLabel,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textLight.withOpacity(0.7),
                      ),
                ),
                Text(
                  maxLabel,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textLight.withOpacity(0.7),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 