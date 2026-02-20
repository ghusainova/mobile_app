import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/credit_status_response.dart';

part 'generated/credit_application_status_api_provider.g.dart';

@RestApi()
abstract class CreditApplicationStatusApiProvider {
  @factoryMethod
  factory CreditApplicationStatusApiProvider(Dio dio) =
      _CreditApplicationStatusApiProvider;

  @GET('/api/v1/orders/status/{orderId}')
  Future<CreditStatusResponse> getCreditApplicationStatusList(
    @Path('orderId') orderId,
  );

}
