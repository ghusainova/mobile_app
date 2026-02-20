part of 'complete_client_session_bloc.dart';

@freezed
class CompleteClientSessionEvent with _$CompleteClientSessionEvent {
  const factory CompleteClientSessionEvent.started() = _Started;
  const factory CompleteClientSessionEvent.completeClientSession({
    String? reason,
    String? comment,
    bool? disableQueueRefresh,
    bool? isCancel,
  }) = CompleteClientSession;
  const factory CompleteClientSessionEvent.getQueueBranch() = GetQueueBranch;
  const factory CompleteClientSessionEvent.redirectClient({
    required int queueType,
    required int tableNumber,
  }) = RedirectClient;
}
