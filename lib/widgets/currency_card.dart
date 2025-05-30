import 'package:flutter/material.dart';
import '../models/currency_model.dart';
import 'package:intl/intl.dart';

class CurrencyCard extends StatelessWidget {
  final CurrencyModel currency;

  const CurrencyCard({super.key, required this.currency});

  @override
  Widget build(BuildContext context) {
    final tryFormatter = NumberFormat('#,##0.00', 'tr_TR');
    final buyingValue = double.tryParse(currency.buying) ?? 0;
    final sellingValue = double.tryParse(currency.selling) ?? 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currency.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    currency.code,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: currency.change >= 0
                          ? const Color(0xFF00FF66).withOpacity(0.2)
                          : Colors.red.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        '${tryFormatter.format(currency.change)}%',
                        key: ValueKey(currency.change),
                        style: TextStyle(
                          color: currency.change >= 0
                              ? const Color(0xFF00FF66)
                              : Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  '₺${tryFormatter.format(buyingValue)}',
                  key: ValueKey(buyingValue),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  '₺${tryFormatter.format(sellingValue)}',
                  key: ValueKey(sellingValue),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
