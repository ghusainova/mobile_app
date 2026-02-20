import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../shared/_data/models/auto_info.dart';
import '../../data/models/client_case_request_params.dart';
import '../../data/models/status.dart';
import '../../data/repositories/buyout_repository.dart';

part 'buyout_event.dart';
part 'buyout_state.dart';
part 'generated/buyout_bloc.freezed.dart';

@lazySingleton
class BuyoutBloc extends Bloc<BuyoutEvent, BuyoutState> {
  final BuyoutRepository repository;

  BuyoutBloc(this.repository) : super(const _Loading()) {
    on<GetBuyerCatalog>(_getBuyerCatalog);
    on<GetStatus>(_getStatus);
  }

  AutoInfo? autoInfo;
  Status? status;

  Future<void> _getBuyerCatalog(
    GetBuyerCatalog event,
    Emitter<BuyoutState> emit,
  ) async {
    emit(const _Loading());
    autoInfo = null;

    try {
      final response = await repository.getBuyerCatalog(event.requestBody);
      if (response.orders.isNotEmpty) {
        autoInfo = response.orders[0];
        status = await repository.getStatus(autoInfo!.id);
        //TODO: fix: если делать через event (add(getStatus))
        //то тогда не дожидается ответа getStatus и отрисовывется раньше, чем надо
        emit(_HasOrder(autoInfo!));
      } else {
        emit(const _NoOrder());
      }
    } on DioException catch (e) {
      emit(_Error(e.message));
      emit(const _NoOrder());
    }
  }

  Future<void> _getStatus(GetStatus event, Emitter<BuyoutState> emit) async {
    if (autoInfo?.id == null) {
      emit(const _Error('OrderId is not specified'));
      return;
    }
    try {
      status = await repository.getStatus(autoInfo!.id);
    } on DioException catch (e) {
      emit(_Error(e.message));
      emit(const _NoOrder());
    }
  }
}
