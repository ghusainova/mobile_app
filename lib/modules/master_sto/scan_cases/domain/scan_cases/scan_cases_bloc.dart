import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/scan_case.dart';
import '../../data/repositories/scan_case_repository.dart';

part 'generated/scan_cases_bloc.freezed.dart';
part 'scan_cases_event.dart';
part 'scan_cases_state.dart';

@lazySingleton
class ScanCasesBloc extends Bloc<ScanCasesEvent, ScanCasesState> {
  final ScanCaseRepository repository;

  ScanCasesBloc(this.repository) : super(const Loading()) {
    on<Load>(_onLoad);
    on<SetCaseInWork>(_onSetCaseInWork);
  }

  List<ScanCase>? get cases => _scanCases;

  List<ScanCase>? _scanCases;
  ScanCase? scanCase;

  Future<void> _onLoad(Load event, Emitter<ScanCasesState> emit) async {
    emit(const Loading());

    try {
      final cases = await repository.getCases();

      if (cases.isNotEmpty) {
        _scanCases = cases;
        emit(ScanCasesState.loaded(cases: cases));
      } else {
        emit(const NoContent());
      }
    } on DioException catch (e) {
      emit(Error('${e.message} \nНе удалось получить данные'));
      emit(const NoContent());
    }
  }

  Future<void> _onSetCaseInWork(
    SetCaseInWork event,
    Emitter<ScanCasesState> emit,
  ) async {
    emit(const Loading());

    if (event.isCaseInProgress == true) {
      _setCase(event.scanCase);
      emit(const GotInWork(isCaseInProgress: true));
      emit(Loaded(cases: _scanCases ?? []));
      return;
    }

    try {
      await repository.getCaseInWork(event.scanCase.caseId);
      _setCase(event.scanCase);
      emit(const GotInWork());
      emit(Loaded(cases: _scanCases ?? []));
    } on DioException catch (e) {
      emit(Error(e.message));

      if ((e.message ?? '').contains('Заявку обслуживает другой менеджер')) {
        add(const Load());
      }
    }
  }

  void _setCase(ScanCase eventCase) {
    scanCase = eventCase;
  }
}
