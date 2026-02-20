part of 'media_capture_vin_bloc.dart';

@freezed
class MediaCaptureVinEvent with _$MediaCaptureVinEvent {
  const factory MediaCaptureVinEvent.getMediaFiles({
    required String? caseId,
    required String type,
  }) = GetMediaFiles;
  const factory MediaCaptureVinEvent.uploadFile({
    required String? caseId,
    required String type,
    required File file, String? subType,
  }) = UploadFile;
  const factory MediaCaptureVinEvent.deleteFile({
    required String? caseId,
    required String documentId,
    required String type,
    String? subType,
  }) = DeleteFile;
}
