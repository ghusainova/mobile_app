part of 'brand_model_request_body.dart';

@freezed
class AutoBrandModel with _$AutoBrandModel {
  const AutoBrandModel._();

  const factory AutoBrandModel({
    required String brand,
    required String model,
    required String bodyNumber,
  }) = _AutoBrandModel;

  factory AutoBrandModel.fromJson(Map<String, dynamic> json) =>
      _$AutoBrandModelFromJson(json);

  bool get isEmpty {
    final items = [brand, model, bodyNumber];

    if (items.any((value) => value.isEmpty)) return true;

    return false;
  }
}
