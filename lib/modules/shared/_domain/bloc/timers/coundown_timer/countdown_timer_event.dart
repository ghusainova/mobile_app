part of 'countdown_timer_bloc.dart';

@freezed
class CountdownTimerEvent with _$CountdownTimerEvent {
  const factory CountdownTimerEvent.start(int duration) = Start;
  const factory CountdownTimerEvent.onTick(int duration) = _OnTick;
  const factory CountdownTimerEvent.stop() = _Stop;
}
