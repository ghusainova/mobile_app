import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../config/injectable/injectable.dart';
import '../../../../../sales_manager/auto_detail/data/models/defects.dart';
import '../../../shared/data/repositories/car_inspection_repository.dart';

part 'car_body_event.dart';
part 'car_body_state.dart';
part 'generated/car_body_bloc.freezed.dart';

class CarBodyBloc extends Bloc<CarBodyEvent, CarBodyState> {
  CarBodyBloc() : super(const Loading()) {
    on<Load>(_load);
  }

  static final _carInspectionRepository = getIt.get<CarInspectionRepository>();

  void registerInjection() {
    if (!getIt.isRegistered<CarBodyBloc>()) {
      getIt.registerFactory(() => CarBodyBloc());
    }
  }

  void unregisterInjection() => getIt.unregister<CarBodyBloc>();

  Future _load(Load event, Emitter<CarBodyState> emit) async {
    emit(const Loading());

    if (event.orderId == null) {
      emit(const Error('Order Id not specified'));
      return;
    }

    try {
      final defects = await _carInspectionRepository.getCarBody(event.orderId!);
      if (defects != []) {
        emit(CarBodyState.loaded(defects: defects!));
      } else {
        emit(const CarBodyState.error('Возвращен пустой массив'));
      }
    } on DioException catch (e) {
      emit(CarBodyState.error(e.message));
    }
  }
}
