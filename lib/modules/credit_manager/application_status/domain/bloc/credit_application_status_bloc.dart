import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../credit_application/domain/credit_application/credit_application_bloc.dart';
import '../../../shared/_data/constants/credit_status.dart';
import '../../data/models/credit_status_item.dart';
import '../../data/repositories/credit_application_status_repository.dart';

part 'credit_application_status_event.dart';
part 'credit_application_status_state.dart';
part 'generated/credit_application_status_bloc.freezed.dart';

@lazySingleton
class CreditApplicationStatusBloc
    extends Bloc<CreditApplicationStatusEvent, CreditApplicationStatusState> {
  final CreditApplicationStatusRepository repository;
  final CreditApplicationBloc creditApplicationBloc;

  CreditApplicationStatusBloc(
    this.repository,
    this.creditApplicationBloc,
  ) : super(const Loading()) {
    on<GetStatusList>(_onGetStatusList);
  }

  List<CreditStatusItem> get statusList =>
      state is Loaded ? (state as Loaded).statusList : [];

  Future<void> _onGetStatusList(
    GetStatusList event,
    Emitter<CreditApplicationStatusState> emit,
  ) async {
    emit(const Loading());

    if (creditApplicationBloc.orderId == null) {
      emit(const Error(message: 'Order Id not specified'));
      emit(const NoContent());
      return;
    }

    try {
      final statusList = await repository.getCreditApplicationStatusList(
        creditApplicationBloc.orderId!,
      );
      final rejectionStatus = statusList.firstWhereOrNull(
        (e) =>
            e.statusCode == CreditStatus.verificationReject ||
            e.statusCode == CreditStatus.scoringReject,
      );

      if (statusList.isNotEmpty && rejectionStatus == null) {
        emit(Loaded(statusList));
      } else {
        emit(
          NoContent(
            rejectionMessage: rejectionStatus?.name ?? 'Empty status list',
          ),
        );
      }
    } on DioException catch (e) {
      emit(Error(message: e.message));
    }
  }
}
