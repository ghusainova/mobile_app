import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/defect_item.freezed.dart';
part 'generated/defect_item.g.dart';

@freezed
class DefectItem with _$DefectItem {
  const factory DefectItem({
    @Default('') String name,
    @Default(false) bool status,
  }) = _DefectItem;

  factory DefectItem.fromJson(Map<String, dynamic> json) =>
      _$DefectItemFromJson(json);
}
