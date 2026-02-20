import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/updating_info_params.freezed.dart';
part 'generated/updating_info_params.g.dart';

@freezed
class UpdatingInfoParams with _$UpdatingInfoParams {
  const factory UpdatingInfoParams({
    String? brand,
    String? model,
    String? year,
  }) = _UpdatingInfoParams;

  factory UpdatingInfoParams.fromJson(Map<String, dynamic> json) =>
      _$UpdatingInfoParamsFromJson(json);
}
