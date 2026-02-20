import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/brand_model_response.freezed.dart';
part 'generated/brand_model_response.g.dart';

@freezed
class BrandModelResponse with _$BrandModelResponse {
  const BrandModelResponse._();

  const factory BrandModelResponse({
    @Default('') String brand,
    @Default('') String model,
    @Default([]) List<String> modelList,
  }) = _BrandModelResponse;

  bool get isSingleResponseNotEmpty => brand.isNotEmpty && model.isNotEmpty;
  bool get isMultiResponseNotEmpty => brand.isNotEmpty && modelList.isNotEmpty;

  factory BrandModelResponse.fromJson(Map<String, dynamic> json) =>
      _$BrandModelResponseFromJson(json);
}
