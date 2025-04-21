import 'package:flutter/material.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  int _frequency = 5;
  TimeOfDay _quietHoursStart = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay _quietHoursEnd = const TimeOfDay(hour: 7, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Frequency Slider
        const Text(
          'Notification Frequency',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text('$_frequency notifications per day'),
        Slider(
          value: _frequency.toDouble(),
          min: 1,
          max: 12,
          divisions: 11,
          label: '$_frequency per day',
          onChanged: (value) {
            setState(() {
              _frequency = value.round();
            });
          },
        ),
        const SizedBox(height: 24),

        // Quiet Hours
        const Text(
          'Quiet Hours',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ListTile(
          title: const Text('Start Time'),
          trailing: TextButton(
            onPressed: () async {
              final TimeOfDay? time = await showTimePicker(
                context: context,
                initialTime: _quietHoursStart,
              );
              if (time != null) {
                setState(() {
                  _quietHoursStart = time;
                });
              }
            },
            child: Text(
              _quietHoursStart.format(context),
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        ListTile(
          title: const Text('End Time'),
          trailing: TextButton(
            onPressed: () async {
              final TimeOfDay? time = await showTimePicker(
                context: context,
                initialTime: _quietHoursEnd,
              );
              if (time != null) {
                setState(() {
                  _quietHoursEnd = time;
                });
              }
            },
            child: Text(
              _quietHoursEnd.format(context),
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
} 