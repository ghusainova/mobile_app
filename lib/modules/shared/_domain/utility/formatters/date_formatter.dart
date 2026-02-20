import 'package:intl/intl.dart';

formatDate(String stringDate) {
  final dateFormat = DateTime.parse(stringDate);
  final DateFormat formatter = DateFormat('dd.MM.yyyy');
  return formatter.format(dateFormat);
}
