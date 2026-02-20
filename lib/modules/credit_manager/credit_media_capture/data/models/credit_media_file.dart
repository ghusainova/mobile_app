import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/credit_media_file.freezed.dart';
part 'generated/credit_media_file.g.dart';

@freezed
class CreditMediaFile with _$CreditMediaFile {
  factory CreditMediaFile({
    required int id,
    @Default('') String fileName,
    @Default('') String fileType,
    @Default('') String category,
    @Default('') String bucketName,
    @Default('') String fileMimeType,
    @Default('') String fileLink,
    @Default('') String fileS3Path,
  }) = _CreditMediaFile;

  factory CreditMediaFile.fromJson(Map<String, dynamic> json) =>
      _$CreditMediaFileFromJson(json);
}
