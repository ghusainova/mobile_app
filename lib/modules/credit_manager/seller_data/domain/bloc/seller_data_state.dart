part of 'seller_data_bloc.dart';

@freezed
class SellerDataState with _$SellerDataState {
  const factory SellerDataState.initial() = Initial;
  const factory SellerDataState.loading() = Loading;
  const factory SellerDataState.error(
    String? message, {
    bool? showModal,
  }) = Error;
  const factory SellerDataState.gotSellerData() = GotSellerData;
  const factory SellerDataState.confirmed() = Confirmed;
  const factory SellerDataState.dataIsNotMatched() = DataIsNotMatched;
  const factory SellerDataState.denied() = Denied;
}
