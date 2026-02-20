import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../shared/_data/models/auto.dart';

part 'generated/car_info_api_provider.g.dart';

@RestApi()
@lazySingleton
abstract class CarInfoApiProvider {
  @factoryMethod
  factory CarInfoApiProvider(Dio dio) = _CarInfoApiProvider;

  @GET('/api/v1/bm/mobile/{orderId}/info')
  Future<Auto> getCarInfo({
    @Path('orderId') required String orderId,
  });
}
