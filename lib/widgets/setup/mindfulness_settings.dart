import 'package:flutter/material.dart';

class MindfulnessSettings extends StatefulWidget {
  const MindfulnessSettings({super.key});

  @override
  State<MindfulnessSettings> createState() => _MindfulnessSettingsState();
}

class _MindfulnessSettingsState extends State<MindfulnessSettings> {
  bool _openAppTrigger = true;
  bool _idleTrigger = true;
  final Map<String, bool> _interventions = {
    'Breathing Exercises': true,
    'Stretching': true,
    'Inspirational Quotes': true,
    'Todo Reminders': false,
    'Math Problems': false,
    'Step Counter': true,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Triggers
        const Text(
          'Triggers',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        SwitchListTile(
          title: const Text('On App Open'),
          value: _openAppTrigger,
          onChanged: (value) {
            setState(() {
              _openAppTrigger = value;
            });
          },
        ),
        SwitchListTile(
          title: const Text('When Idle'),
          value: _idleTrigger,
          onChanged: (value) {
            setState(() {
              _idleTrigger = value;
            });
          },
        ),
        const SizedBox(height: 16),

        // Intervention Types
        const Text(
          'Intervention Types',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ..._interventions.entries.map((entry) => CheckboxListTile(
          title: Text(entry.key),
          value: entry.value,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _interventions[entry.key] = value;
              });
            }
          },
        )),
      ],
    );
  }
} 