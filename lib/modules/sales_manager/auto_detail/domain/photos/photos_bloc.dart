import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../../../config/logs/log.dart';
import '../../data/models/media_file_v1.dart';
import '../../data/repositories/photos_repository.dart';

part 'generated/photos_bloc.freezed.dart';
part 'photos_event.dart';
part 'photos_state.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  PhotosBloc() : super(const _Loading()) {
    on<Started>(_onStarted);
    on<Load>(_load);
  }

  final _photosRepository = getIt.get<PhotosRepository>();

  void _onStarted(Started event, Emitter<PhotosState> emit) {
    emit(const _Loading());
  }

  void registerInjection() {
    if (!getIt.isRegistered<PhotosBloc>()) {
      getIt.registerFactory(() => PhotosBloc());
    }
  }

  void unregisterInjection() => getIt.unregister<PhotosBloc>();

  Future<void> _load(
    Load event,
    Emitter<PhotosState> emit,
  ) async {
    if (event.orderId == null) {
      emit(const _Error('Order Id not specified'));
      return;
    }

    emit(const _Loading());
    final response = await getPhotos(event.orderId!, event.type)
        .onError((error, stackTrace) {
      emit(_Error(error.toString()));
      return null;
    });

    if (response != null) {
      emit(Loaded(photos: response));
    } else {
      emit(const NoData());
    }
  }

  Future<List<MediaFileV1?>?> getPhotos(String orderId, String type) async {
    try {
      return await _photosRepository.getPhotos(orderId, type);
    } on DioException catch (e) {
      logger.e(e);
      return null;
    }
  }
}
