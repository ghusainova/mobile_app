import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/complete_reason_item.g.dart';
part 'generated/complete_reason_item.freezed.dart';

@freezed
class CompleteReasonItem with _$CompleteReasonItem {
  const factory CompleteReasonItem({
    @Default('') String title,
    @Default(false) bool isSelected,
    @JsonKey(includeFromJson: false, includeToJson: false)
    VoidCallback? routeNav,
  }) = _CompleteReasonItem;

  factory CompleteReasonItem.fromJson(Map<String, dynamic> json) =>
      _$CompleteReasonItemFromJson(json);
}
