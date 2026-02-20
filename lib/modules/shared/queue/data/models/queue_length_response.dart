import 'package:freezed_annotation/freezed_annotation.dart';

import 'queue_statistics.dart';

part 'generated/queue_length_response.freezed.dart';
part 'generated/queue_length_response.g.dart';

@freezed
class QueueLengthResponse with _$QueueLengthResponse {
  const factory QueueLengthResponse(
    QueueStatistics shortStatistics,
  ) = _QueueLengthResponse;

  factory QueueLengthResponse.fromJson(Map<String, dynamic> json) =>
      _$QueueLengthResponseFromJson(json);
}
