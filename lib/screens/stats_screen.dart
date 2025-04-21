import 'package:flutter/material.dart';
import '../models/stats.dart';
import '../widgets/stats/steps_view.dart';
import '../widgets/stats/screen_time_view.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _timeRange = 'Day'; // Day, Week, Month

  // Dummy data for demonstration
  final StepStats _stepStats = StepStats(
    steps: 2000,
    goal: 10000,
    activeMinutes: const Duration(minutes: 45),
    calories: 150,
    hourlySteps: {
      '12 AM': 1500,
      '3 AM': 400,
      '6 AM': 1200,
      '9 AM': 2000,
      '12 PM': 700,
      '3 PM': 300,
      '6 PM': 1000,
      '9 PM': 1700,
    },
  );

  final ScreenTimeStats _screenTimeStats = ScreenTimeStats(
    totalTime: const Duration(hours: 1, minutes: 30),
    goal: const Duration(hours: 2),
    appUsage: {
      'Instagram': const Duration(minutes: 45),
      'TikTok': const Duration(minutes: 25),
      'YouTube': const Duration(minutes: 20),
    },
    categoryUsage: {
      'Social': const Duration(hours: 1, minutes: 10),
      'Entertainment': const Duration(minutes: 20),
    },
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stats'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Steps'),
            Tab(text: 'Screen Time'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Time range selector
          Padding(
            padding: const EdgeInsets.all(16),
            child: SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'Day', label: Text('Day')),
                ButtonSegment(value: 'Week', label: Text('Week')),
                ButtonSegment(value: 'Month', label: Text('Month')),
              ],
              selected: {_timeRange},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  _timeRange = newSelection.first;
                });
              },
            ),
          ),
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                StepsView(stats: _stepStats, timeRange: _timeRange),
                ScreenTimeView(stats: _screenTimeStats, timeRange: _timeRange),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 