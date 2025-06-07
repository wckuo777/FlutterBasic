import 'dart:collection';
import 'package:uuid/uuid.dart';
import '../models/plan_model.dart';

class PlanRepository {
  final List<Plan> _plans = [
    Plan(
      id: const Uuid().v4(),
      name: '晨跑',
      goalCount: 10,
      startDate: DateTime.now(),
      frequency: '每日',
      reward: 100,
    ),
    Plan(
      id: const Uuid().v4(),
      name: '讀書',
      goalCount: 15,
      startDate: DateTime.now(),
      frequency: '每週',
      reward: 200,
    ),
  ];

  List<Plan> getAll() => UnmodifiableListView(_plans);

  Plan? getById(String id) {
    try {
      return _plans.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  void add(Plan plan) {
    _plans.add(plan);
  }

  void update(Plan updated) {
    final index = _plans.indexWhere((p) => p.id == updated.id);
    if (index != -1) {
      _plans[index] = updated;
    }
  }

  void delete(String id) {
    _plans.removeWhere((p) => p.id == id);
  }
}

// ✅ 提供全 app 共用的 singleton 實例
final PlanRepository planRepository = PlanRepository();
