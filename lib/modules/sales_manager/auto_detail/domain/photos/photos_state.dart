part of 'photos_bloc.dart';

@freezed
class PhotosState with _$PhotosState {
  const factory PhotosState.loading() = _Loading;
  const factory PhotosState.loaded({required List<MediaFileV1?> photos}) =
      Loaded;
  const factory PhotosState.noData() = NoData;
  const factory PhotosState.error(String? errorMessage) = _Error;
}
