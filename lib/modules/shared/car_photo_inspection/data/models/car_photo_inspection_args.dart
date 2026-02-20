import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'photo_inspection_info_item.dart';

part 'generated/car_photo_inspection_args.freezed.dart';
part 'generated/car_photo_inspection_args.g.dart';

@freezed
class CarPhotoInspectionArgs with _$CarPhotoInspectionArgs {
  const factory CarPhotoInspectionArgs({
    String? caseId,
    @Default('') String title,
    @Default('') String subtitle,
    @Default('') String btnTitle,
    @Default([]) List<PhotoInspectionInfoItem> inspectionInfoItems,
    @JsonKey(includeFromJson: false, includeToJson: false)
    VoidCallback? onSubmit,
  }) = _CarPhotoInspectionArgs;

  factory CarPhotoInspectionArgs.fromJson(Map<String, dynamic> json) =>
      _$CarPhotoInspectionArgsFromJson(json);
}
