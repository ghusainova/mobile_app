import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/_helpers/items_to_exclude_validation.dart';
import '../enum/inspection_item_enum.dart';
import 'inspection_item/inspection_item.dart';

part 'generated/equipment_inspection.freezed.dart';
part 'generated/equipment_inspection.g.dart';

@freezed
class EquipmentInspection with _$EquipmentInspection {
  const EquipmentInspection._();

  const factory EquipmentInspection({
    @Default('') String name,
    @Default(false) bool hasSubValue,
    @Default([]) List<InspectionItem> equipments,
  }) = _EquipmentInspection;

  bool get hasEmptyFields => equipments
      //exclude from validation logic
      .where((item) => checkItemToExclude(item.name))
      .any((element) => element.hasEmptyFields);

  bool get hasEmptyPaintwork => equipments.any((element) =>
      element.isPaintwork && !(element.paintThicknessValue?.selected ?? false),);

  bool get hasSeatsHeating =>
      equipments
          .firstWhereOrNull((element) => element.name.contains('Подогрев '))
          ?.values
          .firstWhereOrNull((el) => el.name == 'Да')
          ?.selected ??
      false;

  bool get _isComputerDiagnostics =>
      name == InspectionItemEnum.computerDiagnostics.type;

  int get imageUploadValidationCount => _isComputerDiagnostics
      ? 1
      : equipments
          .where((item) =>
              item.attachPhoto &&
              !item.values
                  .any((value) => value.selected && value.uncheckOthers),)
          .length;

  factory EquipmentInspection.fromJson(Map<String, dynamic> json) =>
      _$EquipmentInspectionFromJson(json);

  factory EquipmentInspection.updateItems(
    EquipmentInspection inspection,
    int index,
    InspectionItem item,
  ) {
    final updatedItems = inspection.equipments
        .map((e) => e == inspection.equipments[index] ? item : e)
        .toList();
    final updatedEquipment = inspection.copyWith(
      equipments: updatedItems,
      hasSubValue: updatedItems.any((element) => element.hasSubValues),
    );

    return updatedEquipment;
  }

  factory EquipmentInspection.uncheckAllValues(
    EquipmentInspection inspection,
  ) {
    final updatedEquipments = inspection.equipments
        .map((e) => InspectionItem.uncheckAllValues(e))
        .toList();
    final updatedInspection =
        inspection.copyWith(equipments: updatedEquipments);

    return updatedInspection;
  }

  factory EquipmentInspection.setEqualItems(
    EquipmentInspection inspection,
    InspectionItem item,
  ) {
    final updatedItems = inspection.equipments
        .map((e) => e.copyWith(values: item.values))
        .toList();

    return inspection.copyWith(equipments: updatedItems);
  }

  factory EquipmentInspection.uncheckSeatHeatingValues(
    EquipmentInspection inspection,
  ) {
    final updatedItems = inspection.equipments
        .map(
          (e) => e.isSeatHeatingItemWorkingState
              ? InspectionItem.uncheckAllValues(e)
              : e,
        )
        .toList();

    return inspection.copyWith(equipments: updatedItems);
  }
}
