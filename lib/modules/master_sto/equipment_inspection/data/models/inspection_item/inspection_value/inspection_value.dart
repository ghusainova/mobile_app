import 'package:freezed_annotation/freezed_annotation.dart';

import 'inspection_subvalue.dart';

part 'generated/inspection_value.freezed.dart';
part 'generated/inspection_value.g.dart';

@freezed
class InspectionValue with _$InspectionValue {
  const InspectionValue._();

  const factory InspectionValue({
    @Default('') String name,
    @Default(false) bool dropdownSelection,
    @Default(false) bool uncheckOthers,
    @Default(false) bool selected,
    @JsonKey(fromJson: _subValuesFromJson)
    @Default([])
    List<InspectionSubvalue> subValues,
  }) = _InspectionValue;

  bool get hasEmptySubValues =>
      (isPaintwork || isCompressionCheck) &&
      (subValues.isEmpty || subValues.any((element) => !element.selected));

  bool get isPaintwork => name == 'ЛКП';

  bool get isCompressionCheck => name.contains('цилиндр');

  factory InspectionValue.fromJson(Map<String, dynamic> json) =>
      _$InspectionValueFromJson(json);
}

List<InspectionSubvalue> _subValuesFromJson(List<dynamic> jsonList) {
  final subValuesList = jsonList.map((e) => InspectionSubvalue.fromJson(e));
  final filteredList =
      subValuesList.where((element) => element.name.isNotEmpty).toList();

  return filteredList;
}
