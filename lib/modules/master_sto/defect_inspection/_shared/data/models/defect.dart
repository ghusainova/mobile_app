import 'package:freezed_annotation/freezed_annotation.dart';

import 'defect_item.dart';

part 'generated/defect.freezed.dart';
part 'generated/defect.g.dart';

@freezed
class Defect with _$Defect {
  const Defect._();

  const factory Defect({
    @Default('') String title,
    @Default([]) List<DefectItem> values,
  }) = _Defect;

  factory Defect.fromJson(Map<String, dynamic> json) => _$DefectFromJson(json);

  bool get isEmptyValues => values.any((element) => !element.status);
}
