import 'package:flutter/material.dart';
import 'package:plans_record_flt/core/widgets/filter_menu_button.dart';
import '../plans/presentation/home_page.dart';
import '../analysis/presentation/analysis_page.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';
  String _filterOption = '進行中';
  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.add(
      HomePage(searchQuery: _searchQuery, filterOption: _filterOption),
    );
    _pages.add(const AnalysisPage());
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
      _searchQuery = '';
    });
  }

  void _updateSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    _pages[0] = HomePage(
      searchQuery: _searchQuery,
      filterOption: _filterOption,
    );
    return Scaffold(
      appBar: AppBar(
        title: _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: '計畫'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: '分析'),
        ],
      ),
    );
  }

  // AppBar title：依搜尋狀態切換
  Widget _buildAppBarTitle() {
    if (_isSearching) {
      return TextField(
        controller: _searchController,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: '輸入計畫名稱',
          border: InputBorder.none,
        ),
        onChanged: _updateSearch,
      );
    } else {
      return const Text('MyPlansApp');
    }
  }

  // AppBar actions
  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(icon: const Icon(Icons.clear), onPressed: _stopSearch),
      ];
    } else {
      return [
        FilterMenuButton(
        currentValue: _filterOption,
        options: const ['過去', '進行中', '全部'],
        onSelected: (value) {
          setState(() {
            _filterOption = value;
          });
        },
      ),
        // IconButton(
        //   icon: const Icon(Icons.filter_list),
        //   onPressed: () async {
        //     final renderBox = context.findRenderObject() as RenderBox;
        //     final overlay =
        //         Overlay.of(context).context.findRenderObject() as RenderBox;
        //     final position = renderBox.localToGlobal(
        //       Offset.zero,
        //       ancestor: overlay,
        //     );
        //     _showFilterMenu(
        //       context,
        //       position.translate(0, renderBox.size.height),
        //     );
        //   },
        // ),
        IconButton(icon: const Icon(Icons.search), onPressed: _startSearch),
        // IconButton(
        //   icon: const Icon(Icons.brightness_6),
        //   onPressed: () {
        //     // 先保留，未實作
        //   },
        // ),
      ];
    }
  }

  // void _showFilterMenu(BuildContext context, Offset offset) async {
  //   final selected = await showMenu<String>(
  //     context: context,
  //     position: RelativeRect.fromLTRB(offset.dx, offset.dy, offset.dx, 0),
  //     items: [
  //       const PopupMenuItem(value: '過去', child: Text('過去')),
  //       const PopupMenuItem(value: '進行中', child: Text('進行中')),
  //       const PopupMenuItem(value: '全部', child: Text('全部')),
  //     ],
  //   );

  //   if (selected != null) {
  //     setState(() {
  //       _filterOption = selected;
  //     });
  //   }
  // }
}
