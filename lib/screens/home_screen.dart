import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/finance_provider.dart';
import '../widgets/currency_list.dart';
import '../widgets/currency_grid.dart';
import '../constants/app_constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<ScrollController> _scrollControllers;
  double _headerOpacity = 1.0;
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(_handleTabChange);

    _scrollControllers = List.generate(
      3,
      (index) => ScrollController()..addListener(() => _scrollListener(index)),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FinanceProvider>().fetchData();
    });
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
    final opacity = 1.0 -
        (currentController.offset / (AppConstants.getScrollOffset(context) / 3))
            .clamp(0.0, 1.0);

    // Sadece aktif tab scroll edildiğinde diğerlerini güncelle
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

  Widget _buildLogo(bool isDarkMode) {
    try {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        height: 100,
        child: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.contain,
        ),
      );
    } catch (e) {
      debugPrint('Logo yükleme hatası: $e');
      return const Text('Truncgil Finance');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF004225),
      body: Stack(
        children: [
          Container(
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
          ),
          SafeArea(
            child: Column(
              children: [
                AnimatedOpacity(
                  opacity: _headerOpacity,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: _buildLogo(isDarkMode),
                        ),
                        const CurrencyGrid(),
                      ],
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  transform: Matrix4.translationValues(
                    0,
                    -AppConstants.getScrollOffset(context) *
                        (1 - _headerOpacity),
                    0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: const Border(
                        bottom: BorderSide(
                          color: Color(0xFF00FF66),
                          width: 1,
                        ),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(0.1),
                        ],
                      ),
                    ),
                    child: TabBar(
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
                        Tab(text: 'Döviz'),
                        Tab(text: 'Altın'),
                        Tab(text: 'Kripto'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    transform: Matrix4.translationValues(
                      0,
                      -AppConstants.getScrollOffset(context) *
                          (1 - _headerOpacity),
                      0,
                    ),
                    child: Container(
                      color: Colors.black87,
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 1,
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
