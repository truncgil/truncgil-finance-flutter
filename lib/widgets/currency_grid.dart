import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/finance_provider.dart';
import '../models/currency_model.dart';
import 'package:intl/intl.dart';

class CurrencyGrid extends StatelessWidget {
  const CurrencyGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final tryFormatter = NumberFormat('#,##0.00', 'tr_TR');
    final usdFormatter = NumberFormat('#,##0.00', 'en_US');

    return Consumer<FinanceProvider>(
      builder: (context, provider, child) {
        final featuredItems = [
          ...provider.currencies.take(3),
          ...provider.crypto.take(3),
        ];

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
              childAspectRatio: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 6, // Sabit sayıda öğe
            itemBuilder: (context, index) {
              final item = index < featuredItems.length
                  ? featuredItems[index]
                  : CurrencyModel(
                      type: 'Currency',
                      name: '',
                      code: '',
                      buying: '0',
                      selling: '0',
                      change: 0,
                    );

              final isPositive = item.change >= 0;
              final isCrypto = item.type == 'CryptoCurrency';

              String formattedValue = '';
              if (isCrypto) {
                formattedValue = '₺${tryFormatter.format(item.tryPrice ?? 0)}';
              } else {
                formattedValue =
                    '₺${tryFormatter.format(double.tryParse(item.buying) ?? 0)}';
              }

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isPositive ? const Color(0xFF00FF66) : Colors.red,
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.code,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Text(
                            '${tryFormatter.format(item.change)}%',
                            key: ValueKey(item.change),
                            style: TextStyle(
                              color: isPositive
                                  ? const Color(0xFF00FF66)
                                  : Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        formattedValue,
                        key: ValueKey(formattedValue),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
