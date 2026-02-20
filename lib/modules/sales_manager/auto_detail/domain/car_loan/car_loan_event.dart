part of 'car_loan_bloc.dart';

@freezed
class CarLoanEvent with _$CarLoanEvent {
  const factory CarLoanEvent.started({required AutoInfo? autoInfo}) = Started;
  const factory CarLoanEvent.changeCarLoan(Credit credit) = ChangeCarLoan;
}
