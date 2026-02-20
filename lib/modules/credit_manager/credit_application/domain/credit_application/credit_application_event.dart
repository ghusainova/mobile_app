part of 'credit_application_bloc.dart';

@freezed
class CreditApplicationEvent with _$CreditApplicationEvent {
  const factory CreditApplicationEvent.getCreditApplicationOrder({
    required bool getStatusList,
  }) = GetCreditApplicationOrder;

  const factory CreditApplicationEvent.completePhotoInspection() =
      CompletePhotoInspection;

  const factory CreditApplicationEvent.sendRework() = SendRework;
}
