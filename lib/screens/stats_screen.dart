import 'package:flutter/material.dart';
import '../models/stats_data.dart';
import '../theme/app_theme.dart';
import '../widgets/stats_toggle_buttons.dart';
import '../widgets/stats_summary_card.dart';
import '../widgets/stats_chart.dart';
import '../widgets/trend_insight.dart';
import '../widgets/period_selector.dart';
import 'dart:math';

// Configuration class to store stats screen state
class StatsScreenConfig {
  static bool showSteps = true; // Default to steps view
}

class StatsScreen extends StatefulWidget {
  final bool? initialShowSteps;

  const StatsScreen({
    Key? key,
    this.initialShowSteps,
  }) : super(key: key);

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  late bool _showSteps;
  StatsTimeframe _timeframe = StatsTimeframe.day;
  DateTime _selectedDate = DateTime.now();
  late StatsData _data;

  @override
  void initState() {
    super.initState();
    _showSteps = widget.initialShowSteps ?? true;
    _updateData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check if the selected type has changed
    if (_showSteps != StatsScreenConfig.showSteps) {
      setState(() {
        _showSteps = StatsScreenConfig.showSteps;
        _updateData();
      });
    }
  }

  String get _timeframeString {
    switch (_timeframe) {
      case StatsTimeframe.day:
        return 'day';
      case StatsTimeframe.week:
        return 'week';
      case StatsTimeframe.month:
        return 'month';
    }
  }

  void _updateData() {
    final dataPoints = List.generate(
      _timeframe == StatsTimeframe.day ? 24 : _timeframe == StatsTimeframe.week ? 7 : 30,
      (index) => (_showSteps ? 7500 : 160) + (index * 100 * (index % 2 == 0 ? 1 : -1)),
    ).map((value) => value.toDouble()).toList();

    final data = dataPoints.asMap().entries.map((entry) => {
      'time': entry.key,
      'value': entry.value,
    }).toList();

    _data = StatsData(
      data: data,
      maxValue: dataPoints.reduce((a, b) => a > b ? a : b),
      totalValue: _showSteps ? 8432 : 185,
      averageValue: _showSteps ? 7500 : 160,
      changePercentage: 12.5,
      dataPoints: dataPoints,
    );
  }

  void _onTimeframeChanged(String timeframe) {
    setState(() {
      _timeframe = StatsTimeframe.values.firstWhere(
        (t) => t.toString().split('.').last == timeframe,
      );
      _updateData();
    });
  }

  void _onToggleDataType(bool showSteps) {
    setState(() {
      _showSteps = showSteps;
      StatsScreenConfig.showSteps = showSteps; // Update the config when toggling
      _updateData();
    });
  }

  void _showPeriodSelector() async {
    final DateTime? selectedDate = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return PeriodSelector(
          timeframe: _timeframe,
          selectedDate: _selectedDate,
          onDateSelected: (date) {
            Navigator.pop(context, date);
          },
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
        _updateData();
      });
    }
  }

  String _formatSelectedPeriod() {
    if (_timeframe == StatsTimeframe.day) {
      if (_selectedDate.year == DateTime.now().year &&
          _selectedDate.month == DateTime.now().month &&
          _selectedDate.day == DateTime.now().day) {
        return 'Today';
      } else if (_selectedDate.year == DateTime.now().year &&
          _selectedDate.month == DateTime.now().month &&
          _selectedDate.day == DateTime.now().subtract(const Duration(days: 1)).day) {
        return 'Yesterday';
      }
      return '${_selectedDate.month}/${_selectedDate.day}';
    } else if (_timeframe == StatsTimeframe.week) {
      final now = DateTime.now();
      final startOfWeek = _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));
      final endOfWeek = startOfWeek.add(const Duration(days: 6));
      
      if (startOfWeek.year == now.year &&
          startOfWeek.month == now.month &&
          startOfWeek.day == now.subtract(Duration(days: now.weekday - 1)).day) {
        return 'This Week';
      } else if (startOfWeek.year == now.year &&
          startOfWeek.month == now.month &&
          startOfWeek.day == now.subtract(Duration(days: now.weekday + 6)).day) {
        return 'Last Week';
      }
      return '${startOfWeek.month}/${startOfWeek.day} - ${endOfWeek.month}/${endOfWeek.day}';
    } else {
      if (_selectedDate.year == DateTime.now().year &&
          _selectedDate.month == DateTime.now().month) {
        return 'This Month';
      } else if (_selectedDate.year == DateTime.now().year &&
          _selectedDate.month == DateTime.now().month - 1) {
        return 'Last Month';
      }
      return '${_selectedDate.month}/${_selectedDate.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: StatsToggleButtons(
                showSteps: _showSteps,
                timeframe: _timeframeString,
                onToggleDataType: _onToggleDataType,
                onTimeframeChanged: _onTimeframeChanged,
              ),
            ),
            StatsSummaryCard(
              data: _data,
              timeframe: _timeframeString,
              selectedPeriod: _formatSelectedPeriod(),
              onPeriodTap: _showPeriodSelector,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: StatsChart(
                  data: _data,
                  timeframe: _timeframeString,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 