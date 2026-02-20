import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/credit_additional_response.dart';

part 'generated/credit_additional_info_api_provider.g.dart';

@RestApi()
abstract class CreditAdditionalInfoApiProvider {
  @factoryMethod
  factory CreditAdditionalInfoApiProvider(Dio dio) =
      _CreditAdditionalInfoApiProvider;

  @GET('/api/v1/auto/details/{orderId}')
  Future<CreditAdditionalResponse> getAdditionalInfo({
    @Path('orderId') required String orderId,
  });

  @POST('/api/v1/auto/details/{orderId}')
  Future<void> setAdditionalInfo({
    @Path('orderId') required String orderId,
    @Body() required CreditAdditionalResponse additionalInfoResponse,
  });
}
