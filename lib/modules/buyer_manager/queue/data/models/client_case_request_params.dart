import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/client_case_request_params.freezed.dart';
part 'generated/client_case_request_params.g.dart';

@freezed
class ClientCaseRequestParams with _$ClientCaseRequestParams {
  const factory ClientCaseRequestParams({
    String? link,
    @JsonKey(name: 'client-iin') String? clientIin,
    @JsonKey(name: 'seller-phone') String? sellerPhone,
  }) = _ClientCaseRequestParams;

  factory ClientCaseRequestParams.fromJson(Map<String, dynamic> json) =>
      _$ClientCaseRequestParamsFromJson(json);
}
