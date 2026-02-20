import 'package:freezed_annotation/freezed_annotation.dart';

import 'branch_user.dart';

part 'generated/queue_branch_response.g.dart';
part 'generated/queue_branch_response.freezed.dart';

@freezed
class QueueBranchResponse with _$QueueBranchResponse {
  const factory QueueBranchResponse({
    @Default([]) List<BranchUser> users,
  }) = _QueueBranchResponse;

  factory QueueBranchResponse.fromJson(Map<String, dynamic> json) =>
      _$QueueBranchResponseFromJson(json);
}
