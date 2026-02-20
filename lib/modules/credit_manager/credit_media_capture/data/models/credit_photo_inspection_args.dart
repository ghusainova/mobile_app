import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'credit_photo_inspection_info_item.dart';

part 'generated/credit_photo_inspection_args.freezed.dart';
part 'generated/credit_photo_inspection_args.g.dart';

@freezed
class CreditPhotoInspectionArgs with _$CreditPhotoInspectionArgs {
  const factory CreditPhotoInspectionArgs({
    @Default('') String title,
    @Default('') String subtitle,
    String? btnTitle,
    @Default('') String category,
    @Default(false) bool showAdditionalPhotoBtn,
    @Default([]) List<CreditPhotoInspectionInfoItem> inspectionInfoItems,
    @JsonKey(includeFromJson: false, includeToJson: false)
    VoidCallback? onSubmit,
  }) = _CreditPhotoInspectionArgs;

  factory CreditPhotoInspectionArgs.fromJson(Map<String, dynamic> json) =>
      _$CreditPhotoInspectionArgsFromJson(json);
}
