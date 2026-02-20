import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../config/injectable/injectable.dart';
import '../../../../scan_cases/domain/scan_cases/scan_cases_bloc.dart';
import '../../../_shared/data/models/defect_model.dart';
import '../../../_shared/data/repositories/defects_repository.dart';

part 'defects_map_event.dart';
part 'defects_map_state.dart';
part 'generated/defects_map_bloc.freezed.dart';

class DefectsMapBloc extends Bloc<DefectsMapEvent, DefectsMapState> {
  DefectsMapBloc() : super(const Loading()) {
    on<Load>(_onLoad);
  }

  final repository = getIt.get<DefectsRepository>();
  final scanCasesBloc = getIt.get<ScanCasesBloc>();

  List<DefectModel>? get defectList =>
      state is Loaded ? (state as Loaded).defectList : null;

  void registerInjection() {
    if (!getIt.isRegistered<DefectsMapBloc>()) {
      getIt.registerFactory(() => DefectsMapBloc());
    }
  }

  void unregisterInjection() => getIt.unregister<DefectsMapBloc>();

  FutureOr<void> _onLoad(event, Emitter<DefectsMapState> emit) async {
    emit(const Loading());

    if (scanCasesBloc.scanCase?.caseId == null) {
      emit(const Error('Order Id not specified'));
      return;
    }

    try {
      final defectList = await repository.getDefects(
        scanCasesBloc.scanCase!.caseId,
      );

      emit(Loaded(defectList: defectList));
    } on DioException catch (e) {
      emit(Error(e.message));
    }
  }
}
