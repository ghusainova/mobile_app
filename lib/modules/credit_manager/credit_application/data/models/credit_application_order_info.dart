import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'generated/credit_application_order_info.freezed.dart';
part 'generated/credit_application_order_info.g.dart';

@freezed
class CreditApplicationOrderInfo with _$CreditApplicationOrderInfo {
  const factory CreditApplicationOrderInfo({
    @Default(0) int id,
    @Default('') String externalId,
    @JsonKey(
      name: 'dateCr',
      fromJson: _formatDate,
    )
    @Default('')
    String creditExpDate,
  }) = _CreditApplicationOrderInfo;

  factory CreditApplicationOrderInfo.fromJson(Map<String, dynamic> json) =>
      _$CreditApplicationOrderInfoFromJson(json);
}

String _formatDate(String input) {
  if (input.isEmpty) return '';

  //credit application expiration date
  final formatter = DateFormat('dd MMMM', 'ru');
  final parsedDate = DateTime.parse(input).add(const Duration(days: 45));

  return formatter.format(parsedDate);
}
