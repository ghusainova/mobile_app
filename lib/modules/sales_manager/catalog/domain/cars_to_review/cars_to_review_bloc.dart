import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../modules/shared/login/domain/auth/auth_bloc.dart';
import '../../../../shared/queue/domain/bloc/queue_bloc.dart';
import '../../../../shared/_data/models/auto_info.dart';

part 'cars_to_review_event.dart';
part 'cars_to_review_state.dart';
part 'generated/cars_to_review_bloc.freezed.dart';

@lazySingleton
class CarsToReviewBloc extends Bloc<CarsToReviewEvent, CarsToReviewState> {
  final AuthBloc authBloc;
  final QueueBloc queueBloc;

  CarsToReviewBloc({
    required this.authBloc,
    required this.queueBloc,
  }) : super(const _Initial()) {
    _monitorBlocStatuses();
    on<AddToReview>(_onAddToReview);
    on<RemoveFromReview>(_onRemoveFromReview);
    on<ClearReviewList>(_onClearReviewList);
  }

  late final StreamSubscription _authStreamSubscribtion;
  late final StreamSubscription _queueStreamSubscribtion;
  final List<AutoInfo> _autoInfoList = [];

  @override
  Future<void> close() {
    _authStreamSubscribtion.cancel();
    _queueStreamSubscribtion.cancel();
    return super.close();
  }

  void _monitorBlocStatuses() {
    _authStreamSubscribtion = authBloc.stream.listen(
      (authState) => authState.whenOrNull(
        initial: (_) => add(const ClearReviewList()),
      ),
    );

    _queueStreamSubscribtion = queueBloc.stream.listen(
      (queueState) => queueState.whenOrNull(
        initial: () => add(const ClearReviewList()),
      ),
    );
  }

  void _onAddToReview(
    AddToReview event,
    Emitter<CarsToReviewState> emit,
  ) {
    emit(const _Loading());
    _autoInfoList.add(event.autoInfo);
    emit(HasCarsToReview(_autoInfoList));
  }

  void _onRemoveFromReview(
    RemoveFromReview event,
    Emitter<CarsToReviewState> emit,
  ) {
    emit(const _Loading());
    _autoInfoList.removeWhere((element) => element.id == event.autoInfoId);

    if (_autoInfoList.isNotEmpty) {
      emit(HasCarsToReview(_autoInfoList));
    } else {
      emit(const _Initial());
    }
  }

  void _onClearReviewList(
    ClearReviewList event,
    Emitter<CarsToReviewState> emit,
  ) {
    _autoInfoList.clear();
    emit(const _Initial());
  }
}
