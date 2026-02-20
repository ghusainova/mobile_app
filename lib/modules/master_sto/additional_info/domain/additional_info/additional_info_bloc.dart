import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../history/domain/history/history_bloc.dart';
import '../../../scan_cases/domain/scan_cases/scan_cases_bloc.dart';
import '../../../../shared/additional_info/data/enums/additional_info_param_enum.dart';
import '../../data/models/additional_info.dart';
import '../../data/repositories/additional_info_repository.dart';

part 'additional_info_event.dart';
part 'additional_info_state.dart';
part 'generated/additional_info_bloc.freezed.dart';

class AdditionalInfoBloc
    extends Bloc<AdditionalInfoEvent, AdditionalInfoState> {
  AdditionalInfoBloc() : super(const Loading()) {
    on<Load>(_onLoad);
    on<ChangeAdditionalInfo>(_onChangeAdditionalInfo);
    on<Save>(_onSave);
  }

  final _repository = getIt.get<AdditionalInfoRepository>();
  final _scanCasesBloc = getIt.get<ScanCasesBloc>();
  AdditionalInfo additionalInfo = const AdditionalInfo();
  List<String> _engineVolumens = [];

  void registerInjection() {
    if (!getIt.isRegistered<AdditionalInfoBloc>()) {
      getIt.registerFactory(() => AdditionalInfoBloc());
    }
  }

  void unregisterInjection() => getIt.unregister<AdditionalInfoBloc>();

  Future<void> _onLoad(
    Load event,
    Emitter<AdditionalInfoState> emit,
  ) async {
    emit(const Loading());

    if (_scanCasesBloc.scanCase?.caseId == null) {
      emit(const Error('Order Id not specified'));
      return;
    }

    try {
      additionalInfo =
          await _repository.getAdditionalInfo(_scanCasesBloc.scanCase!.caseId);

      _engineVolumens = await _repository.getEngineVolumes(
        _scanCasesBloc.scanCase!.brand,
        _scanCasesBloc.scanCase!.model,
      );

      emit(
        Loaded(
          additionalInfo: additionalInfo,
          engineVolumes: _engineVolumens,
        ),
      );
    } on DioException catch (e) {
      emit(Error('${e.message} \nНе удалось получить данные'));
    }
  }

  void _onChangeAdditionalInfo(
    ChangeAdditionalInfo event,
    Emitter<AdditionalInfoState> emit,
  ) {
    final infoJson = additionalInfo.toJson();
    emit(const Loading());

    if (infoJson.containsKey(event.param.name)) {
      infoJson[event.param.name] = event.value;
    }

    additionalInfo = AdditionalInfo.fromJson(infoJson);
    emit(
      Loaded(
        additionalInfo: additionalInfo,
        engineVolumes: _engineVolumens,
      ),
    );
  }

  Future<void> _onSave(
    Save event,
    Emitter<AdditionalInfoState> emit,
  ) async {
    emit(const Loading());

    if (_scanCasesBloc.scanCase?.caseId == null) {
      emit(const Error('Order Id not specified'));
      return;
    }

    try {
      await _repository.setAdditionalInfo(
        _scanCasesBloc.scanCase!.caseId,
        additionalInfo,
      );

      if (event.setStage == true) {
        final isStageSaved = await getIt
            .get<HistoryBloc>()
            .setOrderByName('Дополнительная информация');

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
