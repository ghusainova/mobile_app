import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../../shared/queue/domain/bloc/queue_bloc.dart';
import '../../../application_status/data/models/credit_status_item.dart';
import '../../../application_status/domain/bloc/credit_application_status_bloc.dart';
import '../../data/models/credit_application.dart';
import '../../data/repositories/credit_application_repository.dart';

part 'credit_application_event.dart';
part 'credit_application_state.dart';
part 'generated/credit_application_bloc.freezed.dart';

@Singleton()
class CreditApplicationBloc
    extends Bloc<CreditApplicationEvent, CreditApplicationState> {
  final CreditApplicationRepository repository;
  final QueueBloc queueBloc;

  CreditApplicationBloc(
    this.repository,
    this.queueBloc,
  ) : super(const Loading()) {
    on<GetCreditApplicationOrder>(_onGetCreditApplicationOrder);
    on<CompletePhotoInspection>(_onCompletePhotoInspection);
    on<SendRework>(_sendRework);
  }

  CreditApplication? carLoanOrder;

  String? get _activeClientIin => queueBloc.activeClient?.iin;
  String? get orderId => carLoanOrder?.order.id.toString();
  CreditStatusItem? get currentStatus => carLoanOrder?.status.last;

  Future<void> _onGetCreditApplicationOrder(
    GetCreditApplicationOrder event,
    Emitter<CreditApplicationState> emit,
  ) async {
    const errorText =
        'У покупателя нет одобренной заявки. Необходимо получить одобрение на kolesa.kz';
    emit(const Loading());

    if (_activeClientIin == null) {
      emit(const NoContent(message: errorText));
      carLoanOrder = null;
      _getStatusList(event.getStatusList);
      return;
    }

    try {
      final response =
          await repository.getCreditApplicationOrder(_activeClientIin!);
      carLoanOrder = response;

      if (response == null) {
        emit(const NoContent(message: 'Не удалось создать кредитную заявку'));
        carLoanOrder = null;
        return;
      }

      emit(Loaded(response));
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        emit(const NoContent(message: errorText));
        carLoanOrder = null;
      } else {
        emit(NoContent(message: '${e.message}\n${e.response}'));
      }
    }

    _getStatusList(event.getStatusList);
  }

  Future<bool> changeMaritalStatus() async {
    if (orderId == null) {
      return false;
    }

    try {
      await repository.changeMaritalStatus(orderId!);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> _onCompletePhotoInspection(
    CompletePhotoInspection event,
    Emitter<CreditApplicationState> emit,
  ) async {
    emit(const Loading());

    if (orderId == null) {
      emit(const NoContent(message: 'OrderId is null'));
      return;
    }

    try {
      await readyToEstim();
      emit(const Completed());
    } on DioException catch (e) {
      emit(NoContent(message: e.message));
    }
  }

  Future<void> _sendRework(
    SendRework event,
    Emitter<CreditApplicationState> emit,
  ) async {
    if (orderId == null) {
      emit(const NoContent(message: 'OrderId is null'));
      return;
    }
    try {
      await readyToEstim();
      emit(const ShowMessage(message: 'Заявка отправлена на проверку'));
    } on DioException catch (e) {
      emit(NoContent(message: e.message));
    }
  }

  Future<void> readyToEstim() async {
    if (orderId != null) {
      await repository.readyToEstim(orderId!);
    }
  }

  void _getStatusList(bool toggle) {
    if (toggle) {
      getIt.get<CreditApplicationStatusBloc>().add(const GetStatusList());
    }
  }
}
