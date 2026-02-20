import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/app_version_response.g.dart';
part 'generated/app_version_response.freezed.dart';

@freezed
class AppVersionResponse with _$AppVersionResponse {
  const factory AppVersionResponse({
    String? downloadLink,
    String? version,
    bool? actual,
    bool? isMultiple,
  }) = _AppVersionResponse;

  factory AppVersionResponse.fromJson(Map<String, dynamic> json) =>
      _$AppVersionResponseFromJson(json);
}
