import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/owner_data.dart';

part 'generated/owner_data_api_provider.g.dart';

@RestApi()
@lazySingleton
abstract class OwnerDataApiProvider {
  @factoryMethod
  factory OwnerDataApiProvider(Dio dio) = _OwnerDataApiProvider;

  @GET('/api/v1/bm/mobile/searchAuto')
  Future<OwnerData> getOwnerData(
    @Query('clientIin') String clientIin,
    @Query('orderId') String orderId,
  );
}
