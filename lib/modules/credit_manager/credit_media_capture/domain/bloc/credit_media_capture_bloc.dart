import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:video_compress_v2/video_compress_v2.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../../../config/logs/log.dart';
import '../../data/enums/vin_credit_media_file_type_enum.dart';
import '../../data/models/credit_media_file.dart';
import '../../data/repositories/credit_media_capture_repository.dart';

part 'credit_media_capture_event.dart';
part 'credit_media_capture_state.dart';
part 'generated/credit_media_capture_bloc.freezed.dart';

class CreditMediaCaptureBloc
    extends Bloc<CreditMediaCaptureEvent, CreditMediaCaptureState> {
  CreditMediaCaptureBloc() : super(const Loading()) {
    on<GetMediaFiles>(_getMediaFiles);
    on<UploadFile>(_uploadFile);
    on<DeleteFile>(_deleteFile);
  }

  final _mediaCaptureVinRepository = getIt.get<CreditMediaCaptureRepository>();

  CreditMediaFile? get video => state is Loaded
      ? (state as Loaded).mediaFiles.firstWhereOrNull(
            (element) =>
                element.fileType == VinCreditMediaFileTypeEnum.video.fileType,
          )
      : null;

  void registerInjection() {
    if (!getIt.isRegistered<CreditMediaCaptureBloc>()) {
      getIt.registerFactory(() => CreditMediaCaptureBloc());
    }
  }

  void unregisterInjection() => getIt.unregister<CreditMediaCaptureBloc>();

  Future<void> _getMediaFiles(
    GetMediaFiles event,
    Emitter<CreditMediaCaptureState> emit,
  ) async {
    emit(const Loading());

    if (event.orderId == null) {
      emit(const _Error('Order Id not specified'));
      emit(const _NoData());
      return;
    }

    try {
      final response = await _mediaCaptureVinRepository.getFiles(
        orderId: event.orderId!,
        category: event.category,
        fileType: event.fileType,
      );

      emit(Loaded(response));
    } on DioException catch (e) {
      emit(_Error(e.message));
      emit(const _NoData());
    }
  }

  Future<void> _uploadFile(
    UploadFile event,
    Emitter<CreditMediaCaptureState> emit,
  ) async {
    var file = event.file;
    emit(Loading(itemIndex: event.itemIndex));

    if (event.orderId == null) {
      emit(const _Error('Order Id not specified'));
      emit(const _NoData());
      return;
    }

    try {
      if (event.isVideo == true) {
        file = await _compressVideo(event.file);
      }

      await _mediaCaptureVinRepository.uploadFile(
        orderId: event.orderId!,
        fileType: event.fileType,
        category: event.category,
        file: file,
      );

      emit(const Uploaded());
      add(
        GetMediaFiles(
          orderId: event.orderId,
          category: event.category,
          fileType: event.getFiles == null ? event.fileType : null,
        ),
      );
    } on DioException catch (e) {
      emit(_Error(e.message));
    }
  }

  Future<void> _deleteFile(
    DeleteFile event,
    Emitter<CreditMediaCaptureState> emit,
  ) async {
    emit(Loading(itemIndex: event.itemIndex));

    try {
      await _mediaCaptureVinRepository.deleteFile(event.fileId);
      emit(const Deleted());

      if (event.orderId != null) {
        add(
          GetMediaFiles(
            orderId: event.orderId,
            category: event.category,
            fileType: event.getFiles == null ? event.fileType : null,
          ),
        );
      }
    } on DioException catch (e) {
      emit(_Error(e.message));
      emit(const _NoData());
    }
  }

  Future<File> _compressVideo(File file) async {
    MediaInfo? compressedVideo;

    try {
      compressedVideo = await VideoCompressV2.compressVideo(
        file.path,
        quality: VideoQuality.MediumQuality,
        deleteOrigin: true,
      );
    } catch (e) {
      logger.e(e);
    }

    return compressedVideo?.file ?? file;
  }
}
