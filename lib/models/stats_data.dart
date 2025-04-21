import 'package:flutter/material.dart';
import 'dart:math' as math;

enum StatsType { steps, screenTime }
enum StatsTimeframe { day, week, month }
enum ChartType { bar, line }

class TimeSeriesData {
  final DateTime time;
  final double value;

  TimeSeriesData(this.time, this.value);
}

class StatsSummary {
  final String title;
  final String value;
  final String subtitle;
  final String? additionalInfo;
  final double progress;

  StatsSummary({
    required this.title,
    required this.value,
    required this.subtitle,
    this.additionalInfo,
    required this.progress,
  });
}

class StatsInsight {
  final String message;
  final DateTime timestamp;

  StatsInsight({
    required this.message,
    required this.timestamp,
  });
}

class StatsData {
  final List<Map<String, dynamic>> data;
  final double maxValue;
  final double totalValue;
  final double averageValue;
  final double changePercentage;
  final List<double> dataPoints;

  StatsData({
    required this.data,
    required this.maxValue,
    required this.totalValue,
    required this.averageValue,
    required this.changePercentage,
    required this.dataPoints,
  });

  factory StatsData.fromData(List<Map<String, dynamic>> data) {
    if (data.isEmpty) {
      return StatsData(
        data: [],
        maxValue: 0,
        totalValue: 0,
        averageValue: 0,
        changePercentage: 0,
        dataPoints: [],
      );
    }

    final values = data.map((e) => e['value'] as num).toList();
    final maxValue = values.reduce(math.max).toDouble();
    final totalValue = values.reduce((a, b) => a + b).toDouble();
    final averageValue = totalValue / values.length;
    
    // Calculate change percentage (mock for now)
    final changePercentage = 5.0; // Mock value

    return StatsData(
      data: data,
      maxValue: maxValue,
      totalValue: totalValue,
      averageValue: averageValue,
      changePercentage: changePercentage,
      dataPoints: values.map((v) => v.toDouble()).toList(),
    );
  }

  // Helper method to format time based on timeframe
  static String formatTime(DateTime time, StatsTimeframe timeframe) {
    switch (timeframe) {
      case StatsTimeframe.day:
        return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
      case StatsTimeframe.week:
        return '${time.month}/${time.day}';
      case StatsTimeframe.month:
        return '${time.month}/${time.day}';
    }
  }

  // Helper method to format values based on stats type
  static String formatValue(double value, StatsType type) {
    if (type == StatsType.steps) {
      return value.toInt().toString();
    } else {
      int hours = value ~/ 60;
      int minutes = value.toInt() % 60;
      if (hours > 0) {
        return '${hours}h ${minutes}m';
      }
      return '${minutes}m';
    }
  }
}

enum TimeFrame {
  day,
  week,
  month,
}

class StatPoint {
  final int? hour;  // For daily view
  final int? day;   // For monthly view
  final int steps;
  final int screenTimeMinutes;

  const StatPoint({
    this.hour,
    this.day,
    required this.steps,
    required this.screenTimeMinutes,
  });

  // Helper method to create daily data point
  static StatPoint daily({
    required int hour,
    required int steps,
    required int screenTimeMinutes,
  }) {
    return StatPoint(
      hour: hour,
      steps: steps,
      screenTimeMinutes: screenTimeMinutes,
    );
  }

  // Helper method to create weekly/monthly data point
  static StatPoint periodic({
    int? day,
    required int steps,
    required int screenTimeMinutes,
  }) {
    return StatPoint(
      day: day,
      steps: steps,
      screenTimeMinutes: screenTimeMinutes,
    );
  }
}

// Helper class to generate mock data for testing
class MockStatsData {
  static List<StatPoint> generateDailyData() {
    return List.generate(24, (hour) {
      return StatPoint.daily(
        hour: hour,
        steps: (500 + hour * 100 + (hour % 3) * 200).clamp(0, 3000),
        screenTimeMinutes: (15 + hour * 2 + (hour % 4) * 5).clamp(0, 60),
      );
    });
  }

  static List<StatPoint> generateWeeklyData() {
    return List.generate(7, (day) {
      return StatPoint.periodic(
        steps: (5000 + day * 1000 + (day % 2) * 2000).clamp(0, 15000),
        screenTimeMinutes: (60 + day * 15 + (day % 3) * 30).clamp(0, 240),
      );
    });
  }

  static List<StatPoint> generateMonthlyData() {
    return List.generate(30, (index) {
      return StatPoint.periodic(
        day: index + 1,
        steps: (7000 + (index % 7) * 1000 + (index % 3) * 1500).clamp(0, 20000),
        screenTimeMinutes: (90 + (index % 5) * 20 + (index % 4) * 25).clamp(0, 300),
      );
    });
  }

  static List<StatPoint> generateData(TimeFrame timeFrame) {
    switch (timeFrame) {
      case TimeFrame.day:
        return generateDailyData();
      case TimeFrame.week:
        return generateWeeklyData();
      case TimeFrame.month:
        return generateMonthlyData();
    }
  }
} 