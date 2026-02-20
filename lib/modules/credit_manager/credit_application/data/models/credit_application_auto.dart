import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/credit_application_auto.freezed.dart';
part 'generated/credit_application_auto.g.dart';

@freezed
class CreditApplicationAuto with _$CreditApplicationAuto {
  //TODO: объединить с Auto
  const factory CreditApplicationAuto({
    required int id,
    @Default('') String brand,
    @Default('') String brandMVD,
    @Default('') String model,
    @Default('') String modelMVD,
    @Default('') String year,
    @Default('') String transmission,
    @Default('') String body,
    @Default('') String engineType,
    @Default('') String stateNumber,
    @Default('') String bodyNumber,
    @Default('') String vin,
    @Default(0) double price,
  }) = _CreditApplicationAuto;

  factory CreditApplicationAuto.fromJson(Map<String, dynamic> json) =>
      _$CreditApplicationAutoFromJson(json);
}
