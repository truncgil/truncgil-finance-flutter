import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/finance_provider.dart';
import 'currency_card.dart';
import 'crypto_card.dart';
import 'search_bar.dart';

class CurrencyList extends StatelessWidget {
  final String type;

  const CurrencyList({super.key, required this.type});

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
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.95),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: Column(
              children: [
                const CustomSearchBar(),
                Expanded(
                  child: RefreshIndicator(
                    color: Theme.of(context).colorScheme.primary,
                    onRefresh: () => provider.fetchData(),
                    child: items.isEmpty
                        ? const Center(
                            child: Text('Sonuç bulunamadı'),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              final item = items[index];
                              return item.type == 'CryptoCurrency'
                                  ? CryptoCard(currency: item)
                                  : CurrencyCard(currency: item);
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
