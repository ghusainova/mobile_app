import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:video_compress_v2/video_compress_v2.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../../../config/logs/log.dart';
import '../../../../../services/sentry_service.dart';
import '../../data/enum/media_capture_file_type_enum.dart';
import '../../data/models/media_file.dart';
import '../../data/repositories/media_capture_vin_repository.dart';
import '../../../_domain/utility/clear_cache.dart';

part 'media_capture_vin_event.dart';
part 'media_capture_vin_state.dart';
part 'generated/media_capture_vin_bloc.freezed.dart';

class MediaCaptureVinBloc
    extends Bloc<MediaCaptureVinEvent, MediaCaptureVinState> {
  MediaCaptureVinBloc() : super(const Loading()) {
    on<GetMediaFiles>(_getMediaFiles);
    on<UploadFile>(_uploadFile);
    on<DeleteFile>(_deleteFile);
  }

  final _mediaCaptureVinRepository = getIt.get<MediaCaptureRepository>();

  List<MediaFile> _mediaFiles = [];

  MediaFile? get video => _mediaFiles.firstWhereOrNull(
        (element) => element.documentType == MediaTypeEnum.video.code,
      );

  List<MediaFile> photos(String type) =>
      _mediaFiles.where((element) => element.documentType == type).toList();

  void registerInjection() {
    if (!getIt.isRegistered<MediaCaptureVinBloc>()) {
      getIt.registerFactory(() => MediaCaptureVinBloc());
    }
  }

  void unregisterInjection() => getIt.unregister<MediaCaptureVinBloc>();

  Future<void> _getMediaFiles(
    GetMediaFiles event,
    Emitter<MediaCaptureVinState> emit,
  ) async {
    emit(const Loading());

    if (event.caseId == null) {
      emit(const Error('Order Id not specified'));
      emit(const NoData());
      return;
    }

    try {
      _mediaFiles = [];

      final response = await _mediaCaptureVinRepository.getFiles(
        event.caseId!,
        event.type,
      );

      _mediaFiles = response;
      emit(Loaded(response));
    } on DioException catch (e) {
      emit(Error(e.message));
      emit(const NoData());
    }
  }

  Future<void> _uploadFile(
    UploadFile event,
    Emitter<MediaCaptureVinState> emit,
  ) async {
    final type = event.subType ?? event.type;
    emit(const Loading());

    if (event.caseId == null) {
      emit(const Error('Order Id not specified'));
      emit(const NoData());
      return;
    }

    try {
      final fileExtension = type == MediaTypeEnum.video.code
          ? MediaTypeEnum.video.ext
          : MediaTypeEnum.photo.ext;

      final compressedFile = await _compressVideo(type, event.file);

      //TODO: temp check for resolving error https://sentry.hq.bc/organizations/kaspi/issues/319677546/?project=289
      if (!(await compressedFile.exists())) {
        await captureSentryEvent(
          'Ошибка сжатия файла, попробуйте еще раз. ${event.caseId}',
          compressedFile.uri.data,
        );
        emit(const Error('Ошибка сжатия файла, попробуйте еще раз.'));
        return;
      }

      await _mediaCaptureVinRepository.uploadFile(
        event.caseId!,
        type,
        fileExtension,
        compressedFile,
      );

      emit(const Uploaded());
      add(
        GetMediaFiles(
          caseId: event.caseId,
          type: event.type,
        ),
      );
      deleteCache();
    } on DioException catch (e) {
      emit(Error(e.message));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<void> _deleteFile(
    DeleteFile event,
    Emitter<MediaCaptureVinState> emit,
  ) async {
    emit(const Loading());

    if (event.caseId == null) {
      emit(const Error('Order Id not specified'));
      emit(const NoData());
      return;
    }

    try {
      await _mediaCaptureVinRepository.deleteFile(
        event.caseId!,
        event.documentId,
      );
      emit(const Deleted());
      add(
        GetMediaFiles(
          caseId: event.caseId,
          type: event.type,
        ),
      );
      deleteCache();
    } on DioException catch (e) {
      emit(Error(e.message));
      emit(const NoData());
    }
  }

  Future<File> _compressVideo(String type, File file) async {
    MediaInfo? compressedVideo;

    if (type != MediaTypeEnum.video.code) {
      return file;
    }

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
