import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../queue/data/models/branch_user.dart';
import '../../../queue/data/repositories/queue_repository.dart';
import '../../../queue/domain/bloc/queue_bloc.dart';

part 'complete_client_session_event.dart';
part 'complete_client_session_state.dart';
part 'generated/complete_client_session_bloc.freezed.dart';

@lazySingleton
class CompleteClientSessionBloc
    extends Bloc<CompleteClientSessionEvent, CompleteClientSessionState> {
  final QueueBloc queueBloc;
  final QueueRepository queueRepository;

  CompleteClientSessionBloc(
    this.queueBloc,
    this.queueRepository,
  ) : super(const _Initial()) {
    on<CompleteClientSession>(_completeClientSession);
    on<GetQueueBranch>(_getQueueBranch);
    on<RedirectClient>(_redirectClient);
  }

  Future<void> _getQueueBranch(
    GetQueueBranch event,
    Emitter<CompleteClientSessionState> emit,
  ) async {
    emit(const Loading());

    try {
      final response = await queueRepository.getQueueBranch();
      emit(BranchLoaded(response));
    } on DioException catch (e) {
      emit(_Error(e.message));
      emit(const _Initial());
      queueBloc.add(const GetManagerState());
    }
  }

  Future<void> _completeClientSession(
    CompleteClientSession event,
    Emitter<CompleteClientSessionState> emit,
  ) async {
    emit(const Loading());

    if (queueBloc.activeClient?.clientTransactionId == null) {
      emit(const _Error('No clientTransactionId'));
      emit(const _Initial());
      return;
    }

    try {
      await queueRepository.completeClientSession(
        clientTransactionId: queueBloc.activeClient!.clientTransactionId!,
        reason: event.reason,
        comment: event.comment,
        isCancel: event.isCancel,
      );

      emit(const Completed());
      emit(const _Initial());

      if (event.disableQueueRefresh != true) {
        queueBloc.add(const GetManagerState());
      }
    } on DioException catch (e) {
      emit(_Error(e.message));
      emit(const _Initial());

      if (event.disableQueueRefresh != true) {
        queueBloc.add(const GetManagerState());
      }
    }
  }

  Future<void> _redirectClient(
    RedirectClient event,
    Emitter<CompleteClientSessionState> emit,
  ) async {
    emit(const Loading());

    if (queueBloc.activeClient?.clientTransactionId == null) {
      emit(const _Error('ClientTransactionId is null'));
      return;
    }

    try {
      await queueRepository.redirectClient(
        queueBloc.activeClient!.clientTransactionId!,
        event.queueType,
        event.tableNumber,
      );

      emit(const Completed());
      queueBloc.add(const GetManagerState());
    } on DioException catch (e) {
      emit(_Error(e.message));
      queueBloc.add(const GetManagerState());
    }
  }
}
