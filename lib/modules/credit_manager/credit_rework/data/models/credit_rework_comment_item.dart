import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/credit_rework_comment_item.freezed.dart';
part 'generated/credit_rework_comment_item.g.dart';

@freezed
class CreditReworkCommentItem with _$CreditReworkCommentItem {
  const factory CreditReworkCommentItem({
    @Default('') String? code,
    @Default('') String? comment,
  }) = _CreditReworkCommentItem;

  factory CreditReworkCommentItem.fromJson(Map<String, dynamic> json) =>
      _$CreditReworkCommentItemFromJson(json);
}
