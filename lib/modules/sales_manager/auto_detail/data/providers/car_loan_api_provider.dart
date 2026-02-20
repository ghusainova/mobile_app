import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

import '../../../catalog/data/models/credit.dart';
import '../../../client_processing/data/models/approved_credit/get_credit_request_body.dart';

part 'generated/car_loan_api_provider.g.dart';

@RestApi()
@lazySingleton
abstract class CarLoanApiProvider {
  @factoryMethod
  factory CarLoanApiProvider(Dio dio) = _CarLoanApiProvider;

  @POST('/api/v1/sm/orders/calculator')
  Future<Credit?> getCreditInfo(
    @Body() GetCreditRequestBody requestBody,
  );
}
