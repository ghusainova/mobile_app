import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/queue_statistics.freezed.dart';
part 'generated/queue_statistics.g.dart';

@freezed
class QueueStatistics with _$QueueStatistics {
  const factory QueueStatistics({
    int? queueLength,
    int? averageWaitTimeSeconds,
    int? maxWaitTimeSeconds,
  }) = _QueueStatistics;

  factory QueueStatistics.fromJson(Map<String, dynamic> json) =>
      _$QueueStatisticsFromJson(json);
}
