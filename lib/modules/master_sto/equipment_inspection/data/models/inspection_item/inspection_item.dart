import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'inspection_value/inspection_subvalue.dart';
import 'inspection_value/inspection_value.dart';

part 'generated/inspection_item.freezed.dart';
part 'generated/inspection_item.g.dart';

@freezed
class InspectionItem with _$InspectionItem {
  const InspectionItem._();

  const factory InspectionItem({
    @Default('') String name,
    @Default(false) bool multiSelect,
    @Default(false) bool attachPhoto,
    @Default(0) int order,
    @Default([]) List<InspectionValue> values,
  }) = _InspectionItem;

  List<InspectionValue> get sortedValues {
    final List<InspectionValue> sortedList = List.from(values);

    final uncheckOthersElement = values.indexWhere(
      (element) => element.uncheckOthers,
    );

    if (uncheckOthersElement < 0) {
      return values;
    }
    final item = sortedList.removeAt(uncheckOthersElement);
    sortedList.insert(0, item);
    return sortedList;
  }

  bool get hasEmptyFields =>
      !values.any((element) => element.selected && !element.hasEmptySubValues);

  bool get hasSubValues =>
      values.any((element) => element.subValues.isNotEmpty);

  bool get isCompressionCheck => name == 'Замер компрессии';

  bool get isPaintwork => values.any((element) => element.isPaintwork);

  bool get isSeatHeatingSelectionState => name.contains('Подогрев ');

  bool get isSeatHeatingItemWorkingState =>
      name.contains('Работоспособность подогрева');

  InspectionValue? get paintThicknessValue =>
      values.firstWhereOrNull((element) => element.isPaintwork);

  factory InspectionItem.fromJson(Map<String, dynamic> json) =>
      _$InspectionItemFromJson(json);

  factory InspectionItem.updateValuesSelection({
    required InspectionItem item,
    required InspectionValue value,
  }) {
    final updatedValues = item.values
        .map(
          (e) => e.name == value.name
              ? value.copyWith(
                  selected: e.isCompressionCheck || e.isPaintwork
                      ? true
                      : !value.selected,
                )
              : e,
        )
        .toList();

    return item.copyWith(values: updatedValues);
  }

  factory InspectionItem.updateSubValues({
    required InspectionItem item,
    required InspectionValue value,
    required List<InspectionSubvalue> updatedSubValues,
  }) {
    final updatedValues = item.values
        .map(
          (e) => e == value
              ? e.copyWith(selected: true, subValues: updatedSubValues)
              : e,
        )
        .toList();
    final updatedItem = item.copyWith(values: updatedValues);

    return updatedItem;
  }

  factory InspectionItem.uncheckAllValues(InspectionItem item) {
    final updatedValues = item.values
        .map(
          (e) => e.isCompressionCheck && e.isPaintwork
              ? e
              : e.copyWith(selected: false),
        )
        .toList();

    return item.copyWith(values: updatedValues);
  }

  factory InspectionItem.updateTireBrandSelection({
    required InspectionItem item,
    required InspectionValue value,
    required String brand,
  }) {
    final selectedSubValue = value.copyWith(
      selected: true,
      subValues: [
        InspectionSubvalue(name: brand, selected: true),
      ],
    );
    final updatedItem = item.copyWith(
        values: item.values
            .map((e) => e.name == value.name ? selectedSubValue : e)
            .toList(),);

    return updatedItem;
  }

  factory InspectionItem.updateTireSeasonSelection({
    required InspectionItem item,
    required InspectionValue value,
    required String season,
  }) {
    final updatedSubValues = value.subValues
        .map(
          (e) => e.name == season
              ? e.copyWith(selected: true)
              : e.copyWith(selected: false),
        )
        .toList();
    final updatedValues = item.values
        .map(
          (e) => e.name == value.name
              ? e.copyWith(selected: true, subValues: updatedSubValues)
              : e,
        )
        .toList();
    final updatedItem = item.copyWith(values: updatedValues);

    return updatedItem;
  }
}
