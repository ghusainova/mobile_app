part of 'photos_bloc.dart';

@freezed
class PhotosEvent with _$PhotosEvent {
  const factory PhotosEvent.started() = Started;
  const factory PhotosEvent.load({
    required String? orderId,
    required String type,
  }) = Load;
}
