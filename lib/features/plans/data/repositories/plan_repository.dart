import 'dart:collection';
import 'package:plans_record_flt/core/db/app_database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../models/plan_model.dart';

class PlanRepository {
  // sqllite
  Future<List<Plan>> getAll() async {
    final db = await AppDatabase.database;
    final maps = await db.query('plans');
    return maps.map((map) => Plan.fromMap(map)).toList();
  }

  Future<Plan?> getById(String id) async {
    final db = await AppDatabase.database;
    final maps = await db.query('plans', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Plan.fromMap(maps.first);
    }
    return null;
  }

  Future<void> add(Plan plan) async {
    final db = await AppDatabase.database;
    await db.insert('plans', plan.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(Plan plan) async {
    final db = await AppDatabase.database;
    await db.update(
      'plans',
      plan.toMap(),
      where: 'id = ?',
      whereArgs: [plan.id],
    );
  }

  Future<void> delete(String id) async {
    final db = await AppDatabase.database;
    await db.delete('plans', where: 'id = ?', whereArgs: [id]);
  }
  // fake
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

  List<Plan> getAllfake() => UnmodifiableListView(_plans);

  Plan? getByIdfake(String id) {
    try {
      return _plans.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  void addfake(Plan plan) {
    _plans.add(plan);
  }

  void updatefake(Plan updated) {
    final index = _plans.indexWhere((p) => p.id == updated.id);
    if (index != -1) {
      _plans[index] = updated;
    }
  }

  void deletefake(String id) {
    _plans.removeWhere((p) => p.id == id);
  }
}

// ✅ 提供全 app 共用的 singleton 實例
final PlanRepository planRepository = PlanRepository();
