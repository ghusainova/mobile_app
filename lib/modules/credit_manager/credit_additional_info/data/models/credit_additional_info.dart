import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/credit_additional_info.freezed.dart';
part 'generated/credit_additional_info.g.dart';

@freezed
class CreditAdditionalInfo with _$CreditAdditionalInfo {
  const CreditAdditionalInfo._();
  const factory CreditAdditionalInfo({
    @Default('') String? engineType,
    @Default('') String? engine,
    @Default('') String? bodyType,
    @Default('') String? color,
    @Default('') String? transmission,
    @Default('') String? drivetrain,
    @Default('') String? wheel,
    @Default('') String? interiorType,
    @Default('') String? airConditioningType,
    @Default('') String? boxNumber,
  }) = _CreditAdditionalInfo;

  factory CreditAdditionalInfo.fromJson(Map<String, dynamic> json) =>
      _$CreditAdditionalInfoFromJson(json);

  bool get isAnyFieldEmpty => [
        engineType,
        engine,
        bodyType,
        color,
        transmission,
        drivetrain,
        wheel,
        interiorType,
        airConditioningType,
        boxNumber,
      ].any(
        (field) {
          return field?.isEmpty ?? true;
        },
      );
}
