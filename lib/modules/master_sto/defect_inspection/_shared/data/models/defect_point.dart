import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/defect_point.freezed.dart';
part 'generated/defect_point.g.dart';

@freezed
class DefectPoint with _$DefectPoint {
  const factory DefectPoint({
    int? measuringPoint,
    int? micrometer,
  }) = _DefectPoint;

  factory DefectPoint.fromJson(Map<String, dynamic> json) =>
      _$DefectPointFromJson(json);
}
