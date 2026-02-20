import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/credit_application.dart';

part 'generated/credit_application_api_provider.g.dart';

@RestApi()
abstract class CreditApplicationApiProvider {
  @factoryMethod
  factory CreditApplicationApiProvider(Dio dio) = _CreditApplicationApiProvider;

  @GET('/api/v1/orders')
  Future<CreditApplication> getCreditApplicationByIin({
    @Query('client-iin') required String clientIin,
  });

  @GET('/api/v1/orders/')
  Future<List<CreditApplication>> getCreditApplicationList();

  @GET('/api/v1/orders/search')
  Future<List<CreditApplication>> searchCreditApplications(
    @Query('param') String param,
  );

  @GET('/api/v1/orders/{orderId}/')
  Future<void> changeMaritalStatus(
    @Path('orderId') String orderId,
  );

  @POST('/api/v1/orders/{orderId}/ready-to-estim')
  Future<void> readyToEstim(
    @Path('orderId') String orderId,
  );
}
