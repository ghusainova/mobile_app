import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/main_info.dart';

part 'generated/main_info_api_provider.g.dart';

@RestApi()
abstract class MainInfoApiProvider {
  @factoryMethod
  factory MainInfoApiProvider(Dio dio) = _MainInfoApiProvider;

  @GET('/api/v2/cars/{orderId}')
  Future<MainInfo> getMainInfo({
    @Path('orderId') required String orderId,
  });

  @PUT('/api/v2/cars/{orderId}/')
  Future setMainInfo({
    @Path('orderId') required String orderId,
    @Body() required MainInfo mainInfo,
  });
}
