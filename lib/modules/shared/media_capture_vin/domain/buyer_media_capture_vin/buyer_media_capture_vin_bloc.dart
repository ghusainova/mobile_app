import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../../sales_manager/auto_detail/data/models/media_file_v1.dart';
import '../../data/enum/media_capture_file_type_enum.dart';
import '../../data/repositories/buyer_media_capture_vin_repository.dart';

part 'buyer_media_capture_vin_event.dart';
part 'buyer_media_capture_vin_state.dart';
part 'generated/buyer_media_capture_vin_bloc.freezed.dart';

//TODO: remove this when media api will be refactored to v2/media
class BuyerMediaCaptureVinBloc
    extends Bloc<BuyerMediaCaptureVinEvent, BuyerMediaCaptureVinState> {
  BuyerMediaCaptureVinBloc() : super(const Loading()) {
    on<GetMediaFiles>(_getMediaFiles);
    on<UploadFile>(_uploadFile);
    on<DeleteFile>(_deleteFile);
  }

  final _mediaCaptureVinRepository = getIt.get<BuyerMediaCaptureRepository>();

  List<MediaFileV1> _mediaFiles = [];

  MediaFileV1? photo(String type) =>
      _mediaFiles.firstWhereOrNull((element) => element.type == type);

  Future<void> _getMediaFiles(
    GetMediaFiles event,
    Emitter<BuyerMediaCaptureVinState> emit,
  ) async {
    emit(const Loading());

    if (event.caseId == null) {
      emit(const _Error('Order Id not specified'));
      emit(const _NoData());
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
      emit(_Error(e.message));
      emit(const _NoData());
    }
  }

  Future<void> _uploadFile(
    UploadFile event,
    Emitter<BuyerMediaCaptureVinState> emit,
  ) async {
    emit(const Loading());

    if (event.caseId == null) {
      emit(const _Error('Order Id not specified'));
      emit(const _NoData());
      return;
    }

    try {
      await _mediaCaptureVinRepository.uploadFile(
        event.caseId!,
        event.type,
        MediaTypeEnum.photo.ext,
        event.file,
      );

      emit(const Uploaded());
      add(
        GetMediaFiles(
          caseId: event.caseId,
          type: event.type,
        ),
      );
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> _deleteFile(
    DeleteFile event,
    Emitter<BuyerMediaCaptureVinState> emit,
  ) async {
    emit(const Loading());

    if (event.caseId == null) {
      emit(const _Error('Order Id not specified'));
      emit(const _NoData());
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
    } on DioException catch (e) {
      emit(_Error(e.message));
      emit(const _NoData());
    }
  }
}
