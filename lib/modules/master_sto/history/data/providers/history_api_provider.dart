import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../defect_inspection/_shared/data/models/paint_thickness.dart';
import '../models/history.dart';

part 'generated/history_api_provider.g.dart';

@RestApi()
abstract class HistoryApiProvider {
  @factoryMethod
  factory HistoryApiProvider(Dio dio) = _HistoryApiProvider;

  @GET('/api/v2/steps/history/{caseId}')
  Future<History?> getHistory({
    @Path('caseId') required String caseId,
  });

  @POST('/api/v2/orders/{caseId}/cancel')
  Future<HttpResponse> cancelCase({
    @Path('caseId') required String caseId,
  });

  @POST('/api/v2/orders/{caseId}/finish')
  Future<HttpResponse> finishCase({
    @Path('caseId') required String caseId,
    @Field('comment') String? comment,
  });

  @GET('/api/v2/catalog/paint-work')
  Future<PaintThickness> getThicknessValues({
    @Query('brand') required String brand,
    @Query('model') required String model,
  });

  @PUT('/api/v2/steps/name')
  Future<void> setOrderByName({
    @Field('caseId') required String caseId,
    @Field('stageName') required String stageName,
  });
}
