import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/credit_rework_response.dart';

part 'generated/credit_rework_api_provider.g.dart';

@RestApi()
abstract class CreditReworkApiProvider {
  @factoryMethod
  factory CreditReworkApiProvider(Dio dio) = _CreditReworkApiProvider;

  @GET('/api/v1/verification')
  Future<CreditReworkResponse> getCreditReworkItems({
    @Query('orderId') required String orderId,
  });
}
