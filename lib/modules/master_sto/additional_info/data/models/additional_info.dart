import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/additional_info.freezed.dart';
part 'generated/additional_info.g.dart';

@freezed
class AdditionalInfo with _$AdditionalInfo {
  const AdditionalInfo._();
  const factory AdditionalInfo({
    @Default('') String? engineType,
    @Default('') String? engine,
    @Default('') String? bodyType,
    @Default('') String? transmission,
    @Default('') String? drivetrain,
    @Default('') String? interiorType,
    @Default('') String? airConditioningType,
  }) = _AdditionalInfo;

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) =>
      _$AdditionalInfoFromJson(json);

  bool get isAnyFieldEmpty => [
        engineType,
        engine,
        bodyType,
        transmission,
        drivetrain,
        interiorType,
        airConditioningType,
      ].any(
        (field) => field?.isEmpty ?? true,
      );
}
