import 'package:flutter/material.dart';
import '../models/app_limit.dart';
import '../theme/app_theme.dart';

class AppPicker extends StatelessWidget {
  final List<AppLimit> currentLimits;
  final Function(AppLimit) onAppSelected;

  const AppPicker({
    super.key,
    required this.currentLimits,
    required this.onAppSelected,
  });

  // TODO: Replace with actual app data from the device
  final List<Map<String, dynamic>> _availableApps = const [
    {
      'name': 'Instagram',
      'icon': Icons.photo_camera,
    },
    {
      'name': 'TikTok',
      'icon': Icons.music_video,
    },
    {
      'name': 'YouTube',
      'icon': Icons.play_circle,
    },
    {
      'name': 'Facebook',
      'icon': Icons.facebook,
    },
    {
      'name': 'Twitter',
      'icon': Icons.chat,
    },
    {
      'name': 'Snapchat',
      'icon': Icons.camera_alt,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final availableApps = _availableApps
        .where((app) =>
            !currentLimits.any((limit) => limit.appName == app['name']))
        .toList();

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add App',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Select an app to set a time limit',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textLight.withOpacity(0.7),
                  ),
            ),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: availableApps.length,
                itemBuilder: (context, index) {
                  final app = availableApps[index];
                  return ListTile(
                    leading: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGreen.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        app['icon'] as IconData,
                        color: AppTheme.primaryGreen,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      app['name'] as String,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    onTap: () {
                      onAppSelected(
                        AppLimit(
                          appName: app['name'] as String,
                          appIconPath: '', // Not using image assets anymore
                          timeLimit: const Duration(minutes: 30),
                        ),
                      );
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: AppTheme.textLight.withOpacity(0.7)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 