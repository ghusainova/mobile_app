part of 'equipment_inspection_bloc.dart';

@freezed
class EquipmentInspectionEvent with _$EquipmentInspectionEvent {
  const factory EquipmentInspectionEvent.load({
    required String type,
  }) = Load;
  const factory EquipmentInspectionEvent.save({
    required EquipmentInspection body,
    String? stageName,
  }) = Save;
}
