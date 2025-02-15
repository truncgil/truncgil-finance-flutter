import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/finance_provider.dart';
import '../constants/app_constants.dart';
import 'currency_card.dart';
import 'crypto_card.dart';
import 'search_bar.dart';

class CurrencyList extends StatelessWidget {
  final String type;
  final ScrollController scrollController;
  final double headerOpacity;

  const CurrencyList({
    super.key,
    required this.type,
    required this.scrollController,
    required this.headerOpacity,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FinanceProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final items = type == 'currency'
            ? provider.currencies
            : type == 'gold'
                ? provider.gold
                : provider.crypto;

        return Container(
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Column(
            children: [
              const CustomSearchBar(),
              Expanded(
                child: RefreshIndicator(
                  color: const Color(0xFF00FF66),
                  onRefresh: () async {
                    await context.read<FinanceProvider>().fetchData();
                  },
                  child: items.isEmpty
                      ? const Center(
                          child: Text(
                            'Sonuç bulunamadı',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : ListView.builder(
                          controller: scrollController,
                          physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics(),
                          ),
                          padding: EdgeInsets.only(
                            left: 8,
                            right: 8,
                            top: 0,
                            bottom: MediaQuery.of(context).padding.bottom + 16,
                          ),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: item.change >= 0
                                      ? const Color(0xFF00FF66)
                                      : Colors.red,
                                  width: 1,
                                ),
                              ),
                              child: item.type == 'CryptoCurrency'
                                  ? CryptoCard(currency: item)
                                  : CurrencyCard(currency: item),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
