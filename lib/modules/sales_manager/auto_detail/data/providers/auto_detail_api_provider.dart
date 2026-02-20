import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

import '../../../../shared/_data/models/auto_info.dart';
import '../../../client_processing/data/models/approved_credit/get_auto_request_body.dart';
import '../../../catalog/data/models/catalog.dart';

part 'generated/auto_detail_api_provider.g.dart';

@RestApi()
@lazySingleton
abstract class AutoDetailApiProvider {
  @factoryMethod
  factory AutoDetailApiProvider(Dio dio) = _AutoDetailApiProvider;

  @GET('/api/v1/sm/orders/{orderId}/vehicle')
  Future<AutoInfo?> getAutoAuto({
    @Path('orderId') required String orderId,
  });

  @GET('/api/v1/sm/orders/{serviceId}/similar')
  Future<Catalog<AutoInfo>> getSimilarAutoCatalog(
    @Path('serviceId') String? serviceId,
    @Queries() GetAutoRequestBody requestBody,
  );
}
