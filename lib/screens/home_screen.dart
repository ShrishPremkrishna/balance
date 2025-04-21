import 'package:flutter/material.dart';
import '../models/user.dart';
import '../widgets/stats_card.dart';
import '../widgets/leaderboard.dart';
import 'balance_screen.dart';
import 'notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;

  final List<Widget> _screens = [
    const BalanceScreen(),
    _HomeContent(),
    const NotificationsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 1 ? AppBar(
        title: const Text(
          'Balance',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // TODO: Implement menu navigation
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Implement add friend
            },
          ),
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              // TODO: Implement messages
            },
          ),
        ],
      ) : null,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.compass_calibration),
            label: 'Balance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy data for demonstration
    final List<User> leaderboardUsers = [
      User(id: '1', name: 'Kenny', avatarUrl: '', steps: 30000, screenTime: const Duration(hours: 1)),
      User(id: '2', name: 'Thaarak', avatarUrl: '', steps: 25000, screenTime: const Duration(hours: 2)),
      User(id: '3', name: 'You', avatarUrl: '', steps: 10000, screenTime: const Duration(hours: 1, minutes: 30)),
      User(id: '4', name: 'Shrish', avatarUrl: '', steps: 5000, screenTime: const Duration(hours: 3)),
      User(id: '5', name: 'Vipin Deepak', avatarUrl: '', steps: 2000, screenTime: const Duration(hours: 2)),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Steps card
          StatsCard(
            title: 'Steps',
            value: '10,000',
            subtitle: 'Streak: 2 Days',
            onTap: () {
              // TODO: Navigate to steps details
            },
          ),
          const SizedBox(height: 16),
          
          // Screen time card
          StatsCard(
            title: 'Screen Time',
            value: '1h 30m',
            subtitle: 'Streak: 2 Days',
            onTap: () {
              // TODO: Navigate to screen time details
            },
          ),
          const SizedBox(height: 24),
          
          // Leaderboard
          Leaderboard(users: leaderboardUsers),
          
          const SizedBox(height: 24),
          
          // Top Trend card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Top Trend:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You walked the most (2000 steps) from 2 PM - 3 PM.',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 