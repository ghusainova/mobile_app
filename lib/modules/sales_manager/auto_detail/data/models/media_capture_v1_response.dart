import 'package:freezed_annotation/freezed_annotation.dart';

import 'media_file_v1.dart';

part 'generated/media_capture_v1_response.freezed.dart';
part 'generated/media_capture_v1_response.g.dart';

@freezed
class MediaCaptureV1Response with _$MediaCaptureV1Response {
  factory MediaCaptureV1Response({
    @Default([]) List<MediaFileV1> files,
  }) = _MediaCaptureV1Response;

  factory MediaCaptureV1Response.fromJson(Map<String, dynamic> json) =>
      _$MediaCaptureV1ResponseFromJson(json);
}
