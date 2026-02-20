import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../../shared/media_capture_vin/data/models/media_file.dart';
import '../../../history/domain/history/history_bloc.dart';
import '../../../scan_cases/domain/scan_cases/scan_cases_bloc.dart';
import '../../data/models/equipment_inspection.dart';
import '../../data/repositories/equipment_inspection_repository.dart';

part 'equipment_inspection_event.dart';
part 'equipment_inspection_state.dart';
part 'generated/equipment_inspection_bloc.freezed.dart';

class EquipmentInspectionBloc
    extends Bloc<EquipmentInspectionEvent, EquipmentInspectionState> {
  EquipmentInspectionBloc() : super(const Loading()) {
    on<Load>(_onLoad);
    on<Save>(_onSave);
  }

  final _repository = getIt.get<EquipmentInspectionRepository>();
  final _caseId = getIt.get<ScanCasesBloc>().scanCase?.caseId;

  List<MediaFile> _mediaFiles = [];

  List<MediaFile> get mediaFiles => _mediaFiles;

  void registerInjection() {
    if (!getIt.isRegistered<EquipmentInspectionBloc>()) {
      getIt.registerFactory(() => EquipmentInspectionBloc());
    }
  }

  void unregisterInjection() => getIt.unregister<EquipmentInspectionBloc>();

  Future<void> _onLoad(
    Load event,
    Emitter<EquipmentInspectionState> emit,
  ) async {
    emit(const Loading());
    _mediaFiles = [];

    if (_caseId == null) {
      emit(const Error('Case ID is not specified'));
      return;
    }

    try {
      final equipmentInspection = await _repository.getEquipments(
        caseId: _caseId,
        type: event.type,
      );

      emit(Loaded(equipmentInspection: equipmentInspection));
    } on DioException catch (e) {
      emit(Error(e.message));
    }
  }

  Future<void> _onSave(
    Save event,
    Emitter<EquipmentInspectionState> emit,
  ) async {
    final historyBloc = getIt.get<HistoryBloc>();
    emit(const Loading());

    if (_caseId == null) {
      emit(const Error('Case ID is not specified'));
      return;
    }

    try {
      await _repository.saveEquipments(
        caseId: _caseId,
        body: event.body,
      );

      if (event.stageName != null) {
        final isStageSaved = await historyBloc.setOrderByName(event.stageName!);

        if (isStageSaved) {
          emit(const Saved());
        } else {
          emit(const Error('Этап не сохранился, попробуйте еще раз'));
        }
      } else {
        emit(const Saved());
      }
    } on DioException catch (e) {
      emit(Error(e.message));
    }
  }

  void savePhotosCount(List<MediaFile> files) {
    _mediaFiles.addAll(files);
    final docsUniqueList =
        _mediaFiles.map((e) => e.documentType).toSet().toList();
    _mediaFiles = _mediaFiles
        .where((element) => docsUniqueList.contains(element.documentType))
        .toList();
  }
}
