import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/repositories/plan_repository.dart';
import '../data/models/plan_model.dart';

final PlanRepository planRepository = PlanRepository(); // 暫時以單例處理

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Plan> _plans;

  @override
  void initState() {
    super.initState();
    _plans = planRepository.getAll();
  }

  void _goToDetail({Plan? plan}) async {
    await Navigator.pushNamed(context, '/detail', arguments: plan);
    setState(() {
      _plans = planRepository.getAll();
    });
  }

  void _goToAnalysis() {
    Navigator.pushNamed(context, '/analysis');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的計畫'),
        actions: [
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.brightness_6), onPressed: () {}),
        ],
      ),
      body: ListView.builder(
        itemCount: _plans.length,
        itemBuilder: (context, index) {
          final plan = _plans[index];
          return ListTile(
            title: Text(plan.name),
            subtitle: Text(
              '次數：${plan.goalCount}，開始：${DateFormat.yMMMd().format(plan.startDate)}',
            ),
            trailing: Text('${plan.reward.toStringAsFixed(0)} 元'),
            onTap: () => _goToDetail(plan: plan),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToDetail(),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) _goToAnalysis();
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '計畫',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: '分析',
          ),
        ],
      ),
    );
  }
}
