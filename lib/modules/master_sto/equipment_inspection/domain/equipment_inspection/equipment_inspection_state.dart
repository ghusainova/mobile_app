part of 'equipment_inspection_bloc.dart';

@freezed
class EquipmentInspectionState with _$EquipmentInspectionState {
  const factory EquipmentInspectionState.loading() = Loading;
  const factory EquipmentInspectionState.loaded({
    required EquipmentInspection equipmentInspection,
  }) = Loaded;
  const factory EquipmentInspectionState.saved() = Saved;
  const factory EquipmentInspectionState.error(String? message) = Error;
}
