import 'package:flutter/material.dart';

class ScaffoldWithNav extends StatelessWidget {
  final Widget body;
  final int currentIndex;

  const ScaffoldWithNav({
    super.key,
    required this.body,
    this.currentIndex = 0,
  });

  void _onTapNav(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/analysis');
        break;
    }
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
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _onTapNav(context, index),
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
