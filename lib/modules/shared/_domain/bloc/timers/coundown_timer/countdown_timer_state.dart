part of 'countdown_timer_bloc.dart';

@freezed
class CountdownTimerState with _$CountdownTimerState {
  const factory CountdownTimerState.inProgress(int duration) = _InProgress;
  const factory CountdownTimerState.completed() = _Completed;
}
