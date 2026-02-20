import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/defects.freezed.dart';
part 'generated/defects.g.dart';

@freezed
class TempDefectModel with _$TempDefectModel {
  const factory TempDefectModel({
    @Default('') String micrometer,
    @Default('') String title,
    @Default('') String defects,
    @Default(false) bool isDefect,
  }) = _TempDefectModel;

  factory TempDefectModel.fromJson(Map<String, dynamic> json) =>
      _$TempDefectModelFromJson(json);
}
