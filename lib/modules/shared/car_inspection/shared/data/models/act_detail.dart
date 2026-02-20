import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/act_detail.freezed.dart';
part 'generated/act_detail.g.dart';

@freezed
class ActDetail with _$ActDetail {
  const factory ActDetail({
    @Default('') String equipment,
    @Default('') String condition,
    @Default(false) bool isDefect,
  }) = _ActDetail;

  factory ActDetail.fromJson(Map<String, dynamic> json) =>
      _$ActDetailFromJson(json);
}
