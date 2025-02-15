import 'package:flutter/material.dart';
import '../widgets/currency_list.dart';

class MarketScreen extends StatefulWidget {
  final int initialTabIndex;

  const MarketScreen({super.key, required this.initialTabIndex});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<ScrollController> _scrollControllers;
  double _headerOpacity = 1.0;
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    )..addListener(_handleTabChange);

    _scrollControllers = List.generate(
      3,
      (index) => ScrollController()..addListener(() => _scrollListener(index)),
    );
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      final currentOffset =
          _scrollControllers[_tabController.previousIndex].offset;
      if (_scrollControllers[_tabController.index].hasClients) {
        _scrollControllers[_tabController.index].jumpTo(currentOffset);
      }
    }
  }

  void _scrollListener(int index) {
    if (_isScrolling) return;
    _isScrolling = true;

    final currentController = _scrollControllers[index];
    final opacity = 1.0 - (currentController.offset / 100).clamp(0.0, 1.0);

    if (index == _tabController.index) {
      for (var i = 0; i < _scrollControllers.length; i++) {
        if (i != index && _scrollControllers[i].hasClients) {
          _scrollControllers[i].jumpTo(currentController.offset);
        }
      }
    }

    setState(() {
      _headerOpacity = opacity;
    });

    _isScrolling = false;
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    for (var controller in _scrollControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF004225),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Truncgil Finance',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withOpacity(0.6),
          indicatorColor: const Color(0xFF00FF66),
          indicatorWeight: 3,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          tabs: const [
            Tab(text: 'Para'),
            Tab(text: 'Altın'),
            Tab(text: 'Kripto'),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.5,
            colors: [
              const Color(0xFF00FF66).withOpacity(0.3),
              const Color(0xFF004225).withOpacity(0.1),
            ],
          ),
        ),
        child: TabBarView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            CurrencyList(
              type: 'currency',
              scrollController: _scrollControllers[0],
              headerOpacity: _headerOpacity,
            ),
            CurrencyList(
              type: 'gold',
              scrollController: _scrollControllers[1],
              headerOpacity: _headerOpacity,
            ),
            CurrencyList(
              type: 'crypto',
              scrollController: _scrollControllers[2],
              headerOpacity: _headerOpacity,
            ),
          ],
        ),
      ),
    );
  }
}
