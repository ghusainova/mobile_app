part of 'equipment_bloc.dart';

@freezed
class EquipmentEvent with _$EquipmentEvent {
  const factory EquipmentEvent.load({required AutoInfo? autoInfo}) = Load;
}
