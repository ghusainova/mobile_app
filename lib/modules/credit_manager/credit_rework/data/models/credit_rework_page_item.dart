import 'package:freezed_annotation/freezed_annotation.dart';

import 'credit_rework_comment_item.dart';

part 'generated/credit_rework_page_item.freezed.dart';
part 'generated/credit_rework_page_item.g.dart';

@freezed
class CreditReworkPageItem with _$CreditReworkPageItem {
  const factory CreditReworkPageItem({
    @Default('') String? page,
    @Default([]) List<CreditReworkCommentItem>? comments,
    @Default([]) List<String> files,
  }) = _CreditReworkPageItem;

  factory CreditReworkPageItem.fromJson(Map<String, dynamic> json) =>
      _$CreditReworkPageItemFromJson(json);
}
