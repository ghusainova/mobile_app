part of 'queue_bloc.dart';

@freezed
class QueueState with _$QueueState {
  const factory QueueState.initial() = _Initial;
  const factory QueueState.loading() = Loading;
  const factory QueueState.fetchingQueue({int? length}) = FetchingQueue;
  const factory QueueState.handlingClient(ActiveClientDTO activeClient) =
      HandlingClient;
  const factory QueueState.error(String? message, {bool? showCustomMessage}) =
      Error;
}
