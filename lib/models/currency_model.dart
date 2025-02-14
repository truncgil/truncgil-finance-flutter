class CurrencyModel {
  final String name;
  final double buying;
  final double selling;
  final double change;
  final String type;
  final double? usdPrice; // Kripto paralar için USD fiyatı
  final double? tryPrice; // Kripto paralar için TRY fiyatı

  CurrencyModel({
    required this.name,
    required this.buying,
    required this.selling,
    required this.change,
    required this.type,
    this.usdPrice,
    this.tryPrice,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json, String code) {
    final type = json['Type'] ?? '';

    if (type == 'CryptoCurrency') {
      return CurrencyModel(
        name: json['Name'] ?? code,
        buying: double.tryParse(json['TRY_Price'].toString()) ?? 0.0,
        selling: double.tryParse(json['Selling'].toString()) ?? 0.0,
        change: double.tryParse(json['Change'].toString()) ?? 0.0,
        type: type,
        usdPrice: double.tryParse(json['USD_Price'].toString()),
        tryPrice: double.tryParse(json['TRY_Price'].toString()),
      );
    }

    return CurrencyModel(
      name: json['Name'] ?? code,
      buying: double.tryParse(json['Buying'].toString()) ?? 0.0,
      selling: double.tryParse(json['Selling'].toString()) ?? 0.0,
      change: double.tryParse(json['Change'].toString()) ?? 0.0,
      type: type,
    );
  }
}
