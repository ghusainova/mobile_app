import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/logs/log.dart';
import '../../../../shared/_data/models/auto_info.dart';
import '../../data/repositories/approved_credit_repository.dart';

part 'approved_credit_event.dart';
part 'approved_credit_state.dart';
part 'generated/approved_credit_bloc.freezed.dart';

@singleton
class ApprovedCreditBloc
    extends Bloc<ApprovedCreditEvent, ApprovedCreditState> {
  final ApprovedCreditRepository approvedCreditRepository;

  ApprovedCreditBloc({
    required this.approvedCreditRepository,
  }) : super(const Loading()) {
    on<GetCreditStatus>(_onGetCreditStatus);
  }

  Future<void> _onGetCreditStatus(
    GetCreditStatus event,
    Emitter<ApprovedCreditState> emit,
  ) async {
    if (event.iin == null) {
      emit(const NoCredit());
      return;
    }

    try {
      final response =
          await approvedCreditRepository.getApprovedCredit(event.iin!);

      if (response.orders.isNotEmpty) {
        emit(HasCredit(creditOrders: response.orders));
      } else {
        emit(const NoCredit());
      }
    } on Exception catch (e) {
      logger.e(e);
      emit(const NoCredit());
    }
  }
}
