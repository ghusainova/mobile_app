import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../../shared/queue/domain/bloc/queue_bloc.dart';
import '../../../../shared/_data/models/auto_info.dart';
import '../../data/models/approved_credit/get_auto_request_body.dart';
import '../../data/repositories/recommdended_autos_repository.dart';
import '../../../../../modules/shared/login/domain/user/user_bloc.dart';
import '../approved_credit/approved_credit_bloc.dart';

part 'recommended_autos_event.dart';
part 'recommended_autos_state.dart';
part 'generated/recommended_autos_bloc.freezed.dart';

@lazySingleton
class RecommendedAutosBloc
    extends Bloc<RecommendedAutosEvent, RecommendedAutosState> {
  final RecommendedAutosRepository recommendedAutosRepository;
  final UserBloc userBloc;
  final ApprovedCreditBloc approvedCreditBloc;

  RecommendedAutosBloc({
    required this.recommendedAutosRepository,
    required this.userBloc,
    required this.approvedCreditBloc,
  }) : super(const _NoContent()) {
    _monitorBlocStatuses();
    on<GetRecommendedAutos>(_onStarted);
  }

  late StreamSubscription _creditStreamSubscribtion;

  @override
  Future<void> close() {
    _creditStreamSubscribtion.cancel();
    return super.close();
  }

  void _monitorBlocStatuses() {
    _creditStreamSubscribtion = approvedCreditBloc.stream.listen(
      (authState) => authState.whenOrNull(
        hasCredit: (approvedCreditsList) {
          final autoInfo =
              approvedCreditsList.isNotEmpty ? approvedCreditsList[0] : null;
          final iin = getIt.get<QueueBloc>().activeClient?.iin;
          return add(GetRecommendedAutos(autoInfo: autoInfo, iin: iin));
        },
        noCredit: () => add(const GetRecommendedAutos()),
      ),
    );
  }

  Future<void> _onStarted(
    GetRecommendedAutos event,
    Emitter<RecommendedAutosState> emit,
  ) async {
    final requestBody =
        GetAutoRequestBody.fromAutoInfo(event.autoInfo).copyWith(
      iin: int.tryParse(event.iin ?? ''),
    );

    emit(const _Loading());

    try {
      final response = await recommendedAutosRepository.getRecommendedAutos(
        userBloc.user?.serviceId,
        requestBody,
      );

      emit(_HasContent(response.orders));
    } on DioException catch (e) {
      emit(_Error(e.message));
      emit(const _NoContent());
    }
  }
}
