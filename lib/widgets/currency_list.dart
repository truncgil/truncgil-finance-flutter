import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/finance_provider.dart';
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
        final items = type == 'currency'
            ? provider.currencies
            : type == 'gold'
                ? provider.gold
                : provider.crypto;

        return SingleChildScrollView(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: Container(
            margin: EdgeInsets.zero,
            child: Column(
              children: [
                const CustomSearchBar(),
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 8,
                    bottom: MediaQuery.of(context).padding.bottom + 200,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
