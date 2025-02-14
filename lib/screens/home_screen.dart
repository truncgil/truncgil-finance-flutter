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
      return SvgPicture.asset(
        isDarkMode
            ? 'assets/images/logo-dark.svg'
            : 'assets/images/logo-light.svg',
        height: 32,
        colorFilter: ColorFilter.mode(
          isDarkMode ? Colors.white : Colors.black,
          BlendMode.srcIn,
        ),
        placeholderBuilder: (BuildContext context) => Container(
          padding: const EdgeInsets.all(8.0),
          child: const CircularProgressIndicator(),
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
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        title: _buildLogo(isDarkMode),
        centerTitle: true,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: theme.colorScheme.onSurface,
          unselectedLabelColor: theme.colorScheme.onSurface.withOpacity(0.6),
          tabs: const [
            Tab(text: 'Döviz'),
            Tab(text: 'Altın'),
            Tab(text: 'Kripto'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          CurrencyList(type: 'currency'),
          CurrencyList(type: 'gold'),
          CurrencyList(type: 'crypto'),
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
