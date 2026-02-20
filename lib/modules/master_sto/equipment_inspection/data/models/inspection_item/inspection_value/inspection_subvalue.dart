import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/inspection_subvalue.freezed.dart';
part 'generated/inspection_subvalue.g.dart';

@freezed
class InspectionSubvalue with _$InspectionSubvalue {
  const factory InspectionSubvalue({
    @Default('') String name,
    @Default(false) bool selected,
  }) = _InspectionSubvalue;

  factory InspectionSubvalue.fromJson(Map<String, dynamic> json) =>
      _$InspectionSubvalueFromJson(json);
}
