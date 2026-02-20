import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'complete_reason_item.dart';

part 'generated/completing_reasons_args.g.dart';
part 'generated/completing_reasons_args.freezed.dart';

@freezed
class CompletingReasonsRouteArgs with _$CompletingReasonsRouteArgs {
  const factory CompletingReasonsRouteArgs({
    required List<CompleteReasonItem> reasonItems,
    String? title,
    bool? isCancel,
    @JsonKey(includeFromJson: false, includeToJson: false)
    VoidCallback? onSubmit,
  }) = _CompletingReasonsRouteArgs;

  factory CompletingReasonsRouteArgs.fromJson(Map<String, dynamic> json) =>
      _$CompletingReasonsRouteArgsFromJson(json);
}
