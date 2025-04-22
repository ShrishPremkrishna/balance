import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/stats_screen.dart';
import 'screens/goals_screen.dart';
import 'screens/add_friends_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Balance',
      theme: AppTheme.darkTheme,
      home: const MainNavigator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => MainNavigatorState();

  static MainNavigatorState? of(BuildContext context) {
    return context.findAncestorStateOfType<MainNavigatorState>();
  }
}

class MainNavigatorState extends State<MainNavigator> {
  int _selectedIndex = 0;
  bool? _statsInitialShowSteps;

  final List<Widget> _screens = const [
    HomeScreen(),
    StatsScreen(),
    GoalsScreen(),
  ];

  void updateIndex(int index, {bool? showSteps}) {
    setState(() {
      _selectedIndex = index;
      _statsInitialShowSteps = showSteps;
    });
  }

  void _showAddFriendsModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const AddFriendsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Create screens list with updated StatsScreen when needed
    final screens = [
      _screens[0],
      if (_selectedIndex == 1) 
        StatsScreen(initialShowSteps: _statsInitialShowSteps)
      else 
        _screens[1],
      _screens[2],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Balance'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: _showAddFriendsModal,
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
            if (index != 1) {
              _statsInitialShowSteps = null; // Reset when navigating away from stats
            }
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart),
            label: 'Stats',
          ),
          NavigationDestination(
            icon: Icon(Icons.track_changes),
            label: 'Goals',
          ),
        ],
      ),
    );
  }
}
