part of 'car_loan_bloc.dart';

@freezed
class CarLoanState with _$CarLoanState {
  const factory CarLoanState.loading() = Loading;
  const factory CarLoanState.noData() = NoData;
  const factory CarLoanState.hasContent(Credit credit) = HasContent;
  const factory CarLoanState.error(String? errorMessage) = Error;
}
