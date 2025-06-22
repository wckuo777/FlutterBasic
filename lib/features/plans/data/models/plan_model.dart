class Plan {
  final String id;
  String name;
  int goalCount;
  DateTime startDate;
  DateTime? endDate;
  String frequency; // 例如 "每日", "每週", "每月"
  double reward;

  Plan({
    required this.id,
    required this.name,
    required this.goalCount,
    required this.startDate,
    this.endDate,
    required this.frequency,
    required this.reward,
  });

  Plan copyWith({
    String? id,
    String? name,
    int? goalCount,
    DateTime? startDate,
    DateTime? endDate,
    String? frequency,
    double? reward,
  }) {
    return Plan(
      id: id ?? this.id,
      name: name ?? this.name,
      goalCount: goalCount ?? this.goalCount,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      frequency: frequency ?? this.frequency,
      reward: reward ?? this.reward,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'goalCount': goalCount,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'frequency': frequency,
      'reward': reward,
    };
  }

  // 新增：從 Map 建立 Plan
  factory Plan.fromMap(Map<String, dynamic> map) {
    return Plan(
      id: map['id'],
      name: map['name'],
      goalCount: map['goalCount'],
      startDate: DateTime.parse(map['startDate']),
      endDate: map['endDate'] != null ? DateTime.parse(map['endDate']) : null,
      frequency: map['frequency'],
      reward: map['reward'] is int
          ? (map['reward'] as int).toDouble()
          : map['reward'],
    );
  }
}
