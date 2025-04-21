import 'package:flutter/material.dart';
import '../models/app_limit.dart';
import '../theme/app_theme.dart';

class TimeLimitEditor extends StatefulWidget {
  final AppLimit appLimit;
  final Function(Duration) onSave;

  const TimeLimitEditor({
    super.key,
    required this.appLimit,
    required this.onSave,
  });

  @override
  State<TimeLimitEditor> createState() => _TimeLimitEditorState();
}

class _TimeLimitEditorState extends State<TimeLimitEditor> {
  late int _hours;
  late int _minutes;

  @override
  void initState() {
    super.initState();
    _hours = widget.appLimit.timeLimit.inHours;
    _minutes = widget.appLimit.timeLimit.inMinutes.remainder(60);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Set Time Limit',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              widget.appLimit.appName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.textLight.withOpacity(0.7),
                  ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _TimePickerField(
                  value: _hours,
                  maxValue: 12,
                  label: 'hours',
                  onChanged: (value) {
                    setState(() {
                      _hours = value;
                    });
                  },
                ),
                const SizedBox(width: 16),
                _TimePickerField(
                  value: _minutes,
                  maxValue: 59,
                  label: 'minutes',
                  onChanged: (value) {
                    setState(() {
                      _minutes = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: AppTheme.textLight.withOpacity(0.7)),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    widget.onSave(
                      Duration(hours: _hours, minutes: _minutes),
                    );
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                  ),
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TimePickerField extends StatelessWidget {
  final int value;
  final int maxValue;
  final String label;
  final Function(int) onChanged;

  const _TimePickerField({
    required this.value,
    required this.maxValue,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: value > 0
                    ? () => onChanged(value - 1)
                    : null,
                color: AppTheme.textLight,
              ),
              SizedBox(
                width: 40,
                child: Text(
                  value.toString().padLeft(2, '0'),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppTheme.textLight,
                      ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: value < maxValue
                    ? () => onChanged(value + 1)
                    : null,
                color: AppTheme.textLight,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textLight.withOpacity(0.7),
              ),
        ),
      ],
    );
  }
} 