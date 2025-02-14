class CurrencyModel {
  final String type;
  final String name;
  final String buying;
  final String selling;
  final double change;
  final String code;
  final double? tryPrice;
  final double? usdPrice;

  CurrencyModel({
    required this.type,
    required this.name,
    required this.buying,
    required this.selling,
    required this.change,
    required this.code,
    this.tryPrice,
    this.usdPrice,
  });

  String get value =>
      type == 'CryptoCurrency' ? (tryPrice?.toString() ?? '0') : buying;

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    final type = json['type'] ?? '';

    if (type == 'CryptoCurrency') {
      return CurrencyModel(
        type: type,
        name: json['name'] ?? '',
        code: json['code'] ?? '',
        buying: json['buying'] ?? '',
        selling: json['selling'] ?? '',
        change: double.tryParse(json['change']?.toString() ?? '0') ?? 0,
        tryPrice: double.tryParse(json['TRY_Price']?.toString() ?? '0'),
        usdPrice: double.tryParse(json['USD_Price']?.toString() ?? '0'),
      );
    }

    return CurrencyModel(
      type: type,
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      buying: json['buying'] ?? '',
      selling: json['selling'] ?? '',
      change: double.tryParse(json['change']?.toString() ?? '0') ?? 0,
    );
  }
}
