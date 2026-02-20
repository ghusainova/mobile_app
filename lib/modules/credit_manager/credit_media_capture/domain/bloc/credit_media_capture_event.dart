part of 'credit_media_capture_bloc.dart';

@freezed
class CreditMediaCaptureEvent with _$CreditMediaCaptureEvent {
  const factory CreditMediaCaptureEvent.getMediaFiles({
    required String? orderId,
    required String category,
    String? fileType,
  }) = GetMediaFiles;
  const factory CreditMediaCaptureEvent.uploadFile({
    required String? orderId,
    required String fileType,
    required String category,
    required File file,
    bool? isVideo,
    bool? getFiles,
    int? itemIndex,
  }) = UploadFile;
  const factory CreditMediaCaptureEvent.deleteFile({
    required int fileId,
    required String? orderId,
    required String fileType,
    required String category,
    bool? getFiles,
    int? itemIndex,
  }) = DeleteFile;
}
