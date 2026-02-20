import 'package:freezed_annotation/freezed_annotation.dart';

import 'defect.dart';
import 'defect_point.dart';

part 'generated/defect_model.freezed.dart';
part 'generated/defect_model.g.dart';

@freezed
class DefectModel with _$DefectModel {
  const DefectModel._();

  const factory DefectModel({
    @Default('') String bodyPart,
    @Default('') String maxMicrometer,
    @Default('') String averagePaintThickness,
    @Default(false) bool recolouring,
    @Default(false) bool hasDefect,
    @Default([]) List<Defect>? defects,
    @Default([]) List<DefectPoint>? points,
  }) = _Defect;

  factory DefectModel.fromJson(Map<String, dynamic> json) =>
      _$DefectModelFromJson(json);

  factory DefectModel.updateDefects({
    required List<Defect> defects,
    required DefectModel defectModel,
  }) {
    final updatedDefectModel = defectModel.copyWith(defects: defects);
    return updatedDefectModel;
  }

  factory DefectModel.resetDefectStatus(DefectModel defectModel) {
    final updatedDefects = defectModel.defects?.map((defect) {
      final updatedValues = defect.values.map((value) {
        return value.copyWith(status: false);
      }).toList();

      return defect.copyWith(values: updatedValues);
    }).toList();

    return defectModel.copyWith(defects: updatedDefects);
  }

  bool? get isDefectListEmpty =>
      defects?.every((defect) => defect.values.every((value) => !value.status));
}
