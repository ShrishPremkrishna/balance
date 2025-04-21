class StepStats {
  final int steps;
  final int goal;
  final Duration activeMinutes;
  final int calories;
  final Map<String, int> hourlySteps;

  const StepStats({
    required this.steps,
    required this.goal,
    required this.activeMinutes,
    required this.calories,
    required this.hourlySteps,
  });
}

class ScreenTimeStats {
  final Duration totalTime;
  final Duration goal;
  final Map<String, Duration> appUsage;
  final Map<String, Duration> categoryUsage;

  const ScreenTimeStats({
    required this.totalTime,
    required this.goal,
    required this.appUsage,
    required this.categoryUsage,
  });
}

class Achievement {
  final String id;
  final String title;
  final String description;
  final String iconPath;
  final bool isUnlocked;
  final DateTime? unlockedAt;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.iconPath,
    required this.isUnlocked,
    this.unlockedAt,
  });
} 