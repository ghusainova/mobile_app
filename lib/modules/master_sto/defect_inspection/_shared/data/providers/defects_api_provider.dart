import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/defect_model.dart';

part 'generated/defects_api_provider.g.dart';

@RestApi()
abstract class DefectsApiProvider {
  @factoryMethod
  factory DefectsApiProvider(Dio dio) = _DefectsApiProvider;

  @GET('/api/v2/cars/{orderId}/defect')
  Future<DefectModel> getDefect({
    @Path('orderId') required String orderId,
    @Query('bodyPart') required String bodyPart,
  });

  @PUT('/api/v2/cars/{orderId}/defect/')
  Future<void> setDefect({
    @Path('orderId') required String orderId,
    @Body() required DefectModel defect,
  });

  @GET('/api/v2/cars/{orderId}/defects')
  Future<List<DefectModel>> getDefects({
    @Path('orderId') required String orderId,
  });
}
