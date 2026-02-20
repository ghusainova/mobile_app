import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

import '../models/act_detail.dart';
import '../../../../../sales_manager/auto_detail/data/models/defects.dart';
import '../models/equipment.dart';

part 'generated/car_inspection_api_provider.g.dart';

@RestApi()
@lazySingleton
abstract class CarInspectionApiProvider {
  @factoryMethod
  factory CarInspectionApiProvider(Dio dio) = _CarInspectionApiProvider;

  @GET('/api/v1/sm/orders/{orderId}/defects')
  Future<List<TempDefectModel>?> getCarBody({
    @Path('orderId') required String orderId,
  });

  @GET('/api/v1/sm/orders/{orderId}/interior')
  Future<Map<String, List<ActDetail>>?> getInterior({
    @Path('orderId') required String orderId,
  });

  @GET('/api/v1/sm/orders/{orderId}/additional')
  Future<Map<String, List<ActDetail>>?> getOtherParts({
    @Path('orderId') required String orderId,
  });

  @GET('/api/v1/sm/orders/{orderId}/equipment')
  Future<Map<String, List<Equipment>>?> getEquipment({
    @Path('orderId') required String orderId,
  });
}
