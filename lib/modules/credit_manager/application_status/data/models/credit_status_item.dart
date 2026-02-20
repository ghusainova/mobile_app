import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/credit_status_item.freezed.dart';
part 'generated/credit_status_item.g.dart';

@freezed
class CreditStatusItem with _$CreditStatusItem {
  const factory CreditStatusItem({
    @Default('') String statusCode,
    @Default('') String name,
    @JsonKey(includeFromJson: false, includeToJson: false) String? finalName,
    @Default('') String comment,
    @Default(false) bool isDone,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(false)
    bool isRework,
    @JsonKey(includeFromJson: false, includeToJson: false) bool? isStageItem,
    @Default([]) List<String> reworkCodes,
  }) = _CreditStatusItem;

  factory CreditStatusItem.fromJson(Map<String, dynamic> json) =>
      _$CreditStatusItemFromJson(json);
}
