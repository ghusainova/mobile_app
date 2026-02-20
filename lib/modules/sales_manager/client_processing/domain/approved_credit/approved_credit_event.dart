part of 'approved_credit_bloc.dart';

@freezed
class ApprovedCreditEvent with _$ApprovedCreditEvent {
  const factory ApprovedCreditEvent.getCreditStatus(String? iin) =
      GetCreditStatus;
}
