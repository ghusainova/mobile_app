import 'package:freezed_annotation/freezed_annotation.dart';

part 'auto_brand_model.dart';
part 'generated/brand_model_request_body.freezed.dart';
part 'generated/brand_model_request_body.g.dart';

@freezed
class BrandModelRequestBody with _$BrandModelRequestBody {
  const factory BrandModelRequestBody(
    AutoBrandModel auto,
  ) = _BrandModelRequestBody;

  factory BrandModelRequestBody.fromJson(Map<String, dynamic> json) =>
      _$BrandModelRequestBodyFromJson(json);
}
