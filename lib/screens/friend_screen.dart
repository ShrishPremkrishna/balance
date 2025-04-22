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
  bool _isCompareView = true;
  ComparisonTimeframe _timeframe = ComparisonTimeframe.day;
  ComparisonMetric _selectedMetric = ComparisonMetric.steps;
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  String get _timeframeTitle {
    switch (_timeframe) {
      case ComparisonTimeframe.day:
        return 'Today';
      case ComparisonTimeframe.week:
        return 'This Week';
      case ComparisonTimeframe.month:
        return 'This Month';
    }
  }

  void _showRemoveFriendDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Remove Friend',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Remove ${widget.friend.name} from your friends?',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement friend removal logic
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Return to previous screen
            },
            child: Text(
              'Remove',
              style: TextStyle(
                color: Colors.red.shade400,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
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
              backgroundColor: AppTheme.primaryGreen,
              child: Text(widget.friend.name[0]),
            ),
            const SizedBox(width: 12),
            Text(widget.friend.name),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'remove') {
                _showRemoveFriendDialog();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'remove',
                child: Row(
                  children: [
                    Icon(
                      Icons.person_remove,
                      color: Colors.red.shade400,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Remove Friend',
                      style: TextStyle(
                        color: Colors.red.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
              style: ButtonStyle(
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
            ),
          ),
          if (_isCompareView) _buildCompareView() else _buildChatView(),
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

  Widget _buildCompareView() {
    final steps = switch (_timeframe) {
      ComparisonTimeframe.day => widget.friend.dailySteps,
      ComparisonTimeframe.week => widget.friend.weeklyAverageSteps,
      ComparisonTimeframe.month => widget.friend.monthlyAverageSteps,
    };

    final screenTime = switch (_timeframe) {
      ComparisonTimeframe.day => widget.friend.dailyScreenTime,
      ComparisonTimeframe.week => widget.friend.weeklyAverageScreenTime,
      ComparisonTimeframe.month => widget.friend.monthlyAverageScreenTime,
    };

    final title = _timeframeTitle;

    return Expanded(
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
              style: ButtonStyle(
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
            ),
            const SizedBox(height: 16),
            SegmentedButton<ComparisonTimeframe>(
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
              style: ButtonStyle(
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
            ),
            const SizedBox(height: 16),
            DailyWinnerCalendar(
              winners: _generateMockWinners(),
              selectedMetric: _selectedMetric,
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
} 