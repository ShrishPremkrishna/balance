class User {
  final String id;
  final String name;
  final String avatarUrl;
  final int steps;
  final Duration screenTime;

  const User({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.steps,
    required this.screenTime,
  });
} 