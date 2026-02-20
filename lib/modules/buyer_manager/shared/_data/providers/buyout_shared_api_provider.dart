import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../search_case/data/model/updating_info_params.dart';

part 'generated/buyout_shared_api_provider.g.dart';

@RestApi()
@lazySingleton
abstract class BuyoutSharedApiProvider {
  @factoryMethod
  factory BuyoutSharedApiProvider(Dio dio) = _BuyoutSharedApiProvider;

  @GET('/api/v1/bm/mobile/getPersonalDataUsageConsent')
  Future getCarOwnerConsent(
    @Query('clientIin') String clientIin,
    @Query('integrationId') String integrationId,
  );

  @POST('/api/v1/bm/mobile/updateAutoData')
  Future updateAutoInfo(
    @Query('orderId') String orderId,
    @Queries() UpdatingInfoParams? updatingInfoParams,
  );

  @GET(
      '/api/v1/bm/mobile/{orderId}/finish',) //TODO: change api after get from back real api
  Future finishWork(
    @Path('orderId') String orderId,
  );
}
