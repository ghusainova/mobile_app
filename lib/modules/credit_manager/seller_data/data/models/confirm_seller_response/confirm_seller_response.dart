import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_result.dart';
part 'generated/confirm_seller_response.freezed.dart';
part 'generated/confirm_seller_response.g.dart';

@freezed
class ConfirmSellerResponse with _$ConfirmSellerResponse {
  const factory ConfirmSellerResponse({
    ConfirmSellerResult? result,
  }) = _ConfirmSellerResponse;

  factory ConfirmSellerResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfirmSellerResponseFromJson(json);
}
