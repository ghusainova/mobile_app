import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../credit_application/domain/credit_application/credit_application_bloc.dart';
import '../../data/constants/seller_data_error.dart';
import '../../data/models/brand_model_request_body/brand_model_request_body.dart';
import '../../data/repositories/seller_data_repository.dart';

part 'generated/seller_data_bloc.freezed.dart';
part 'seller_data_event.dart';
part 'seller_data_state.dart';

@lazySingleton
class SellerDataBloc extends Bloc<SellerDataEvent, SellerDataState> {
  final SellerDataRepository repository;
  final CreditApplicationBloc aclBloc;

  SellerDataBloc(
    this.repository,
    this.aclBloc,
  ) : super(const Initial()) {
    on<GetSellerData>(_onGetSellerData);
    on<ConfirmData>(_onConfirmData);
    on<SaveBrandModel>(_onSaveBrandModel);
  }

  Future<void> _onGetSellerData(
    GetSellerData event,
    Emitter<SellerDataState> emit,
  ) async {
    emit(const Loading());

    if (aclBloc.orderId == null) {
      emit(const Error('Order Id not specified'));
      return;
    }

    try {
      final response = await repository.getSellerData(aclBloc.orderId!);

      if (response.result?.message == 'OK') {
        emit(const SellerDataState.gotSellerData());
      } else if (response.result?.message == SellerDataError.modelError) {
        emit(const SellerDataState.dataIsNotMatched());
      } else if (response.result?.message == SellerDataError.weightError) {
        emit(const SellerDataState.denied());
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        emit(const Error('Продавец еще не выбрал авто', showModal: true));
      } else {
        emit(Error(e.message));
      }
    }
  }

  Future<void> _onConfirmData(
    ConfirmData event,
    Emitter<SellerDataState> emit,
  ) async {
    emit(const Loading());

    if (aclBloc.orderId == null) {
      emit(const Error('Order Id not specified'));
      return;
    }

    try {
      await repository.confirmSellerData(aclBloc.orderId!);

      emit(const SellerDataState.confirmed());
    } on DioException catch (e) {
      emit(Error(e.message));
    }
  }

  Future<void> _onSaveBrandModel(
    SaveBrandModel event,
    Emitter<SellerDataState> emit,
  ) async {
    emit(const Loading());

    if (aclBloc.orderId == null) {
      emit(const Error('Order Id not specified'));
      return;
    }

    try {
      final response = await repository.saveBrandModel(
        aclBloc.orderId!,
        event.auto,
      );

      if (response.result?.message == SellerDataError.modelError ||
          response.result?.message == SellerDataError.weightError) {
        emit(const Denied());
      } else {
        emit(const SellerDataState.confirmed());
      }
    } on DioException catch (e) {
      emit(Error(e.message));
    }
  }
}
