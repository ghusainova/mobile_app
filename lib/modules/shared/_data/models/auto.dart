import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/auto.freezed.dart';
part 'generated/auto.g.dart';

@freezed
class Auto with _$Auto {
  const factory Auto({
    @Default('') String brand,
    @Default('') String model,
    @Default(0) int year,
    @Default('') String engine,
    @Default('') String engineType,
    @Default('') String color,
    @Default(0) int mileage,
    @Default('') String transmission,
    @Default('') String bodyType,
    @Default('') String drivetrain,
    @Default('') String bodyNumber,
    @Default('') String vin,
    @Default('') String stateNumber,
    @Default('') String generation,
    @Default('') String interiorType,
    @Default('') String airConditioningType,
    @Default('') String mainPhotoLink,
  }) = _Auto;

  factory Auto.fromJson(Map<String, dynamic> json) => _$AutoFromJson(json);
}
