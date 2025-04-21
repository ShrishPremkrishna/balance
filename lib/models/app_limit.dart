import 'package:flutter/material.dart';
import 'app_intervention.dart';

class AppLimit {
  final String appName;
  final String appIconPath;
  final Duration timeLimit;
  final bool isEnabled;
  final int maxOpensPerDay;
  final int maxDurationPerOpen;
  final int minPauseDuration;
  final AppIntervention intervention;

  const AppLimit({
    required this.appName,
    required this.appIconPath,
    required this.timeLimit,
    this.isEnabled = true,
    this.maxOpensPerDay = 5,
    this.maxDurationPerOpen = 30,
    this.minPauseDuration = 15,
    this.intervention = const AppIntervention(),
  });

  AppLimit copyWith({
    String? appName,
    String? appIconPath,
    Duration? timeLimit,
    bool? isEnabled,
    int? maxOpensPerDay,
    int? maxDurationPerOpen,
    int? minPauseDuration,
    AppIntervention? intervention,
  }) {
    return AppLimit(
      appName: appName ?? this.appName,
      appIconPath: appIconPath ?? this.appIconPath,
      timeLimit: timeLimit ?? this.timeLimit,
      isEnabled: isEnabled ?? this.isEnabled,
      maxOpensPerDay: maxOpensPerDay ?? this.maxOpensPerDay,
      maxDurationPerOpen: maxDurationPerOpen ?? this.maxDurationPerOpen,
      minPauseDuration: minPauseDuration ?? this.minPauseDuration,
      intervention: intervention ?? this.intervention,
    );
  }
} 