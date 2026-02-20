import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PriceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else {
      return TextEditingValue(text: formatPriceText(newValue.text));
    }
  }
}

String formatPriceText(String? text) {
  if ((text ?? '').isEmpty) {
    return '';
  }

  final formatter = NumberFormat('#,###', 'ru_RU');
  final price =
      int.tryParse(text!.replaceAll(formatter.symbols.GROUP_SEP, '')) ?? 0;
  return formatter.format(price);
}

String removePriceSeparators(String? text) {
  if ((text ?? '').isEmpty) {
    return '';
  }

  return text!.replaceAll(RegExp(r'\s+'), '');
}
