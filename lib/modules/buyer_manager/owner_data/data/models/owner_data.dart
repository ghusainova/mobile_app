import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/_data/models/auto.dart';
import 'client.dart';

part 'generated/owner_data.freezed.dart';
part 'generated/owner_data.g.dart';

@freezed
class OwnerData with _$OwnerData {
  const factory OwnerData({
    Client? client,
    Auto? auto,
  }) = _OwnerData;

  factory OwnerData.fromJson(Map<String, dynamic> json) =>
      _$OwnerDataFromJson(json);
}
