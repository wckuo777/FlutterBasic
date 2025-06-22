import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/repositories/plan_repository.dart';
import '../data/models/plan_model.dart';

class HomePage extends StatefulWidget {
  final String searchQuery;
  final String filterOption;
  const HomePage({super.key, this.searchQuery = '', this.filterOption = '進行中'});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Plan> _plans = [];

  @override
  void initState() {
    super.initState();
    // _plans = planRepository.getAll();
    _loadPlans();
  }

  Future<void> _loadPlans() async {
    final list = await planRepository.getAll();
    setState(() => _plans = list);
  }

  void _goToDetail({Plan? plan}) async {
    await Navigator.pushNamed(context, '/detail', arguments: plan);
    // setState(() async {
    //   _plans = planRepository.getAll();
    // });
    await _loadPlans(); // 回來後重新讀資料
  }

  @override
  Widget build(BuildContext context) {
    // search part
    List<Plan> filteredPlans = _plans.where((plan) => plan.name.toLowerCase().contains(
            widget.searchQuery.toLowerCase(),
          ),
        ).toList();

    // filter part
    final now = DateTime.now();
    if (widget.filterOption == '進行中') {
      filteredPlans = filteredPlans.where((plan) {
        final end = plan.endDate ?? now;
        return now.isAfter(plan.startDate) &&
            now.isBefore(end.add(const Duration(days: 1)));
      }).toList();
    } else if (widget.filterOption == '過去') {
      filteredPlans = filteredPlans
          .where((plan) =>
              plan.endDate != null && plan.endDate!.isBefore(now))
          .toList();
    } else {
      // '全部' 
    }    
    Widget body;
    if (_plans.isEmpty) {
      body = const Center(child: Text('尚無計畫，請新增'));
    } else if (filteredPlans.isEmpty) {
      body = const Center(child: Text('沒有找到符合的計畫'));
    } else {
      body = ListView.builder(
        itemCount: filteredPlans.length,
        itemBuilder: (context, index) {
          final plan = filteredPlans[index];
          return ListTile(
            title: Text(plan.name),
            subtitle: Text(
              '次數：${plan.goalCount}，開始：${DateFormat.yMMMd().format(plan.startDate)}',
            ),
            trailing: Text('${plan.reward.toStringAsFixed(0)} 元'),
            onTap: () => _goToDetail(plan: plan),
          );
        },
      );
    }

    return Stack(
      children: [
        body,
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () => _goToDetail(),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
