part of 'media_capture_vin_bloc.dart';

@freezed
class MediaCaptureVinState with _$MediaCaptureVinState {
  const factory MediaCaptureVinState.loading() = Loading;
  const factory MediaCaptureVinState.loaded(
    List<MediaFile> mediaFiles,
  ) = Loaded;
  const factory MediaCaptureVinState.uploaded() = Uploaded;
  const factory MediaCaptureVinState.deleted() = Deleted;
  const factory MediaCaptureVinState.noData() = NoData;
  const factory MediaCaptureVinState.error(String? error) = Error;
}
