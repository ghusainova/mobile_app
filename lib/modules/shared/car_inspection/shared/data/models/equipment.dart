import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/equipment.freezed.dart';
part 'generated/equipment.g.dart';

@freezed
class Equipment with _$Equipment {
  const factory Equipment({
    @Default('') String title,
    @Default('') String value,
  }) = _EquipmentItem;

  factory Equipment.fromJson(Map<String, dynamic> json) =>
      _$EquipmentFromJson(json);
}
