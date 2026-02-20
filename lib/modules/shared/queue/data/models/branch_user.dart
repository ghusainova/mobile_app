import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../complete_client_session/data/enums/branch_user_queue_type_enum.dart';

part 'generated/branch_user.g.dart';
part 'generated/branch_user.freezed.dart';

int? fromEnumToJson(BranchUserQueueTypeEnum? value) {
  return value?.code;
}

BranchUserQueueTypeEnum? fromIntToEnum(int? value) {
  return BranchUserQueueTypeEnum.values
      .firstWhereOrNull((element) => element.code == value);
}

@freezed
class BranchUser with _$BranchUser {
  const factory BranchUser({
    int? tableNumber,
    @JsonKey(
      fromJson: fromIntToEnum,
      toJson: fromEnumToJson,
    )
    BranchUserQueueTypeEnum? queueType,
    String? login,
    String? branchCode,
    String? fullname,
  }) = _BranchUser;

  factory BranchUser.fromJson(Map<String, dynamic> json) =>
      _$BranchUserFromJson(json);
}
