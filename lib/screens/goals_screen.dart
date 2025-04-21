import 'package:flutter/material.dart';
import '../models/app_limit.dart';
import '../theme/app_theme.dart';
import '../widgets/goal_slider.dart';
import '../widgets/app_limit_card.dart';
import '../widgets/time_limit_editor.dart';
import '../widgets/app_picker.dart';
import 'app_limit_editor_screen.dart';
import '../main.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  // Step goal state
  double _stepGoal = 10000;
  static const double _minSteps = 5000;
  static const double _maxSteps = 30000;
  static const double _stepIncrement = 500;

  // Screen time goal state
  double _screenTimeMinutes = 90; // 1h 30m
  static const double _minScreenTime = 30; // 30m
  static const double _maxScreenTime = 240; // 4h
  static const double _screenTimeIncrement = 10;

  // TODO: Replace with actual data from a provider
  final List<AppLimit> _appLimits = [
    AppLimit(
      appName: 'Instagram',
      appIconPath: 'assets/images/app_icons/instagram.png',
      timeLimit: const Duration(minutes: 20),
    ),
    AppLimit(
      appName: 'TikTok',
      appIconPath: 'assets/images/app_icons/tiktok.png',
      timeLimit: const Duration(hours: 1, minutes: 5),
    ),
    AppLimit(
      appName: 'YouTube',
      appIconPath: 'assets/images/app_icons/youtube.png',
      timeLimit: const Duration(minutes: 5),
    ),
  ];

  void _showTimeLimitEditor(AppLimit limit) {
    showDialog(
      context: context,
      builder: (context) => TimeLimitEditor(
        appLimit: limit,
        onSave: (newDuration) {
          setState(() {
            final index = _appLimits.indexOf(limit);
            _appLimits[index] = limit.copyWith(timeLimit: newDuration);
          });
        },
      ),
    );
  }

  void _showAppPicker() {
    showDialog(
      context: context,
      builder: (context) => AppPicker(
        currentLimits: _appLimits,
        onAppSelected: (newLimit) {
          setState(() {
            _appLimits.add(newLimit);
          });
          _navigateToAppLimitEditor(newLimit);
        },
      ),
    );
  }

  void _navigateToAppLimitEditor(AppLimit limit) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AppLimitEditorScreen(
          appLimit: limit,
          onSave: (updatedLimit) {
            setState(() {
              final index = _appLimits.indexWhere(
                  (l) => l.appName == updatedLimit.appName);
              if (index >= 0) {
                _appLimits[index] = updatedLimit;
              }
            });
            Navigator.of(context).pop();
          },
          onNavigationChanged: (index) {
            Navigator.of(context).pop();
            // Update the main navigator's state
            MainNavigator.of(context)?.updateIndex(index);
          },
        ),
      ),
    );
  }

  String _formatStepGoal(double steps) {
    return steps.toInt().toString();
  }

  String _formatScreenTime(double minutes) {
    final hours = (minutes / 60).floor();
    final remainingMinutes = (minutes % 60).toInt();
    if (hours > 0) {
      return '${hours}h ${remainingMinutes}m';
    } else {
      return '${remainingMinutes}m';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Balance'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // TODO: Implement menu
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              // TODO: Implement add friend
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GoalSlider(
              title: 'Daily Step Goal',
              value: _formatStepGoal(_stepGoal),
              sliderValue: _stepGoal,
              minValue: _minSteps,
              maxValue: _maxSteps,
              minLabel: _formatStepGoal(_minSteps),
              maxLabel: _formatStepGoal(_maxSteps),
              stepSize: _stepIncrement,
              onChanged: (value) {
                setState(() {
                  _stepGoal = value;
                });
              },
            ),
            GoalSlider(
              title: 'Daily Screen Time Goal',
              value: _formatScreenTime(_screenTimeMinutes),
              sliderValue: _screenTimeMinutes,
              minValue: _minScreenTime,
              maxValue: _maxScreenTime,
              minLabel: _formatScreenTime(_minScreenTime),
              maxLabel: _formatScreenTime(_maxScreenTime),
              stepSize: _screenTimeIncrement,
              onChanged: (value) {
                setState(() {
                  _screenTimeMinutes = value;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'App-Specific Limits',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ..._appLimits.map((limit) => AppLimitCard(
                  limit: limit,
                  onToggle: (enabled) {
                    setState(() {
                      final index = _appLimits.indexOf(limit);
                      _appLimits[index] = limit.copyWith(isEnabled: enabled);
                    });
                  },
                  onTap: () => _navigateToAppLimitEditor(limit),
                )),
            Padding(
              padding: const EdgeInsets.all(16),
              child: OutlinedButton.icon(
                onPressed: _showAppPicker,
                icon: const Icon(Icons.add),
                label: const Text('Add App'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.primaryGreen,
                  side: const BorderSide(color: AppTheme.primaryGreen),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 