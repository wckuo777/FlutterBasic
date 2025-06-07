import 'package:flutter/material.dart';

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('分析頁'),
      ),
      body: const Center(
        child: Text(
          'analysis_page is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
