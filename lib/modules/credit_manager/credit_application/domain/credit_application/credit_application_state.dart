part of 'credit_application_bloc.dart';

@freezed
class CreditApplicationState with _$CreditApplicationState {
  const factory CreditApplicationState.loading() = Loading;
  const factory CreditApplicationState.loaded(
    CreditApplication carLoanOrder,
  ) = Loaded;
  const factory CreditApplicationState.completed() = Completed;
  const factory CreditApplicationState.noContent({
    String? message,
  }) = NoContent;
  const factory CreditApplicationState.showMessage({
    required  String message,
  }) = ShowMessage;
}
