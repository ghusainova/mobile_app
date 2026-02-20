part of 'credit_media_capture_bloc.dart';

@freezed
class CreditMediaCaptureState with _$CreditMediaCaptureState {
  const factory CreditMediaCaptureState.loading({int? itemIndex}) = Loading;
  const factory CreditMediaCaptureState.loaded(
    List<CreditMediaFile> mediaFiles,
  ) = Loaded;
  const factory CreditMediaCaptureState.uploaded() = Uploaded;
  const factory CreditMediaCaptureState.deleted() = Deleted;
  const factory CreditMediaCaptureState.noData() = _NoData;
  const factory CreditMediaCaptureState.error(String? error) = _Error;
}
