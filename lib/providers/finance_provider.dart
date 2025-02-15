import 'dart:convert';
import 'dart:async';
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
  int? _minutesAgo;

  FinanceProvider() {
    // Otomatik güncelleme kaldırıldı
  }


  List<CurrencyModel> get currencies => _filterItems(_currencies);
  List<CurrencyModel> get gold => _filterItems(_gold);
  List<CurrencyModel> get crypto => _filterItems(_crypto);
  bool get isLoading => _isLoading;
  String? get lastUpdate => _lastUpdate;
  int? get minutesAgo => _minutesAgo;

  String _formatDateTime(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd.MM.yyyy HH:mm').format(date);
    } catch (e) {
      debugPrint('Tarih formatı hatası: $e');
      return dateStr;
    }
  }

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
    if (_isLoading) return; // Zaten yükleniyorsa tekrar başlatma

    _isLoading = true;
    notifyListeners();

    try {
      final response = await http
          .get(Uri.parse('https://finance.truncgil.com/api/today.json'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Meta verilerini al
        if (data['Meta_Data'] != null) {
          final metaData = data['Meta_Data'];
          _lastUpdate = _formatDateTime(metaData['Update_Date'] ?? '');
          _minutesAgo = (metaData['Minutes_Ago'] as num?)?.round();

          if (_lastUpdate == null || _lastUpdate!.isEmpty) {
            throw Exception('Meta verisi alınamadı');
          }
        } else {
          throw Exception('Meta verisi bulunamadı');
        }

        final rates = data['Rates'] as Map<String, dynamic>;

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

        debugPrint('Veriler başarıyla güncellendi');
        debugPrint('Son güncelleme: $_lastUpdate');
        debugPrint('Dakika: $_minutesAgo');
      } else {
        throw Exception('Veri alınamadı: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Veri çekme hatası: $e');
      // Hata durumunda 3 saniye sonra tekrar deneyelim
      Future.delayed(const Duration(seconds: 3), () {
        if (_lastUpdate == null) {
          fetchData();
        }
      });
    }

    _isLoading = false;
    notifyListeners();
  }
}
