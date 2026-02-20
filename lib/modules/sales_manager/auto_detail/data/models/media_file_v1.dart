import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/media_file_v1.freezed.dart';
part 'generated/media_file_v1.g.dart';

@freezed
class MediaFileV1 with _$MediaFileV1 {
  factory MediaFileV1({
    @Default('') String name,
    @Default('') String extension,
    @Default('') String id,
    @Default('') String type,
    @Default('') String path,
    @Default('') String bucketName,
    @Default('') String s3Link,
    @Default('') String s3CompressLink,
  }) = _MediaFileV1;

  factory MediaFileV1.fromJson(Map<String, dynamic> json) =>
      _$MediaFileV1FromJson(json);
}
