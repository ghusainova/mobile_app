import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/additional_info.dart';

part 'generated/additional_info_api_provider.g.dart';

@RestApi()
abstract class AdditionalInfoApiProvider {
  @factoryMethod
  factory AdditionalInfoApiProvider(Dio dio) = _AdditionalInfoApiProvider;

  @GET('/api/v2/cars/{orderId}/additional')
  Future<AdditionalInfo> getAdditionalInfo({
    @Path('orderId') required String orderId,
  });

  @GET('/api/v2/catalog/engine-volumes')
  Future<List<String>> getEngineVolumes({
    @Query('brand') required String brand,
    @Query('model') required String model,
  });

  @PUT('/api/v2/cars/{orderId}/additional/')
  Future setAdditionalInfo({
    @Path('orderId') required String orderId,
    @Body() required AdditionalInfo additionalInfo,
  });
}
