part of 'forward_timer_bloc.dart';

@freezed
class ForwardTimerEvent with _$ForwardTimerEvent {
  const factory ForwardTimerEvent.start(int duration) = Start;
  const factory ForwardTimerEvent.onTick(int duration) = _OnTick;
  const factory ForwardTimerEvent.stop() = _Stop;
}
