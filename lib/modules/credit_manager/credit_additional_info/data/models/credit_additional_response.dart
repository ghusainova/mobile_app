import 'package:freezed_annotation/freezed_annotation.dart';

import 'credit_additional_info.dart';

part 'generated/credit_additional_response.freezed.dart';
part 'generated/credit_additional_response.g.dart';

@freezed
class CreditAdditionalResponse with _$CreditAdditionalResponse {
  const factory CreditAdditionalResponse({
    required CreditAdditionalInfo auto,
  }) = _CreditAdditionalResponse;

  factory CreditAdditionalResponse.fromJson(Map<String, dynamic> json) =>
      _$CreditAdditionalResponseFromJson(json);
}
