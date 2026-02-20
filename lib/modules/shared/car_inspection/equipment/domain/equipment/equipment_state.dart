part of 'equipment_bloc.dart';

@freezed
class EquipmentState with _$EquipmentState {
  const factory EquipmentState.loading() = Loading;
  const factory EquipmentState.hasContent({
    required Map<String, List<Equipment>>? equipment,
  }) = HasContent;
  const factory EquipmentState.error(String? message) = Error;
  const factory EquipmentState.noContent() = NoContent;
}
