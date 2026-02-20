import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/active_client_dto.freezed.dart';
part 'generated/active_client_dto.g.dart';

@freezed
class ActiveClientDTO with _$ActiveClientDTO {
  const factory ActiveClientDTO({
    String? branchCode,
    String? serviceName,
    String? firstname,
    String? patronymic,
    String? iin,
    String? tvNotificationSent,
    String? phone,
    String? sessionId,
    String? scannedDeviceCode,
    String? serviceDate,
    int? clientTransactionId,
    int? ticketNumber,
    int? tableNumber,
    int? waitTimeSeconds,
    int? serviceTimeSeconds,
  }) = _ActiveClientDTO;

  factory ActiveClientDTO.fromJson(Map<String, dynamic> json) =>
      _$ActiveClientDTOFromJson(json);
}
