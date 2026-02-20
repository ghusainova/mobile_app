import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../sales_manager/auto_detail/data/models/media_capture_v1_response.dart';

part 'generated/buyer_media_capture_vin_api_provider.g.dart';

@RestApi()
abstract class BuyerMediaCaptureApiProvider {
  @factoryMethod
  factory BuyerMediaCaptureApiProvider(Dio dio) = _BuyerMediaCaptureApiProvider;

  @GET('/api/v1/files/{caseId}')
  Future<MediaCaptureV1Response> getFiles(
    @Path('caseId') String caseId,
    @Query('documentType') String docType,
  );

  @POST('/api/v1/files/upload')
  Future<void> uploadFile(
    @Header('Content-Type') String contentType,
    @Body() FormData formData,
  );

  @DELETE('/api/v1/files/{caseId}')
  Future<void> deleteFile(
    @Path('caseId') String caseId,
    @Field('documentId') String documentId,
  );
}
