import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/logs/log.dart';
import '../../../defect_inspection/_shared/data/models/paint_thickness.dart';
import '../../../scan_cases/domain/scan_cases/scan_cases_bloc.dart';
import '../../data/models/history.dart';
import '../../data/repositories/history_repository.dart';

part 'generated/history_bloc.freezed.dart';
part 'history_event.dart';
part 'history_state.dart';

@lazySingleton
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepository repository;
  final ScanCasesBloc scanCaseBloc;

  HistoryBloc(
    this.repository,
    this.scanCaseBloc,
  ) : super(const Loading()) {
    on<Load>(_handleLoadEvent);
    on<Finish>(_handleFinishEvent);
    on<CancelCase>(_cancelCase);
  }

  History? get history => state is Loaded ? (state as Loaded).history : null;
  PaintThickness? _paintThickness;
  PaintThickness? get paintThickness => _paintThickness;

  Future<void> _handleLoadEvent(Load event, Emitter<HistoryState> emit) async {
    await _onLoad(event, emit);
    await _loadPaintThickness(event, emit);
  }

  Future<void> _onLoad(Load event, Emitter<HistoryState> emit) async {
    emit(const Loading());

    if (scanCaseBloc.scanCase?.caseId == null) {
      emit(const Error('Order Id not specified'));
      return;
    }

    try {
      final history =
          await repository.getHistory(scanCaseBloc.scanCase!.caseId);

      if (history != null) {
        emit(HistoryState.loaded(history: history));
      } else {
        emit(const Error('Ошибка с данными истории'));
      }
    } on DioException catch (e) {
      emit(Error('${e.message} \nне удалось загрузить историю осмотра'));
    }
  }

  Future<void> _handleFinishEvent(
    Finish event,
    Emitter<HistoryState> emit,
  ) async {
    final caseId = scanCaseBloc.scanCase?.caseId;
    emit(const Loading());

    if (caseId == null) {
      emit(const Error('Order Id not specified'));

      return;
    }

    try {
      final response = await repository.finishCase(
        caseId: caseId,
        comment: event.comment,
      );
      if (response.response.statusCode == 200) {
        emit(const HistoryState.finished());
      } else {
        emit(Error('Не удалось завершить осмотр $caseId'));
      }
    } on DioException catch (e) {
      emit(
        Error('${e.message} \nне удалось завершить осмотр $caseId'),
      );
    }
  }

  Future<void> _cancelCase(
    CancelCase event,
    Emitter<HistoryState> emit,
  ) async {
    emit(const Loading());

    if (scanCaseBloc.scanCase?.caseId == null) {
      emit(const Error('Order Id not specified'));
      return;
    }

    try {
      final response =
          await repository.cancelCase(scanCaseBloc.scanCase!.caseId);

      if (response.response.statusCode == 200) {
        emit(const HistoryState.canceled());
      } else {
        emit(const Error('Не удалось отменить осмотр'));
      }
    } on DioException catch (e) {
      emit(Error('${e.message} \nне удалось отменить осмотр'));
    }
  }

  Future<void> _loadPaintThickness(
    Load event,
    Emitter<HistoryState> emit,
  ) async {
    if (scanCaseBloc.scanCase?.caseId == null) {
      emit(const Error('CaseId not specified'));

      return;
    }

    try {
      _paintThickness = await repository.getThicknessValues(
        scanCaseBloc.scanCase!.brand,
        scanCaseBloc.scanCase!.model,
      );
    } on DioException catch (e) {
      emit(Error(e.message));
    }
  }

  Future<bool> setOrderByName(String stageName) async {
    final caseId = scanCaseBloc.scanCase?.caseId;

    if (caseId == null) {
      logger.e('caseId not specified');
      return false;
    }

    try {
      await repository.setOrderByName(
        caseId: caseId,
        stageName: stageName,
      );

      return true;
    } catch (_) {
      return false;
    }
  }
}
