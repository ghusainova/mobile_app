part of 'buyout_bloc.dart';

@freezed
class BuyoutEvent with _$BuyoutEvent {
  const factory BuyoutEvent.started() = _Started;
  const factory BuyoutEvent.getStatus() = GetStatus;
  const factory BuyoutEvent.getBuyerCatalog({
    ClientCaseRequestParams? requestBody,
  }) = GetBuyerCatalog;
}
