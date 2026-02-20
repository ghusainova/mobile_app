import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../shared/_data/models/auto_info.dart';
import '../../../../sales_manager/catalog/data/models/catalog.dart';
import '../models/client_case_request_params.dart';
import '../models/status.dart';

part 'generated/buyout_api_provider.g.dart';

@RestApi()
@lazySingleton
abstract class BuyoutApiProvider {
  @factoryMethod
  factory BuyoutApiProvider(Dio dio) = _BuyoutApiProvider;

  @GET('/api/v1/bm/orders/regions/{region}?{param}')
  Future<Catalog<AutoInfo>> getBuyerCatalog(
    @Path('region') String region,
    @Queries() ClientCaseRequestParams? orderRequest,
  );

  @GET('/api/v1/bm/mobile/{orderId}/status')
  Future<Status?> getStatus(
    @Path('orderId') String orderId,
  );
}
