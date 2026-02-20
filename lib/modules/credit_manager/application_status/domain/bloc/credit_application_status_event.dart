part of 'credit_application_status_bloc.dart';

@freezed
class CreditApplicationStatusEvent with _$CreditApplicationStatusEvent {
  const factory CreditApplicationStatusEvent.getStatusList() = GetStatusList;
}
