import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/finance_provider.dart';
import '../widgets/currency_list.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FinanceProvider>().fetchData();
    });
  }

  Widget _buildLogo(bool isDarkMode) {
    try {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        height: 40,
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
      backgroundColor: theme.colorScheme.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    theme.colorScheme.primary.withOpacity(0.1),
                    theme.colorScheme.background,
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Container(
                  height: 120,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: _buildLogo(isDarkMode),
                      ),
                      TabBar(
                        controller: _tabController,
                        labelColor: theme.colorScheme.primary,
                        unselectedLabelColor:
                            theme.colorScheme.onSurface.withOpacity(0.6),
                        indicatorColor: theme.colorScheme.primary,
                        indicatorWeight: 3,
                        tabs: const [
                          Tab(text: 'Döviz'),
                          Tab(text: 'Altın'),
                          Tab(text: 'Kripto'),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      CurrencyList(type: 'currency'),
                      CurrencyList(type: 'gold'),
                      CurrencyList(type: 'crypto'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
