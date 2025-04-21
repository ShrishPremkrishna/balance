import 'package:flutter/material.dart';
import '../models/friend_models.dart';
import '../theme/app_theme.dart';
import '../widgets/comparison_metric_card.dart';
import '../widgets/daily_winner_calendar.dart';

class FriendScreen extends StatefulWidget {
  final Friend friend;

  const FriendScreen({
    super.key,
    required this.friend,
  });

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  bool _isCompareView = false;
  ComparisonTimeframe _timeframe = ComparisonTimeframe.day;
  ComparisonMetric _selectedMetric = ComparisonMetric.steps;
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person_remove, color: Colors.red),
              title: const Text('Remove Friend'),
              onTap: () {
                // TODO: Implement remove friend
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatView() {
    return Column(
      children: [
        Expanded(
          child: Container(
            // TODO: Implement chat messages list
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Send a message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  // TODO: Implement send message
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompareView() {
    String title;
    int steps;
    Duration screenTime;
    
    switch (_timeframe) {
      case ComparisonTimeframe.day:
        title = 'Today';
        steps = widget.friend.dailySteps;
        screenTime = widget.friend.dailyScreenTime;
      case ComparisonTimeframe.week:
        title = '7 Day Average';
        steps = widget.friend.weeklyAverageSteps;
        screenTime = widget.friend.weeklyAverageScreenTime;
      case ComparisonTimeframe.month:
        title = 'March Average';
        steps = widget.friend.monthlyAverageSteps;
        screenTime = widget.friend.monthlyAverageScreenTime;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SegmentedButton<ComparisonTimeframe>(
            segments: const [
              ButtonSegment(
                value: ComparisonTimeframe.day,
                label: Text('Day'),
              ),
              ButtonSegment(
                value: ComparisonTimeframe.week,
                label: Text('Week'),
              ),
              ButtonSegment(
                value: ComparisonTimeframe.month,
                label: Text('Month'),
              ),
            ],
            selected: {_timeframe},
            onSelectionChanged: (Set<ComparisonTimeframe> selection) {
              setState(() {
                _timeframe = selection.first;
              });
            },
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ComparisonMetricCard(
                    title: 'Steps $title',
                    yourValue: '10,000',
                    friendValue: steps.toString(),
                    yourProgress: 10000 / (10000 + steps),
                    friendProgress: steps / (10000 + steps),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ComparisonMetricCard(
                    title: 'Screen Time $title',
                    yourValue: '1h 15m',
                    friendValue: _formatDuration(screenTime),
                    yourProgress: 75 / (75 + screenTime.inMinutes),
                    friendProgress: screenTime.inMinutes / (75 + screenTime.inMinutes),
                    yourColor: AppTheme.primaryGreen,
                    friendColor: AppTheme.primaryRed,
                  ),
                ),
                const SizedBox(height: 16),
                SegmentedButton<ComparisonMetric>(
                  segments: const [
                    ButtonSegment(
                      value: ComparisonMetric.steps,
                      label: Text('Steps'),
                    ),
                    ButtonSegment(
                      value: ComparisonMetric.screenTime,
                      label: Text('Screen Time'),
                    ),
                  ],
                  selected: {_selectedMetric},
                  onSelectionChanged: (Set<ComparisonMetric> selection) {
                    setState(() {
                      _selectedMetric = selection.first;
                    });
                  },
                ),
                const SizedBox(height: 16),
                DailyWinnerCalendar(
                  winners: _generateMockWinners(),
                  selectedMetric: _selectedMetric,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<DailyWinner> _generateMockWinners() {
    final now = DateTime.now();
    return List.generate(
      12,
      (index) => DailyWinner(
        date: now.subtract(Duration(days: index)),
        stepsWinner: index % 2 == 0 ? WinnerType.you : WinnerType.friend,
        screenTimeWinner: index % 2 == 0 ? WinnerType.friend : WinnerType.you,
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: widget.friend.profileImageUrl != null
                  ? NetworkImage(widget.friend.profileImageUrl!)
                  : null,
              child: widget.friend.profileImageUrl == null
                  ? Text(widget.friend.name[0])
                  : null,
            ),
            const SizedBox(width: 8),
            Text(widget.friend.name),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: _showMoreOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SegmentedButton<bool>(
              segments: const [
                ButtonSegment(
                  value: false,
                  label: Text('Chat'),
                ),
                ButtonSegment(
                  value: true,
                  label: Text('Compare'),
                ),
              ],
              selected: {_isCompareView},
              onSelectionChanged: (Set<bool> selection) {
                setState(() {
                  _isCompareView = selection.first;
                });
              },
            ),
          ),
          Expanded(
            child: _isCompareView ? _buildCompareView() : _buildChatView(),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton('Cheer', Icons.celebration),
                  _buildActionButton('Nudge', Icons.notifications_active),
                  _buildActionButton('Taunt', Icons.emoji_emotions),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {
        // TODO: Implement action button functionality
      },
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
} 