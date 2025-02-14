import 'package:flutter/material.dart';
import '../models/currency_model.dart';
import 'package:intl/intl.dart';

class CryptoCard extends StatelessWidget {
  final CurrencyModel currency;

  const CryptoCard({super.key, required this.currency});

  @override
  Widget build(BuildContext context) {
    final tryFormatter = NumberFormat('#,##0.00', 'tr_TR');
    final usdFormatter = NumberFormat('#,##0.00', 'en_US');

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
                  Container(
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
                    child: Text(
                      '${tryFormatter.format(currency.change)}%',
                      style: TextStyle(
                        color: currency.change >= 0
                            ? const Color(0xFF00FF66)
                            : Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
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
              Text(
                '₺${tryFormatter.format(currency.tryPrice ?? 0)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '\$${usdFormatter.format(currency.usdPrice ?? 0)}',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
