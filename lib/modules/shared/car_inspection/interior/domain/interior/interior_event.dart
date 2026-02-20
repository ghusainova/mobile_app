part of 'interior_bloc.dart';

@freezed
class InteriorEvent with _$InteriorEvent {
  const factory InteriorEvent.load(String? orderId) = Load;
}
