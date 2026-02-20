part of 'owner_data_bloc.dart';

@freezed
class OwnerDataEvent with _$OwnerDataEvent {
  const factory OwnerDataEvent.load({
    String? iin,
    AutoInfo? autoInfo,
  }) = Load;
}
