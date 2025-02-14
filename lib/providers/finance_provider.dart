import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/currency_model.dart';

class FinanceProvider with ChangeNotifier {
  List<CurrencyModel> _currencies = [];
  List<CurrencyModel> _gold = [];
  List<CurrencyModel> _crypto = [];
  bool _isLoading = false;
  DateTime? _lastUpdate;
  String _searchQuery = '';

  List<CurrencyModel> get currencies => _filterItems(_currencies);
  List<CurrencyModel> get gold => _filterItems(_gold);
  List<CurrencyModel> get crypto => _filterItems(_crypto);
  bool get isLoading => _isLoading;
  DateTime? get lastUpdate => _lastUpdate;
  String get searchQuery => _searchQuery;

  void setSearchQuery(String query) {
    _searchQuery = query.toLowerCase();
    notifyListeners();
  }

  List<CurrencyModel> _filterItems(List<CurrencyModel> items) {
    if (_searchQuery.isEmpty) return items;
    return items
        .where((item) =>
            item.name.toLowerCase().contains(_searchQuery) ||
            (item.type == 'CryptoCurrency' &&
                item.usdPrice.toString().contains(_searchQuery)))
        .toList();
  }

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http
          .get(Uri.parse('https://finance.truncgil.com/api/today.json'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['Meta_Data'] != null) {
          _lastUpdate = DateTime.tryParse(data['Meta_Data']['Update_Date']);
        }

        if (data['Rates'] != null) {
          _currencies = [];
          _gold = [];
          _crypto = [];

          data['Rates'].forEach((key, value) {
            if (value is Map<String, dynamic>) {
              final type = value['Type'] ?? '';
              if (type.isNotEmpty) {
                final item = CurrencyModel.fromJson(value, key);
                switch (item.type) {
                  case 'Currency':
                    _currencies.add(item);
                    break;
                  case 'Gold':
                    _gold.add(item);
                    break;
                  case 'CryptoCurrency':
                    _crypto.add(item);
                    break;
                }
              }
            }
          });

          // Kripto paraları değişim oranına göre sırala
          _crypto.sort((a, b) => b.change.compareTo(a.change));
        }
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
