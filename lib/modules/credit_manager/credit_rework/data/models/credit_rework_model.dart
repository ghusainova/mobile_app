import 'package:collection/collection.dart';

import '../enums/credit_rework_types_enum.dart';
import 'credit_rework_comment_item.dart';
import 'credit_rework_page_item.dart';
import 'credit_rework_response.dart';

class CreditReworkModel {
  final List<Page> pages;
  final List<String> files;

  CreditReworkModel(this.pages, this.files);

  factory CreditReworkModel.fromCreditWorkResponse(
    CreditReworkResponse response,
  ) {
    final pages = CreditReworkItemType.values
        .map(
          (e) => Page(type: e, comments: []),
        )
        .toList();

    final allComments = <String>[];
    final allFiles = <String>[];

    for (CreditReworkPageItem item in response.verificationData ?? []) {
      for (CreditReworkCommentItem comment in (item.comments ?? [])) {
        pages
            .firstWhereOrNull((page) => page.type.code == comment.code)
            ?.comments
            .add(comment.comment ?? '');
      }
      allFiles.addAll(item.files);
    }

    for (var i = 0; i < pages.length; i++) {
      pages[i]
          .comments
          .addAll(allComments.where((c) => c == pages[i].type.code));
    }

    return CreditReworkModel(pages, allFiles);
  }
}

class Page {
  final CreditReworkItemType type;
  final List<String> comments;

  Page({required this.type, required this.comments});
}
