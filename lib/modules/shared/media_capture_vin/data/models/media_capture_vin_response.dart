import 'package:freezed_annotation/freezed_annotation.dart';

import 'media_file.dart';

part 'generated/media_capture_vin_response.freezed.dart';
part 'generated/media_capture_vin_response.g.dart';

@freezed
class MediaCaptureVinResponse with _$MediaCaptureVinResponse {
  factory MediaCaptureVinResponse({
    @Default([]) List<MediaFile> files,
  }) = _MediaCaptureVinResponse;

  factory MediaCaptureVinResponse.fromJson(Map<String, dynamic> json) =>
      _$MediaCaptureVinResponseFromJson(json);
}
