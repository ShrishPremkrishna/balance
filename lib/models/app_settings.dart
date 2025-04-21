import 'package:flutter/material.dart';

class AppSettings {
  final int dailyStepGoal;
  final Duration dailyScreenTimeLimit;
  final bool fiveForSixtyEnabled;
  final int minutesPerHour;
  final List<RestrictedApp> restrictedApps;
  final MindfulnessSettings mindfulnessSettings;
  final NotificationSettings notificationSettings;

  const AppSettings({
    required this.dailyStepGoal,
    required this.dailyScreenTimeLimit,
    required this.fiveForSixtyEnabled,
    required this.minutesPerHour,
    required this.restrictedApps,
    required this.mindfulnessSettings,
    required this.notificationSettings,
  });
}

class RestrictedApp {
  final String id;
  final String name;
  final String iconPath;
  final Duration timeLimit;
  final bool isEnabled;

  const RestrictedApp({
    required this.id,
    required this.name,
    required this.iconPath,
    required this.timeLimit,
    required this.isEnabled,
  });
}

class MindfulnessSettings {
  final bool openAppTrigger;
  final bool idleTrigger;
  final bool breathingEnabled;
  final bool stretchingEnabled;
  final bool quotesEnabled;
  final bool todoEnabled;
  final bool mathProblemsEnabled;
  final bool stepCounterEnabled;

  const MindfulnessSettings({
    required this.openAppTrigger,
    required this.idleTrigger,
    required this.breathingEnabled,
    required this.stretchingEnabled,
    required this.quotesEnabled,
    required this.todoEnabled,
    required this.mathProblemsEnabled,
    required this.stepCounterEnabled,
  });
}

class NotificationSettings {
  final int frequencyPerDay;
  final TimeOfDay quietHoursStart;
  final TimeOfDay quietHoursEnd;

  const NotificationSettings({
    required this.frequencyPerDay,
    required this.quietHoursStart,
    required this.quietHoursEnd,
  });
} 