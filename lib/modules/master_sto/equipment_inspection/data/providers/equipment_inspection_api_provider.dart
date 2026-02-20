import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/equipment_inspection.dart';

part 'generated/equipment_inspection_api_provider.g.dart';

@RestApi()
abstract class EquipmentInspectionApiProvider {
  @factoryMethod
  factory EquipmentInspectionApiProvider(Dio dio) =
      _EquipmentInspectionApiProvider;

  @GET('/api/v2/cars/{caseId}/equipment')
  Future<EquipmentInspection> getEquipments({
    @Path('caseId') required String caseId,
    @Query('type') required String type,
  });

  @PUT('/api/v2/cars/{caseId}/equipment/')
  Future<void> saveEquipments({
    @Path('caseId') required String caseId,
    @Body() required EquipmentInspection body,
  });
}
