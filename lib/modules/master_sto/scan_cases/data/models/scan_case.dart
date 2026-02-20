import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/scan_case.freezed.dart';
part 'generated/scan_case.g.dart';

@freezed
class ScanCase with _$ScanCase {
  factory ScanCase({
    @Default('') String caseId,
    @Default('') String brand,
    @Default('') String model,
    @Default('') String clientName,
    @Default('') String stateNumber,
    @Default('') String status,
    @Default(false) bool isParking,
  }) = _ScanScanCase;

  factory ScanCase.fromJson(Map<String, dynamic> json) =>
      _$ScanCaseFromJson(json);
}
