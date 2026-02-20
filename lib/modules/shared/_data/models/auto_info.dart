import 'package:freezed_annotation/freezed_annotation.dart';

import 'auto.dart';
import '../../../sales_manager/catalog/data/models/credit.dart';
import '../../../sales_manager/catalog/data/models/parking.dart';

part 'generated/auto_info.freezed.dart';
part 'generated/auto_info.g.dart';

@freezed
class AutoInfo with _$AutoInfo {
  const factory AutoInfo({
    required Auto? auto,
    required Credit? credit,
    required Parking? parking,
    @Default('') String id,
    @Default('') String integrationId,
    @Default('') String priceSelling,
    @Default('') String linkSell,
    @Default('') String method,
  }) = _AutoInfo;

  factory AutoInfo.fromJson(Map<String, dynamic> json) =>
      _$AutoInfoFromJson(json);
}
