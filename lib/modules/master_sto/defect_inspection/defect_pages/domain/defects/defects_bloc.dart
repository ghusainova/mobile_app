import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../config/injectable/injectable.dart';
import '../../../../../shared/media_capture_vin/data/models/media_file.dart';
import '../../../../history/domain/history/history_bloc.dart';
import '../../../../scan_cases/domain/scan_cases/scan_cases_bloc.dart';
import '../../../_shared/data/enum/car_body_part.dart';
import '../../../_shared/data/models/defect.dart';
import '../../../_shared/data/models/defect_model.dart';
import '../../../_shared/data/models/defect_point.dart';
import '../../../_shared/data/repositories/defects_repository.dart';

part 'defects_event.dart';
part 'defects_state.dart';
part 'generated/defects_bloc.freezed.dart';

class DefectsBloc extends Bloc<DefectsEvent, DefectsState> {
  DefectsBloc() : super(const Loading()) {
    on<Load>(_onLoad);
    on<SetDefect>(_onSetDefect);
    on<UpdateDefectStatus>(_updateDefectStatus);
    on<ResetDefectStatus>(_resetDefectStatus);
    on<Save>(_onSave);
  }

  final _repository = getIt.get<DefectsRepository>();
  final _scanCasesBloc = getIt.get<ScanCasesBloc>();

  DefectModel defect = const DefectModel();

  List<MediaFile> mediaFiles = [];

  void registerInjection() {
    if (!getIt.isRegistered<DefectsBloc>()) {
      getIt.registerFactory(() => DefectsBloc());
    }
  }

  void unregisterInjection() => getIt.unregister<DefectsBloc>();

  Future<void> _onLoad(Load event, Emitter<DefectsState> emit) async {
    if (_scanCasesBloc.scanCase?.caseId == null) {
      emit(const Error('Order Id not specified'));
      return;
    }

    try {
      defect = await _repository.getDefect(
        _scanCasesBloc.scanCase!.caseId,
        event.bodyPart.label,
      );

      emit(Loaded(defectModel: defect));
    } on DioException catch (e) {
      emit(Error('${e.message} \nНе удалось получить данные'));
    }
  }

  void _onSetDefect(
    SetDefect event,
    Emitter<DefectsState> emit,
  ) {
    defect = event.defect;
    emit(Loaded(defectModel: defect));
  }

  void _onSave(Save event, Emitter<DefectsState> emit) async {
    emit(const Loading());

    if (_scanCasesBloc.scanCase?.caseId == null) {
      emit(const Error('Order Id not specified'));
      return;
    }

    try {
      await _repository.setDefects(
        _scanCasesBloc.scanCase!.caseId,
        defect,
      );

      if (event.setStage == true) {
        final isStageSaved =
            await getIt.get<HistoryBloc>().setOrderByName(defect.bodyPart);

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

  void _updateDefectStatus(
    UpdateDefectStatus event,
    Emitter<DefectsState> emit,
  ) {
    final updatedDefectModel = DefectModel.updateDefects(
      defects: event.defects,
      defectModel: defect,
    );
    add(DefectsEvent.setDefect(updatedDefectModel));
  }

  void _resetDefectStatus(ResetDefectStatus event, Emitter<DefectsState> emit) {
    final updatedDefectModel = DefectModel.resetDefectStatus(defect);
    add(DefectsEvent.setDefect(updatedDefectModel));
  }

  int? getPointMicroMeter(int index) {
    final points = defect.points;
    final micrometer = points?.firstWhere(
      (DefectPoint point) {
        return point.measuringPoint == index;
      },
      orElse: () => const DefectPoint(),
    ).micrometer;
    return micrometer;
  }
}
