part of 'confirm_seller_response.dart';

@freezed
class ConfirmSellerResult with _$ConfirmSellerResult {
  const factory ConfirmSellerResult({
    String? message,
  }) = _ConfirmSellerResult;

  factory ConfirmSellerResult.fromJson(Map<String, dynamic> json) =>
      _$ConfirmSellerResultFromJson(json);
}
