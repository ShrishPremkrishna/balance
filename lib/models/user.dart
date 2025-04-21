class User {
  final String id;
  final String name;
  final String avatarUrl;
  final int steps;
  final Duration screenTime;
  final int streak;

  const User({
    required this.id,
    required this.name,
    this.avatarUrl = '',
    required this.steps,
    required this.screenTime,
    this.streak = 0,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String? ?? '',
      steps: json['steps'] as int,
      screenTime: Duration(minutes: json['screenTimeMinutes'] as int),
      streak: json['streak'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatarUrl': avatarUrl,
      'steps': steps,
      'screenTimeMinutes': screenTime.inMinutes,
      'streak': streak,
    };
  }
} 