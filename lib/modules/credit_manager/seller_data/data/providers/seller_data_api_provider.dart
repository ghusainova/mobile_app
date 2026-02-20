import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/brand_model_request_body/brand_model_request_body.dart';
import '../models/confirm_seller_response/confirm_seller_response.dart';

part 'generated/seller_data_api_provider.g.dart';

@RestApi()
abstract class SellerDataApiProvider {
  @factoryMethod
  factory SellerDataApiProvider(Dio dio) = _SellerDataApiProvider;

  @GET('/api/v1/orders/{orderId}/kaspi-info-check')
  Future<ConfirmSellerResponse> getSellerData({
    @Path('orderId') required String orderId,
  });

  @POST('/api/v1/orders/{orderId}/approve')
  Future<void> confirmSellerData({
    @Path('orderId') required String orderId,
  });

  @POST('/api/v1/auto/save-model/{orderId}')
  Future<ConfirmSellerResponse> saveBrandModel({
    @Path('orderId') required String orderId,
    @Body() required BrandModelRequestBody body,
  });
}
