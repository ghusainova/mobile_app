import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/timeline_tile_item.g.dart';
part 'generated/timeline_tile_item.freezed.dart';

@freezed
class TimelineTileItem with _$TimelineTileItem {
  const factory TimelineTileItem({
    @Default(0) num? key,
    @Default('') String title,
    @Default('') String subtitle,
    @Default(false) bool isSelected,
    @Default(false) bool isLast,
    @JsonKey(includeToJson: false, includeFromJson: false)
    final Color? lineInProgressColor,
    @JsonKey(includeToJson: false, includeFromJson: false)
    final Widget? customKeyWidget,
    @JsonKey(includeToJson: false, includeFromJson: false) final Widget? child,
  }) = _TimelineTileItem;

  factory TimelineTileItem.fromJson(Map<String, dynamic> json) =>
      _$TimelineTileItemFromJson(json);
}
