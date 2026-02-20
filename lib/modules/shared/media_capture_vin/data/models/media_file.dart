import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/media_file.freezed.dart';
part 'generated/media_file.g.dart';

@freezed
class MediaFile with _$MediaFile {
  factory MediaFile({
    String? fileBase64,
    @Default('') String fileName,
    @Default('') String fileExtension,
    @Default('') String objectId,
    @Default('') String documentType,
    @Default('') String filePath,
    @Default('') String bucketName,
  }) = _MediaFile;

  factory MediaFile.fromJson(Map<String, dynamic> json) =>
      _$MediaFileFromJson(json);
}
