import 'package:freezed_annotation/freezed_annotation.dart';

import 'credit_rework_page_item.dart';

part 'generated/credit_rework_response.freezed.dart';
part 'generated/credit_rework_response.g.dart';

@freezed
class CreditReworkResponse with _$CreditReworkResponse {
  const factory CreditReworkResponse({
    @Default([]) List<CreditReworkPageItem>? verificationData,
  }) = _CreditReworkResponse;

  factory CreditReworkResponse.fromJson(Map<String, dynamic> json) =>
      _$CreditReworkResponseFromJson(json);
}
