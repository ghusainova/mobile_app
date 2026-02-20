part of 'qr_bloc.dart';

@freezed
class QrState with _$QrState {
  const factory QrState.initial() = _Initial;
  const factory QrState.loading() = Loading;
  const factory QrState.success() = _Success;
  const factory QrState.error(String? message) = _Error;
}
