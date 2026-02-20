import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../../shared/_data/models/auto_info.dart';
import '../../../catalog/data/models/credit.dart';
import '../../../client_processing/data/models/approved_credit/get_credit_request_body.dart';
import '../../data/repositories/car_loan_repository.dart';

part 'car_loan_event.dart';
part 'car_loan_state.dart';
part 'generated/car_loan_bloc.freezed.dart';

class CarLoanBloc extends Bloc<CarLoanEvent, CarLoanState> {
  CarLoanBloc() : super(const Loading()) {
    on<Started>(_start);
    on<ChangeCarLoan>(_changeCarLoan);
  }

  final _carLoanRepository = getIt.get<CarLoanRepository>();
  Credit _credit = const Credit();
  Credit get currentCredit => _credit;

  void registerInjection() {
    if (!getIt.isRegistered<CarLoanBloc>()) {
      getIt.registerFactory(() => CarLoanBloc());
    }
  }

  void unregisterInjection() => getIt.unregister<CarLoanBloc>();

  Future<void> _start(
    Started event,
    Emitter<CarLoanState> emit,
  ) async {
    final formattedPrice = int.tryParse(event.autoInfo?.priceSelling ?? '');

    if (formattedPrice != null && formattedPrice > 0) {
      _credit = Credit.fromAutoInfo(event.autoInfo);
      emit(HasContent(_credit));
    } else {
      emit(const CarLoanState.noData());
    }
  }

  Future<void> _changeCarLoan(
    ChangeCarLoan event,
    Emitter<CarLoanState> emit,
  ) async {
    _credit = event.credit;
    emit(const CarLoanState.loading());

    try {
      final credit = await _carLoanRepository.getCreditInfo(
        GetCreditRequestBody.fromCredit(_credit),
      );

      if (credit == null) {
        emit(const CarLoanState.noData());
        return;
      }

      emit(CarLoanState.hasContent(credit));
    } on DioException catch (e) {
      emit(Error(e.message));
      emit(const CarLoanState.noData());
    }
  }
}
