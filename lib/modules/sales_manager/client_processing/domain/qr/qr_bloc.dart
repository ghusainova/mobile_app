import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../../shared/queue/domain/bloc/queue_bloc.dart';
import '../../data/repositories/qr_repository.dart';

part 'qr_event.dart';
part 'qr_state.dart';
part 'generated/qr_bloc.freezed.dart';

@lazySingleton
class QrBloc extends Bloc<QrEvent, QrState> {
  final QrRepository qrRepository;

  QrBloc(this.qrRepository) : super(const _Initial()) {
    on<GetApprovalForCarLoan>(_getApprovalForCarLoan);
    on<ApplyWithoutCarLoan>(_applyWithoutCarLoan);
  }

  Future<void> _getApprovalForCarLoan(
    GetApprovalForCarLoan event,
    Emitter<QrState> emit,
  ) async {
    emit(const Loading());

    final activeClient = getIt.get<QueueBloc>().activeClient;

    try {
      final response = await qrRepository.getApprovalForCarLoan(
        event.id,
        activeClient?.iin,
        event.advertLink,
        activeClient?.clientTransactionId,
      );

      if (response.message.isEmpty ||
          response.message.contains(
            'Клиент отправлен на менеджера оформления документов',
          )) {
        emit(const _Success());
      } else {
        emit(_Error(response.message));
      }
    } on DioException catch (e) {
      emit(_Error(e.message));
    }

    getIt.get<QueueBloc>().add(const GetManagerState());
  }

  Future<void> _applyWithoutCarLoan(
    ApplyWithoutCarLoan event,
    Emitter<QrState> emit,
  ) async {
    emit(const Loading());

    final activeClient = getIt.get<QueueBloc>().activeClient;

    try {
      await qrRepository.applyWithoutCarLoan(
        event.id,
        activeClient?.iin,
        activeClient?.clientTransactionId,
      );

      emit(const _Success());
    } on DioException catch (e) {
      emit(_Error(e.message));
    }

    getIt.get<QueueBloc>().add(const GetManagerState());
  }
}
