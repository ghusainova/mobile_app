import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../config/injectable/injectable.dart';
import '../../../shared/data/models/act_detail.dart';
import '../../../shared/data/repositories/car_inspection_repository.dart';

part 'generated/interior_bloc.freezed.dart';
part 'interior_event.dart';
part 'interior_state.dart';

class InteriorBloc extends Bloc<InteriorEvent, InteriorState> {
  InteriorBloc() : super(const Loading()) {
    on<Load>(_load);
  }

  static final _carInspectionRepository = getIt.get<CarInspectionRepository>();

  void registerInjection() {
    if (!getIt.isRegistered<InteriorBloc>()) {
      getIt.registerFactory(() => InteriorBloc());
    }
  }

  void unregisterInjection() => getIt.unregister<InteriorBloc>();

  Future _load(Load event, Emitter<InteriorState> emit) async {
    if (event.orderId == null) {
      emit(const Error('Order Id not specified'));
      return;
    }

    try {
      emit(const Loading());

      final response =
          await _carInspectionRepository.getInterior(event.orderId!);
      if (response != null) {
        emit(
          InteriorState.loaded(
            orderId: event.orderId!,
            actDetailInfo: response,
          ),
        );
      }
    } on DioException catch (e) {
      emit(InteriorState.error(e.message));
    }
  }
}
