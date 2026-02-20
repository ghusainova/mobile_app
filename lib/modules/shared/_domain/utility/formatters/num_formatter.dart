import 'package:intl/intl.dart';

String formatNum(String? value, {bool addCurrencySign = false}) {
  final num = int.tryParse(value ?? '') ?? 0;
  final formattedPrice = NumberFormat('#,###').format(num).replaceAll(',', ' ');

  return '$formattedPrice ${addCurrencySign ? '₸' : ''}'.trim();
}
