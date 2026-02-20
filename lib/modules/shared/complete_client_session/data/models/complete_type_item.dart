import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/complete_type_item.g.dart';
part 'generated/complete_type_item.freezed.dart';

@freezed
class CompleteTypeItem with _$CompleteTypeItem {
  const CompleteTypeItem._();

  const factory CompleteTypeItem({
    required String title,
    @Default('') String subtitle,
    @JsonKey(includeFromJson: false, includeToJson: false)
    VoidCallback? routeNav,
    @Default(false) bool isSelected,
  }) = _CompleteTypeItem;

  factory CompleteTypeItem.fromJson(Map<String, dynamic> json) =>
      _$CompleteTypeItemFromJson(json);

  factory CompleteTypeItem.onSelect(
    CompleteTypeItem currentItem,
    CompleteTypeItem selectedItem,
  ) {
    if (currentItem.title == selectedItem.title) {
      return selectedItem.copyWith(isSelected: true);
    } else {
      return currentItem.copyWith(isSelected: false);
    }
  }
}
