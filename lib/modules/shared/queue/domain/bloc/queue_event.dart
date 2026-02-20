part of 'queue_bloc.dart';

@freezed
class QueueEvent with _$QueueEvent {
  const factory QueueEvent.started() = _Started;
  const factory QueueEvent.getManagerState({bool? refresh}) = GetManagerState;
  const factory QueueEvent.getQueue() = GetQueue;
  const factory QueueEvent.callClient({String? iin}) = CallClient;
  const factory QueueEvent.recallClient() = RecallClient;
}
