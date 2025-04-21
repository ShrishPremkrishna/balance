import 'package:flutter/material.dart';
import '../models/user.dart';

class Leaderboard extends StatefulWidget {
  final List<User> users;

  const Leaderboard({
    super.key,
    required this.users,
  });

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  String _sortBy = 'Steps';
  late List<User> _sortedUsers;

  @override
  void initState() {
    super.initState();
    _sortedUsers = List.from(widget.users);
    _sortUsers();
  }

  void _sortUsers() {
    setState(() {
      if (_sortBy == 'Steps') {
        _sortedUsers.sort((a, b) => b.steps.compareTo(a.steps));
      } else {
        _sortedUsers.sort((a, b) => a.screenTime.compareTo(b.screenTime));
      }
    });
  }

  String _formatValue(User user) {
    if (_sortBy == 'Steps') {
      return user.steps.toString();
    } else {
      final hours = user.screenTime.inHours;
      final minutes = user.screenTime.inMinutes.remainder(60);
      return '${hours}h ${minutes}m';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Leaderboard',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DropdownButton<String>(
                  value: _sortBy,
                  items: const [
                    DropdownMenuItem(
                      value: 'Steps',
                      child: Text('Steps'),
                    ),
                    DropdownMenuItem(
                      value: 'Screen Time',
                      child: Text('Screen Time'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _sortBy = value;
                        _sortUsers();
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            ..._sortedUsers.asMap().entries.map((entry) {
              final index = entry.key;
              final user = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Text(
                      '${index + 1}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _formatValue(user),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
} 