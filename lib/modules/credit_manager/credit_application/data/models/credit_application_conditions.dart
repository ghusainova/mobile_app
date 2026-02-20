import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/credit_application_conditions.g.dart';
part 'generated/credit_application_conditions.freezed.dart';

@freezed
class CreditApplicationConditions with _$CreditApplicationConditions {
  const factory CreditApplicationConditions({
    @Default(0) int id,
    @Default('') String dayPay,
    @Default(0) int overPaid,
    @Default(0) double initialFee,
    @JsonKey(fromJson: _fromStringToDouble) @Default(0) double ratePrc,
    @JsonKey(fromJson: _fromStringToDouble) @Default(0) double summaCred,
    @JsonKey(fromJson: _fromStringToInt) @Default(0) int termCred,
  }) = _CreditApplicationConditions;

  factory CreditApplicationConditions.fromJson(Map<String, dynamic> json) =>
      _$CreditApplicationConditionsFromJson(json);
}

int _fromStringToInt(String value) => int.tryParse(value) ?? 0;

double _fromStringToDouble(String value) => double.tryParse(value) ?? 0;
