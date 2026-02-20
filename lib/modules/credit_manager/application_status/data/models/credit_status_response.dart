import 'package:freezed_annotation/freezed_annotation.dart';

import 'credit_status_item.dart';

part 'generated/credit_status_response.freezed.dart';
part 'generated/credit_status_response.g.dart';

@freezed
class CreditStatusResponse with _$CreditStatusResponse {
  const factory CreditStatusResponse({
    @Default([]) List<CreditStatusItem> status,
  }) = _CreditStatusResponse;

  factory CreditStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$CreditStatusResponseFromJson(json);
}
