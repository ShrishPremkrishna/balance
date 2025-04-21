import 'package:flutter/material.dart';
import '../widgets/setup/goal_slider.dart';
import '../widgets/setup/restricted_app_list.dart';
import '../widgets/setup/mindfulness_settings.dart';
import '../widgets/setup/notification_settings.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  // Initial values
  int _stepGoal = 10000;
  Duration _screenTimeLimit = const Duration(hours: 1, minutes: 30);
  bool _fiveForSixtyEnabled = true;
  int _minutesPerHour = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Your Goals'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Daily Step Goal
            const Text(
              'Daily Step Goal',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GoalSlider(
              value: _stepGoal.toDouble(),
              min: 5000,
              max: 30000,
              onChanged: (value) {
                setState(() {
                  _stepGoal = value.round();
                });
              },
              displayValue: _stepGoal.toString(),
            ),
            const SizedBox(height: 32),

            // Daily Screen Time Goal
            const Text(
              'Daily Screen Time Goal',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GoalSlider(
              value: _screenTimeLimit.inMinutes.toDouble(),
              min: 30,
              max: 240,
              onChanged: (value) {
                setState(() {
                  _screenTimeLimit = Duration(minutes: value.round());
                });
              },
              displayValue: '${_screenTimeLimit.inHours}h ${_screenTimeLimit.inMinutes.remainder(60)}m',
            ),
            const SizedBox(height: 32),

            // 5-for-60 Rule
            const Text(
              'App-Specific Limits',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Enable 5-for-60 Rule'),
              subtitle: const Text('Limit app usage to 5 minutes per hour'),
              value: _fiveForSixtyEnabled,
              onChanged: (value) {
                setState(() {
                  _fiveForSixtyEnabled = value;
                });
              },
            ),
            if (_fiveForSixtyEnabled) ...[
              Slider(
                value: _minutesPerHour.toDouble(),
                min: 1,
                max: 30,
                divisions: 29,
                label: '$_minutesPerHour minutes',
                onChanged: (value) {
                  setState(() {
                    _minutesPerHour = value.round();
                  });
                },
              ),
            ],
            const SizedBox(height: 16),
            const RestrictedAppList(),
            const SizedBox(height: 32),

            // Mindfulness Settings
            const Text(
              'Mindfulness Moments',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const MindfulnessSettings(),
            const SizedBox(height: 32),

            // Notification Settings
            const Text(
              'Notifications',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const NotificationSettings(),
          ],
        ),
      ),
    );
  }
} 