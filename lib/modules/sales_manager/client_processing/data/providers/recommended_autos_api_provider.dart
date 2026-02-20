import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../shared/_data/models/auto_info.dart';
import '../../../catalog/data/models/catalog.dart';
import '../models/approved_credit/get_auto_request_body.dart';

part 'generated/recommended_autos_api_provider.g.dart';

@RestApi()
@lazySingleton
abstract class RecommendedAutosApiProvider {
  @factoryMethod
  factory RecommendedAutosApiProvider(Dio dio) = _RecommendedAutosApiProvider;

  @GET('/api/v1/sm/orders/{serviceId}/recommended')
  Future<Catalog<AutoInfo>> getRecommendedAutos(
    @Path('serviceId') String? serviceId,
    @Queries() GetAutoRequestBody requestBody,
  );
}
