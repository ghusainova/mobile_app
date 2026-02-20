part of 'credit_model_bloc.dart';

@freezed
class CreditModelEvent with _$CreditModelEvent {
  const factory CreditModelEvent.load(String brand) = _Load;
}
