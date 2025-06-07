class Plan {
  final String id;
  String name;
  int goalCount;
  DateTime startDate;
  String frequency; // 例如 "每日", "每週", "每月"
  double reward;

  Plan({
    required this.id,
    required this.name,
    required this.goalCount,
    required this.startDate,
    required this.frequency,
    required this.reward,
  });

  Plan copyWith({
    String? id,
    String? name,
    int? goalCount,
    DateTime? startDate,
    String? frequency,
    double? reward,
  }) {
    return Plan(
      id: id ?? this.id,
      name: name ?? this.name,
      goalCount: goalCount ?? this.goalCount,
      startDate: startDate ?? this.startDate,
      frequency: frequency ?? this.frequency,
      reward: reward ?? this.reward,
    );
  }
}
