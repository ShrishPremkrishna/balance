import 'package:flutter/material.dart';
import '../../models/app_settings.dart';

class RestrictedAppList extends StatefulWidget {
  const RestrictedAppList({super.key});

  @override
  State<RestrictedAppList> createState() => _RestrictedAppListState();
}

class _RestrictedAppListState extends State<RestrictedAppList> {
  // Dummy data for demonstration
  final List<RestrictedApp> _apps = [
    RestrictedApp(
      id: '1',
      name: 'Instagram',
      iconPath: 'assets/icons/instagram.png',
      timeLimit: const Duration(minutes: 20),
      isEnabled: true,
    ),
    RestrictedApp(
      id: '2',
      name: 'TikTok',
      iconPath: 'assets/icons/tiktok.png',
      timeLimit: const Duration(hours: 1, minutes: 5),
      isEnabled: true,
    ),
    RestrictedApp(
      id: '3',
      name: 'YouTube',
      iconPath: 'assets/icons/youtube.png',
      timeLimit: const Duration(minutes: 5),
      isEnabled: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._apps.map((app) => Card(
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
              ),
              // TODO: Replace with actual app icon
              child: const Icon(Icons.apps),
            ),
            title: Text(app.name),
            subtitle: Text(
              _formatDuration(app.timeLimit),
            ),
            trailing: Switch(
              value: app.isEnabled,
              onChanged: (value) {
                // TODO: Implement app restriction toggle
              },
            ),
          ),
        )),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () {
            // TODO: Implement add app functionality
          },
          icon: const Icon(Icons.add),
          label: const Text('Add App'),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    if (duration.inHours > 0) {
      return '${duration.inHours}h ${duration.inMinutes.remainder(60)}m';
    }
    return '${duration.inMinutes}m';
  }
} 