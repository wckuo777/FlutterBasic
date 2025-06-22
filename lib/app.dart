import 'package:flutter/material.dart';
import 'package:plans_record_flt/features/main/main_scaffold.dart';

import 'features/login/presentation/login.dart';
import 'features/plans/presentation/plan_detail_page.dart';
import 'features/analysis/presentation/analysis_page.dart'; // 預留頁面

class MyPlansApp extends StatelessWidget {
  const MyPlansApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPlansApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/main': (context) => const MainScaffold(),
        '/detail': (context) => const PlanDetailPage(),
        '/analysis': (context) => const AnalysisPage(),
      },
    );
  }
}
