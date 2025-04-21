import 'package:flutter/material.dart';
import '../models/user.dart';
import '../theme/app_theme.dart';

enum LeaderboardType {
  steps,
  screenTime,
}

class Leaderboard extends StatelessWidget {
  final List<User> users;
  final String currentUserId;
  final LeaderboardType type;
  final Function(LeaderboardType) onTypeChanged;
  final Function(User) onUserTap;

  const Leaderboard({
    super.key,
    required this.users,
    required this.currentUserId,
    required this.type,
    required this.onTypeChanged,
    required this.onUserTap,
  });

  List<User> _getSortedUsers() {
    return List<User>.from(users)..sort((a, b) {
      if (type == LeaderboardType.steps) {
        return b.steps.compareTo(a.steps); // Higher steps is better
      } else {
        return a.screenTime.compareTo(b.screenTime); // Lower screen time is better
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sortedUsers = _getSortedUsers();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Leaderboard',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              SegmentedButton<LeaderboardType>(
                segments: const [
                  ButtonSegment(
                    value: LeaderboardType.steps,
                    label: Text('Steps'),
                    icon: null,
                  ),
                  ButtonSegment(
                    value: LeaderboardType.screenTime,
                    label: Text('Screen Time'),
                    icon: null,
                  ),
                ],
                selected: {type},
                onSelectionChanged: (Set<LeaderboardType> selection) {
                  onTypeChanged(selection.first);
                },
                style: ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return AppTheme.primaryGreen;
                    }
                    return null;
                  }),
                  foregroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return Colors.white;
                    }
                    return null;
                  }),
                  side: MaterialStateProperty.all(BorderSide.none),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
                showSelectedIcon: false,
              ),
            ],
          ),
        ),
        ...sortedUsers.asMap().entries.map((entry) => _LeaderboardItem(
              user: entry.value,
              rank: entry.key + 1,
              isCurrentUser: entry.value.id == currentUserId,
              type: type,
              onTap: () => onUserTap(entry.value),
            )),
      ],
    );
  }
}

class _LeaderboardItem extends StatelessWidget {
  final User user;
  final int rank;
  final bool isCurrentUser;
  final LeaderboardType type;
  final VoidCallback onTap;

  const _LeaderboardItem({
    required this.user,
    required this.rank,
    required this.isCurrentUser,
    required this.type,
    required this.onTap,
  });

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  Widget _buildRankIndicator(BuildContext context) {
    final color = switch (rank) {
      1 => Colors.amber, // Gold
      2 => Colors.grey[300], // Silver
      3 => Colors.brown[300], // Bronze
      _ => Colors.transparent,
    };

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          rank.toString(),
          style: TextStyle(
            color: rank <= 3 ? Colors.black : Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final value = type == LeaderboardType.steps
        ? '${user.steps.toString()} steps'
        : _formatDuration(user.screenTime);

    return ListTile(
      leading: _buildRankIndicator(context),
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor: isCurrentUser ? AppTheme.primaryGreen : null,
            child: Text(user.name[0]),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
} 