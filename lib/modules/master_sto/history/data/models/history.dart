import 'package:freezed_annotation/freezed_annotation.dart';

import 'phase.dart';

part 'generated/history.freezed.dart';
part 'generated/history.g.dart';

@freezed
class History with _$History {
  const factory History({
    @Default([]) List<Phase> historyList,
    @Default('') String? reworkComment,
  }) = _History;

  factory History.fromJson(Map<String, dynamic> json) =>
      _$HistoryFromJson(json);
}
