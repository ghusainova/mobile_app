part of 'car_body_bloc.dart';

@freezed
class CarBodyEvent with _$CarBodyEvent {
  const factory CarBodyEvent.load(String? orderId) = Load;
}
