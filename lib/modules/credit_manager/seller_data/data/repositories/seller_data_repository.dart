import 'package:injectable/injectable.dart';

import '../models/brand_model_request_body/brand_model_request_body.dart';
import '../models/confirm_seller_response/confirm_seller_response.dart';
import '../providers/seller_data_api_provider.dart';

@lazySingleton
class SellerDataRepository {
  final SellerDataApiProvider provider;

  const SellerDataRepository({required this.provider});

  Future<ConfirmSellerResponse> getSellerData(String orderId) async {
    return await provider.getSellerData(orderId: orderId);
  }

  Future<void> confirmSellerData(String orderId) async {
    return await provider.confirmSellerData(orderId: orderId);
  }

  Future<ConfirmSellerResponse> saveBrandModel(
    String orderId,
    AutoBrandModel auto,
  ) async {
    return await provider.saveBrandModel(
      orderId: orderId,
      body: BrandModelRequestBody(auto),
    );
  }
}
