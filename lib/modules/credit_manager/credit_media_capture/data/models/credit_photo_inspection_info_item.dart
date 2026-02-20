import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/credit_photo_inspection_info_item.freezed.dart';
part 'generated/credit_photo_inspection_info_item.g.dart';

@freezed
class CreditPhotoInspectionInfoItem with _$CreditPhotoInspectionInfoItem {
  const factory CreditPhotoInspectionInfoItem({
    @Default('') String imagePath,
    @Default('') String title,
    @Default('') String fileType,
    @Default('') String category,
    @Default(false) bool isAdditional,
  }) = _CreditPhotoInspectionInfoItem;

  factory CreditPhotoInspectionInfoItem.fromJson(Map<String, dynamic> json) =>
      _$CreditPhotoInspectionInfoItemFromJson(json);
}
