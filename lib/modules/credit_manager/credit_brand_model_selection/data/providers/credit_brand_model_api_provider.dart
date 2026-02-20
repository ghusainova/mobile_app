import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../model/credit_brand_response.dart';

part 'generated/credit_brand_model_api_provider.g.dart';

@RestApi()
abstract class CreditBrandModelApiProvider {
  @factoryMethod
  factory CreditBrandModelApiProvider(Dio dio) = _CreditBrandModelApiProvider;

  @GET('/api/v1/auto/cars-brand')
  Future<CreditBrandResponse> getCreditBrands({
    @Query('page') required int page,
    @Query('size') required int size,
  });

  @GET('/api/v1/auto/brands')
  Future<CreditBrandResponse> searchCreditBrands({
    @Query('brand') required String brand,
    @Query('page') required int page,
    @Query('size') required int size,
  });

  @GET('/api/v1/auto/cars-model-by-brand')
  Future<CreditBrandResponse> getCreditModels({
    @Query('brand') required String brand,
    @Query('page') required int page,
    @Query('size') required int size,
  });
}
