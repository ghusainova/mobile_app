import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../config/injectable/injectable.dart';
import '../../../shared/data/models/act_detail.dart';
import '../../../shared/data/repositories/car_inspection_repository.dart';

part 'generated/other_parts_bloc.freezed.dart';
part 'other_parts_event.dart';
part 'other_parts_state.dart';

class OtherPartsBloc extends Bloc<OtherPartsEvent, OtherPartsState> {
  OtherPartsBloc() : super(const Loading()) {
    on<Load>(_load);
  }

  static final _carInspectionRepository = getIt.get<CarInspectionRepository>();

  void registerInjection() {
    if (!getIt.isRegistered<OtherPartsBloc>()) {
      getIt.registerFactory(() => OtherPartsBloc());
    }
  }

  void unregisterInjection() => getIt.unregister<OtherPartsBloc>();

  Future<void> _load(Load event, Emitter<OtherPartsState> emit) async {
    if (event.orderId == null) {
      emit(const Error('Order Id not specified'));
      return;
    }

    try {
      emit(const Loading());

      final response =
          await _carInspectionRepository.getOtherParts(event.orderId!);

      if (response != null) {
        emit(OtherPartsState.loaded(otherPartsInfo: response));
      }
    } on DioException catch (e) {
      emit(OtherPartsState.error(e.message));
    }
  }
}
