part of 'buyer_media_capture_vin_bloc.dart';

@freezed
class BuyerMediaCaptureVinEvent with _$BuyerMediaCaptureVinEvent {
  const factory BuyerMediaCaptureVinEvent.getMediaFiles({
    required String? caseId,
    required String type,
  }) = GetMediaFiles;
  const factory BuyerMediaCaptureVinEvent.uploadFile({
    required String? caseId,
    required String type,
    required File file,
  }) = UploadFile;
  const factory BuyerMediaCaptureVinEvent.deleteFile({
    required String? caseId,
    required String documentId,
    required String type,
  }) = DeleteFile;
}
