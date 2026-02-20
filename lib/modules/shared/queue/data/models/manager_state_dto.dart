import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../sales_manager/client_processing/data/enum/manager_state.dart';

part 'generated/manager_state_dto.freezed.dart';
part 'generated/manager_state_dto.g.dart';

@freezed
class ManagerStateDTO with _$ManagerStateDTO {
  const factory ManagerStateDTO({
    @JsonKey(
      name: 'message',
      fromJson: _formStringToEnum,
    )
    ManagerState? data,
  }) = _ManagerStateDTO;

  factory ManagerStateDTO.fromJson(Map<String, dynamic> json) =>
      _$ManagerStateDTOFromJson(json);
}

ManagerState? _formStringToEnum(String? code) =>
    ManagerState.values.firstWhereOrNull((element) => element.code == code);
