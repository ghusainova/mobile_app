part of 'credit_rework_bloc.dart';

@freezed
class CreditReworkEvent with _$CreditReworkEvent {
  const factory CreditReworkEvent.load() = Load;
  const factory CreditReworkEvent.reset() = Reset;
}
