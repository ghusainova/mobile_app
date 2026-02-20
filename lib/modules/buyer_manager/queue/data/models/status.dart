import 'package:freezed_annotation/freezed_annotation.dart';

import '../enum/buyer_status.dart';
import '../../../../shared/_data/enums/status_type_enum.dart';

part 'generated/status.freezed.dart';
part 'generated/status.g.dart';

@freezed
class Status with _$Status {
  factory Status({
    @Default('') String code,
    @Default('') String description,
    @Default('') String type,
    StatusTypeEnum? statusTypeEnum,
    BuyerStatusEnum? buyerStatusEnum,
  }) = _Status;

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
}
