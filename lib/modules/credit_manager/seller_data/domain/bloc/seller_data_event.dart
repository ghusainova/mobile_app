part of 'seller_data_bloc.dart';

@freezed
class SellerDataEvent with _$SellerDataEvent {
  const factory SellerDataEvent.getSellerData() = GetSellerData;
  const factory SellerDataEvent.confirmData() = ConfirmData;
  const factory SellerDataEvent.saveBrandModel(AutoBrandModel auto) =
      SaveBrandModel;
}
