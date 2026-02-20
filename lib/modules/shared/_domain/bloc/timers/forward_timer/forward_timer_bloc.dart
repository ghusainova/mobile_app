import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utility/ticker.dart';

part 'forward_timer_event.dart';
part 'forward_timer_state.dart';
part 'generated/forward_timer_bloc.freezed.dart';

class ForwardTimerBloc extends Bloc<ForwardTimerEvent, ForwardTimerState> {
  final Ticker _ticker;

  StreamSubscription<int>? _tickerSubscription;

  ForwardTimerBloc({
    required Ticker ticker,
    required int initialDuration,
  })  : _ticker = ticker,
        super(InProgress(duration: initialDuration)) {
    on<Start>(_onStarted);
    on<_OnTick>(_onTicked);
    on<_Stop>(_onStopped);
  }

  @override
  Future<void> close() {
    _disposeTicker();
    return super.close();
  }

  void _disposeTicker() {
    _tickerSubscription?.cancel();
  }

  Future<void> _onStarted(
    Start event,
    Emitter<ForwardTimerState> emit,
  ) async {
    _disposeTicker();

    emit(const InProgress());

    _tickerSubscription = _ticker.tickForward(ticks: event.duration).listen(
          (duration) => add(_OnTick(duration)),
        );
  }

  void _onTicked(
    _OnTick event,
    Emitter<ForwardTimerState> emit,
  ) {
    if (event.duration > 0) {
      emit(InProgress(duration: event.duration));
    } else {
      emit(const _Completed());
    }
  }

  Future<void> _onStopped(
    _Stop event,
    Emitter<ForwardTimerState> emit,
  ) async {
    _disposeTicker();
    emit(const ForwardTimerState.completed());
  }
}
