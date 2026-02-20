part of 'buyer_media_capture_vin_bloc.dart';

@freezed
class BuyerMediaCaptureVinState with _$BuyerMediaCaptureVinState {
  const factory BuyerMediaCaptureVinState.loading() = Loading;
  const factory BuyerMediaCaptureVinState.loaded(
    List<MediaFileV1> mediaFiles,
  ) = Loaded;
  const factory BuyerMediaCaptureVinState.uploaded() = Uploaded;
  const factory BuyerMediaCaptureVinState.deleted() = Deleted;
  const factory BuyerMediaCaptureVinState.noData() = _NoData;
  const factory BuyerMediaCaptureVinState.error(String? error) = _Error;
}
