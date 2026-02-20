import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/_data/models/auto.dart';
import '../../../queue/domain/buyout/buyout_bloc.dart';
import '../../data/repositories/car_info_repository.dart';

part 'car_info_event.dart';
part 'car_info_state.dart';
part 'generated/car_info_bloc.freezed.dart';

class CarInfoBloc extends Bloc<CarInfoEvent, CarInfoState> {
  final CarInfoRepository repository;
  final BuyoutBloc buyoutBloc;

  CarInfoBloc(
    this.repository,
    this.buyoutBloc,
  ) : super(const Loading()) {
    on<Load>(_onLoad);
  }

  Auto? get carInfo => state is Loaded ? (state as Loaded).carInfo : null;

  Future<void> _onLoad(Load event, Emitter<CarInfoState> emit) async {
    emit(const Loading());
    if (buyoutBloc.autoInfo == null) {
      return;
    }
    try {
      final carInfo = await repository.getCarInfo(buyoutBloc.autoInfo!.id);

      emit(CarInfoState.loaded(carInfo: carInfo));
    } on DioException catch (e) {
      emit(Error(e.message));
    }
  }
}
