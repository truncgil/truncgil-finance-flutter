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

        return Column(
          children: [
            const CustomSearchBar(),
            Expanded(
              child: RefreshIndicator(
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
        );
      },
    );
  }
}
