part of 'auto_detail_bloc.dart';

@freezed
class AutoDetailEvent with _$AutoDetailEvent {
  const factory AutoDetailEvent.load({
    AutoInfo? autoInfo,
    String? orderId,
  }) = Load;
  const factory AutoDetailEvent.reload() = Reload;
}
