part of 'other_parts_bloc.dart';

@freezed
class OtherPartsEvent with _$OtherPartsEvent {
  const factory OtherPartsEvent.load(String? orderId) = Load;
}
