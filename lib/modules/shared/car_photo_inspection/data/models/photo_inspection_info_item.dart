import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/photo_inspection_info_item.freezed.dart';
part 'generated/photo_inspection_info_item.g.dart';

@freezed
class PhotoInspectionInfoItem with _$PhotoInspectionInfoItem {
  const factory PhotoInspectionInfoItem({
    @Default('') String iconPath,
    @JsonKey(includeFromJson: false, includeToJson: false) File? mediaFile,
    @Default('') String title,
    @Default(false) bool isVideoRecording,
    @Default(false) bool isAdditional,
    @Default(false) bool forceOpenCamera,
  }) = _PhotoInspectionInfoItem;

  factory PhotoInspectionInfoItem.fromJson(Map<String, dynamic> json) =>
      _$PhotoInspectionInfoItemFromJson(json);
}
