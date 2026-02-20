import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../history/domain/history/history_bloc.dart';
import '../../../scan_cases/domain/scan_cases/scan_cases_bloc.dart';
import '../../data/enum/main_info_param_enum.dart';
import '../../data/models/main_info.dart';
import '../../data/repositories/main_info_repository.dart';

part 'generated/main_info_bloc.freezed.dart';
part 'main_info_event.dart';
part 'main_info_state.dart';

class MainInfoBloc extends Bloc<MainInfoEvent, MainInfoState> {
  MainInfoBloc() : super(const Loading()) {
    on<Load>(_onLoad);
    on<ChangeMainInfo>(_onChangeMainInfo);
    on<Save>(_onSave);
  }

  final _repository = getIt.get<MainInfoRepository>();
  final _scanCasesBloc = getIt.get<ScanCasesBloc>();
  MainInfo mainInfo = MainInfo();

  void registerInjection() {
    if (!getIt.isRegistered<MainInfoBloc>()) {
      getIt.registerFactory(() => MainInfoBloc());
    }
  }

  void unregisterInjection() => getIt.unregister<MainInfoBloc>();

  Future<void> _onLoad(Load event, Emitter<MainInfoState> emit) async {
    emit(const Loading());

    if (_scanCasesBloc.scanCase?.caseId == null) {
      emit(const Error('Order Id not specified'));
    }

    try {
      mainInfo = await _repository.getMainInfo(_scanCasesBloc.scanCase!.caseId);
      emit(Loaded(mainInfo: mainInfo));
    } on DioException catch (e) {
      emit(Error('${e.message} \nНе удалось получить данные'));
    }
  }

  void _onChangeMainInfo(ChangeMainInfo event, Emitter<MainInfoState> emit) {
    final infoJson = mainInfo.toJson();
    emit(const Loading());

    if (infoJson.containsKey(event.key.name)) {
      infoJson[event.key.name] = event.value;
    }

    mainInfo = MainInfo.fromJson(infoJson);
    emit(MainInfoState.loaded(mainInfo: mainInfo));
  }

  Future<void> _onSave(Save event, Emitter<MainInfoState> emit) async {
    emit(const Loading());

    if (_scanCasesBloc.scanCase?.caseId == null) {
      emit(const Error('caseId not specified'));
    }

    try {
      await _repository.setMainInfo(
        _scanCasesBloc.scanCase!.caseId,
        mainInfo.bodyNumber.isEmpty
            ? mainInfo.copyWith(bodyNumber: mainInfo.vin)
            : mainInfo,
      );

      if (event.setStage == true) {
        final isStageSaved =
            await getIt.get<HistoryBloc>().setOrderByName('Информация об авто');

        if (!isStageSaved) {
          emit(const Error('Этап не сохранился, попробуйте еще раз'));
          return;
        }
      }

      emit(const Saved());
    } on DioException catch (e) {
      emit(Error('${e.message} \nНе удалось сохранить данные'));
    }
  }
}
