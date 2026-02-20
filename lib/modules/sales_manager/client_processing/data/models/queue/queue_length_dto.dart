import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/queue_length_dto.freezed.dart';
part 'generated/queue_length_dto.g.dart';

@freezed
class QueueLengthDTO with _$QueueLengthDTO {
  const factory QueueLengthDTO({
    @JsonKey(name: 'queueLength') int? data,
  }) = _QueueLengthDTO;

  factory QueueLengthDTO.fromJson(Map<String, dynamic> json) =>
      _$QueueLengthDTOFromJson(json);
}
