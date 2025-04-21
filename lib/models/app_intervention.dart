enum InterventionType {
  none,
  mathProblem,
  meditation,
  stepCounter,
}

class UnlockProbability {
  final int numerator;
  final int denominator;

  const UnlockProbability(this.numerator, this.denominator);

  static const always = UnlockProbability(1, 1);
  static const never = UnlockProbability(0, 1);

  @override
  String toString() {
    if (this == always) return 'Always';
    if (this == never) return 'Never';
    return '1 in $denominator';
  }
}

class AppIntervention {
  final InterventionType type;
  final UnlockProbability probability;
  final int pauseDurationSeconds;

  const AppIntervention({
    this.type = InterventionType.none,
    this.probability = const UnlockProbability(1, 1),
    this.pauseDurationSeconds = 0,
  });

  AppIntervention copyWith({
    InterventionType? type,
    UnlockProbability? probability,
    int? pauseDurationSeconds,
  }) {
    return AppIntervention(
      type: type ?? this.type,
      probability: probability ?? this.probability,
      pauseDurationSeconds: pauseDurationSeconds ?? this.pauseDurationSeconds,
    );
  }
} 