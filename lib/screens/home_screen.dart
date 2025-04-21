import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/friend_models.dart';
import '../theme/app_theme.dart';
import '../widgets/tracking_card.dart';
import '../widgets/leaderboard.dart';
import '../widgets/trend_insight.dart';
import '../main.dart';
import 'friend_screen.dart';
import 'stats_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LeaderboardType _leaderboardType = LeaderboardType.steps;

  // TODO: Replace with actual data from a provider
  final List<User> _mockUsers = [
    User(
      id: '1',
      name: 'Kenny',
      steps: 30000,
      screenTime: const Duration(minutes: 30),
    ),
    User(
      id: '2',
      name: 'Thaarak',
      steps: 25000,
      screenTime: const Duration(minutes: 40),
    ),
    User(
      id: '3',
      name: 'Shrish',
      steps: 10000,
      screenTime: const Duration(hours: 1, minutes: 20),
    ),
    User(
      id: '4',
      name: 'You',
      steps: 5000,
      screenTime: const Duration(hours: 1, minutes: 30),
    ),
    User(
      id: '5',
      name: 'Vipin Deepak',
      steps: 2000,
      screenTime: const Duration(hours: 13, minutes: 8),
    ),
  ];

  void _navigateToStats(bool showSteps) {
    // Get the MainNavigator state to update the selected index
    final mainNavigator = MainNavigator.of(context);
    if (mainNavigator != null) {
      // Navigate to the stats screen (index 1) with the selected option
      mainNavigator.updateIndex(1, showSteps: showSteps);
    }
  }

  void _onFriendTapped(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FriendScreen(
          friend: Friend.fromUser(user),
        ),
      ),
    );
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              TrackingCard(
                title: 'Steps:',
                value: '10,000',
                streak: 2,
                progress: 0.8,
                onTap: () => _navigateToStats(true),
              ),
              TrackingCard(
                title: 'Screen Time:',
                value: '1h 30m',
                streak: 2,
                progress: 0.6,
                onTap: () => _navigateToStats(false),
              ),
              Leaderboard(
                users: _mockUsers,
                currentUserId: '4', // ID for 'You'
                type: _leaderboardType,
                onTypeChanged: (type) {
                  setState(() {
                    _leaderboardType = type;
                  });
                },
                onUserTap: _onFriendTapped,
              ),
              TrendInsight(
                insightText: _leaderboardType == LeaderboardType.steps
                    ? 'You walked the most (2000 steps) from 2 PM - 3 PM.'
                    : 'You were on your phone the most (45 minutes) from 8 PM - 9 PM.',
                onTap: () {
                  // TODO: Show detailed insights
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
} 