part of 'buyout_bloc.dart';

@freezed
class BuyoutState with _$BuyoutState {
  const factory BuyoutState.loading() = _Loading;
  const factory BuyoutState.hasOrder(AutoInfo order) = _HasOrder;
  const factory BuyoutState.noOrder() = _NoOrder;
  const factory BuyoutState.error(String? error) = _Error;
}
