import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/main_info.freezed.dart';
part 'generated/main_info.g.dart';

@freezed
class MainInfo with _$MainInfo {
  factory MainInfo({
    @Default('') String brand,
    @Default('') String model,
    @Default('') String year,
    @Default('') String stateNumber,
    @Default('') String vin,
    @Default('') String bodyNumber,
    @Default('') String mileage,
  }) = _MainInfo;

  factory MainInfo.fromJson(Map<String, dynamic> json) =>
      _$MainInfoFromJson(json);
}
