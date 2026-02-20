part of 'approved_credit_bloc.dart';

@freezed
class ApprovedCreditState with _$ApprovedCreditState {
  const factory ApprovedCreditState.loading() = Loading;
  const factory ApprovedCreditState.hasCredit({
    required List<AutoInfo> creditOrders,
  }) = HasCredit;
  const factory ApprovedCreditState.noCredit() = NoCredit;
}
