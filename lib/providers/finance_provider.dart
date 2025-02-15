import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/currency_model.dart';
import 'package:intl/intl.dart';

class FinanceProvider extends ChangeNotifier {
  List<CurrencyModel> _currencies = [];
  List<CurrencyModel> _gold = [];
  List<CurrencyModel> _crypto = [];
  bool _isLoading = false;
  String _searchQuery = '';
  String? _lastUpdate;

  List<CurrencyModel> get currencies => _filterItems(_currencies);
  List<CurrencyModel> get gold => _filterItems(_gold);
  List<CurrencyModel> get crypto => _filterItems(_crypto);
  bool get isLoading => _isLoading;
  String? get lastUpdate => _lastUpdate;

  List<CurrencyModel> _filterItems(List<CurrencyModel> items) {
    if (_searchQuery.isEmpty) return items;
    return items
        .where((item) =>
            item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            item.code.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http
          .get(Uri.parse('https://finance.truncgil.com/api/today.json'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final rates = data['Rates'] as Map<String, dynamic>;

        // Son güncelleme tarihini ayarla
        final now = DateTime.now();
        _lastUpdate = DateFormat('dd.MM.yyyy HH:mm').format(now);

        // Para birimleri
        _currencies = rates.entries
            .where((entry) => entry.value['Type'] == 'Currency')
            .map((entry) {
          final item = entry.value;
          return CurrencyModel(
            type: 'Currency',
            name: item['Name'] ?? entry.key,
            code: entry.key,
            buying: item['Buying']?.toString() ?? '0',
            selling: item['Selling']?.toString() ?? '0',
            change: double.tryParse(item['Change']?.toString() ?? '0') ?? 0,
          );
        }).toList();

        // Altın
        _gold = rates.entries
            .where((entry) => entry.value['Type'] == 'Gold')
            .map((entry) {
          final item = entry.value;
          return CurrencyModel(
            type: 'Gold',
            name: item['Name'] ?? entry.key,
            code: entry.key,
            buying: item['Buying']?.toString() ?? '0',
            selling: item['Selling']?.toString() ?? '0',
            change: double.tryParse(item['Change']?.toString() ?? '0') ?? 0,
          );
        }).toList();

        // Kripto
        _crypto = rates.entries
            .where((entry) => entry.value['Type'] == 'CryptoCurrency')
            .map((entry) {
          final item = entry.value;
          return CurrencyModel(
            type: 'CryptoCurrency',
            name: item['Name'] ?? entry.key,
            code: entry.key,
            buying: item['TRY_Price']?.toString() ?? '0',
            selling: item['TRY_Price']?.toString() ?? '0',
            change: double.tryParse(item['Change']?.toString() ?? '0') ?? 0,
            tryPrice: double.tryParse(item['TRY_Price']?.toString() ?? '0'),
            usdPrice: double.tryParse(item['USD_Price']?.toString() ?? '0'),
          );
        }).toList();

        debugPrint('Currencies: ${_currencies.length}');
        debugPrint('Gold: ${_gold.length}');
        debugPrint('Crypto: ${_crypto.length}');
      }
    } catch (e) {
      debugPrint('Veri çekme hatası: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
