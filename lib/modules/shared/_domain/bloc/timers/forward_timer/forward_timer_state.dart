part of 'forward_timer_bloc.dart';

@freezed
class ForwardTimerState with _$ForwardTimerState {
  const factory ForwardTimerState.inProgress({int? duration}) = InProgress;
  const factory ForwardTimerState.completed() = _Completed;
}
