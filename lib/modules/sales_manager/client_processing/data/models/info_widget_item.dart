import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/info_widget_item.freezed.dart';
part 'generated/info_widget_item.g.dart';

@freezed
class InfoWidgetItem with _$InfoWidgetItem {
  const factory InfoWidgetItem({
    required String title,
    required String subtitle,
  }) = _InfoWidgetItem;

  factory InfoWidgetItem.fromJson(Map<String, dynamic> json) =>
      _$InfoWidgetItemFromJson(json);
}
