import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utility/ticker.dart';

part 'countdown_timer_event.dart';
part 'countdown_timer_state.dart';
part 'generated/countdown_timer_bloc.freezed.dart';

class CountdownTimerBloc
    extends Bloc<CountdownTimerEvent, CountdownTimerState> {
  final Ticker _ticker;
  static const _duration = 20; //seconds

  StreamSubscription<int>? _tickerSubscription;

  CountdownTimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(const _InProgress(_duration)) {
    on<Start>(_onStarted);
    on<_OnTick>(_onTicked);
    on<_Stop>(_onCompleted);
  }

  @override
  Future<void> close() {
    _disposeTicker();
    return super.close();
  }

  Future<void> _onStarted(
    Start event,
    Emitter<CountdownTimerState> emit,
  ) async {
    _disposeTicker();

    emit(_InProgress(event.duration));

    _tickerSubscription = _ticker.tickBackward(ticks: event.duration).listen(
          (duration) => add(_OnTick(duration)),
        );
  }

  void _onTicked(
    _OnTick event,
    Emitter<CountdownTimerState> emit,
  ) {
    if (event.duration > 0) {
      emit(_InProgress(event.duration));
    } else {
      emit(const _Completed());
    }
  }

  Future<void> _onCompleted(
    _Stop event,
    Emitter<CountdownTimerState> emit,
  ) async {
    _disposeTicker();
    emit(const CountdownTimerState.completed());
  }

  void _disposeTicker() {
    _tickerSubscription?.cancel();
  }
}
