import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/repositories/plan_repository.dart';
import '../data/models/plan_model.dart';

class PlanDetailPage extends StatefulWidget {
  const PlanDetailPage({super.key});

  @override
  State<PlanDetailPage> createState() => _PlanDetailPageState();
}

class _PlanDetailPageState extends State<PlanDetailPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _goalController = TextEditingController();
  final _rewardController = TextEditingController();
  DateTime _startDate = DateTime.now();
  String _frequency = '每日';

  Plan? _editingPlan;

 final planRepository = PlanRepository(); 

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)?.settings.arguments;
    if (arg is Plan) {
      _editingPlan = arg;
      _nameController.text = arg.name;
      _goalController.text = arg.goalCount.toString();
      _rewardController.text = arg.reward.toStringAsFixed(0);
      _startDate = arg.startDate;
      _frequency = arg.frequency;
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _startDate = picked);
    }
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final plan = (_editingPlan ?? Plan(
      id: UniqueKey().toString(),
      name: '',
      goalCount: 0,
      startDate: _startDate,
      frequency: '',
      reward: 0,
    )).copyWith(
      name: _nameController.text,
      goalCount: int.tryParse(_goalController.text) ?? 0,
      startDate: _startDate,
      frequency: _frequency,
      reward: double.tryParse(_rewardController.text) ?? 0,
    );

    if (_editingPlan != null) {
      planRepository.update(plan);
    } else {
      planRepository.add(plan);
    }

    Navigator.pop(context);
  }

  void _delete() {
    if (_editingPlan != null) {
      planRepository.delete(_editingPlan!.id);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editingPlan == null ? '新增計畫' : '編輯計畫'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: '名稱'),
                validator: (value) =>
                    value == null || value.isEmpty ? '請輸入名稱' : null,
              ),
              TextFormField(
                controller: _goalController,
                decoration: const InputDecoration(labelText: '目標次數'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? '請輸入次數' : null,
              ),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: '開始時間',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: _pickDate,
                  ),
                ),
                controller: TextEditingController(
                  text: DateFormat.yMMMd().format(_startDate),
                ),
              ),
              DropdownButtonFormField<String>(
                value: _frequency,
                decoration: const InputDecoration(labelText: '頻率'),
                items: ['每日', '每週', '每月']
                    .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                    .toList(),
                onChanged: (value) => setState(() => _frequency = value ?? '每日'),
              ),
              TextFormField(
                controller: _rewardController,
                decoration: const InputDecoration(labelText: '獎勵金額'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? '請輸入金額' : null,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _save,
                    icon: const Icon(Icons.save),
                    label: const Text('儲存'),
                  ),
                  if (_editingPlan != null)
                    OutlinedButton.icon(
                      onPressed: _delete,
                      icon: const Icon(Icons.delete),
                      label: const Text('刪除'),
                      style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
