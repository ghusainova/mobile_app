import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../../../config/logs/log.dart';
import '../../../../../services/local_storage/system_options/system_options.dart';
import '../../data/models/branch_user.dart';
import '../../data/models/active_client_dto.dart';
import '../../../../sales_manager/client_processing/data/enum/manager_state.dart';
import '../../data/repositories/queue_repository.dart';
import '../../../../sales_manager/client_processing/domain/qr/qr_bloc.dart';
import '../../../login/domain/auth/auth_bloc.dart';

part 'queue_event.dart';
part 'queue_state.dart';
part 'generated/queue_bloc.freezed.dart';

@singleton
class QueueBloc extends Bloc<QueueEvent, QueueState> {
  final QueueRepository queueRepository;
  final AuthBloc authBloc;
  final QrBloc qrBloc;

  QueueBloc({
    required this.queueRepository,
    required this.authBloc,
    required this.qrBloc,
  }) : super(const Loading()) {
    _monitorBlocStatuses();
    on<_Started>(_onStarted);
    on<GetManagerState>(_getManagerState);
    on<GetQueue>(_getQueue);
    on<CallClient>(_callClient);
    on<RecallClient>(_recallClient);
  }

  late StreamSubscription _authStreamSubscribtion;
  late StreamSubscription _qrStreamSubscribtion;

  int? _queueLength;
  BranchUser? _branchUser;
  ActiveClientDTO? _activeClient;

  BranchUser? get branchUser => _branchUser;
  ActiveClientDTO? get activeClient => _activeClient;

  @override
  Future<void> close() {
    _authStreamSubscribtion.cancel();
    _qrStreamSubscribtion.cancel();
    return super.close();
  }

  void _monitorBlocStatuses() {
    _authStreamSubscribtion = authBloc.stream.listen(
      (authState) => authState.whenOrNull(
        initial: (_) => add(const _Started()),
      ),
    );

    _qrStreamSubscribtion = qrBloc.stream.listen(
      (qrState) => qrState.whenOrNull(
        success: () => add(const _Started()),
      ),
    );
  }

  void _onStarted(_Started event, Emitter<QueueState> emit) {
    _activeClient = null;
    emit(const _Initial());
  }

  Future<void> _getManagerState(
    GetManagerState event,
    Emitter<QueueState> emit,
  ) async {
    emit(const Loading());

    if (event.refresh != true) {
      add(const _Started());
    }

    try {
      final managerState = await queueRepository.getManagerState();
      _branchUser = await queueRepository.getBranchUser();

      if (managerState == ManagerState.activeClient) {
        final activeClient = await _getActiveClient();

        if (activeClient?.clientTransactionId != null) {
          _activeClient = activeClient!;
          emit(HandlingClient(activeClient));
          return;
        }
      }

      add(const GetQueue());
    } on DioException catch (e) {
      if (e.response?.statusCode == 400 ||
          // ignore: unnecessary_string_escapes
          (e.response?.data.toString().contains('because \"user\" is null') ??
              false)) {
        await _queueLogin((qe) => emit(Error(qe)));
      } else {
        emit(const FetchingQueue());
        emit(Error(e.message));
      }
    }
  }

  Future<void> _getQueue(
    GetQueue event,
    Emitter<QueueState> emit,
  ) async {
    _queueLength = null;

    try {
      _queueLength = await queueRepository.getQueueLength();
      emit(FetchingQueue(length: _queueLength));
    } on DioException catch (e) {
      emit(const FetchingQueue());
      emit(Error(e.message));
    }
  }

  Future<void> _callClient(
    CallClient event,
    Emitter<QueueState> emit,
  ) async {
    final iin = event.iin ?? '';
    emit(const Loading());

    if ((_queueLength ?? 0) == 0 && iin.isEmpty) {
      add(const GetQueue());
      return;
    }

    try {
      final activeClient = await queueRepository.callClient(iin: iin);
      _activeClient = activeClient;

      if (activeClient != null) {
        emit(HandlingClient(activeClient));
      } else {
        emit(const Error('No active client'));
      }
    } on DioException catch (e) {
      emit(Error('${e.message}\n${e.response}'));
    }
  }

  Future<void> _recallClient(
    RecallClient event,
    Emitter<QueueState> emit,
  ) async {
    try {
      if (_activeClient?.clientTransactionId == null) {
        emit(const FetchingQueue());
        emit(const Error('No clientTransactionId'));
      }

      await queueRepository.recallClient(_activeClient!.clientTransactionId!);
    } on DioException catch (e) {
      emit(const FetchingQueue());
      emit(Error(e.message));
    }
  }

  Future<String?> getDeviceIp() async {
    try {
      return await queueRepository.getDeviceIp();
    } on DioException catch (e) {
      logger.e(e);
    }

    return null;
  }

  Future<void> setDeviceInfo(String queueIpAddress) async {
    try {
      await queueRepository.setDeviceInfo(queueIpAddress);
    } on DioException catch (e) {
      logger.e(e);
    }
  }

  Future<ActiveClientDTO?> _getActiveClient() async {
    _activeClient = null;

    try {
      return await queueRepository.getActiveClient();
    } on Exception catch (e) {
      logger.e(e);

      return null;
    }
  }

  Future<void> _queueLogin(
    void Function(String? error) onError,
  ) async {
    final queueIp = await getDeviceIp();
    final cachedIp = await getIt.get<SystemOptions>().getCachedIpAddress();

    if (queueIp == null && cachedIp != null) {
      await setDeviceInfo(cachedIp);
    }

    try {
      await queueRepository.queueAuth();
      add(const GetManagerState());
    } catch (e) {
      onError(e.toString());
    }
  }
}
