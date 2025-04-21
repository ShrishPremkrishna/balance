import 'user.dart';

enum ComparisonMetric {
  steps,
  screenTime,
}

enum ComparisonTimeframe {
  day,
  week,
  month,
}

enum WinnerType {
  you,
  friend,
  tie,
  none,
}

class DailyWinner {
  final DateTime date;
  final WinnerType stepsWinner;
  final WinnerType screenTimeWinner;

  const DailyWinner({
    required this.date,
    required this.stepsWinner,
    required this.screenTimeWinner,
  });
}

class Friend {
  final String id;
  final String name;
  final String? profileImageUrl;
  final int dailySteps;
  final Duration dailyScreenTime;
  final int weeklyAverageSteps;
  final Duration weeklyAverageScreenTime;
  final int monthlyAverageSteps;
  final Duration monthlyAverageScreenTime;

  const Friend({
    required this.id,
    required this.name,
    this.profileImageUrl,
    required this.dailySteps,
    required this.dailyScreenTime,
    required this.weeklyAverageSteps,
    required this.weeklyAverageScreenTime,
    required this.monthlyAverageSteps,
    required this.monthlyAverageScreenTime,
  });

  // Convert User to Friend
  factory Friend.fromUser(User user) {
    return Friend(
      id: user.id,
      name: user.name,
      dailySteps: user.steps,
      dailyScreenTime: user.screenTime,
      weeklyAverageSteps: user.steps, // TODO: Calculate actual averages
      weeklyAverageScreenTime: user.screenTime,
      monthlyAverageSteps: user.steps,
      monthlyAverageScreenTime: user.screenTime,
    );
  }
} 