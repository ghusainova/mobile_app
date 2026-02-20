import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/media_capture_vin_response.dart';

part 'generated/media_capture_vin_api_provider.g.dart';

@RestApi()
abstract class MediaCaptureApiProvider {
  @factoryMethod
  factory MediaCaptureApiProvider(Dio dio) = _MediaCaptureApiProvider;

  @GET('/api/v2/media/{caseId}')
  Future<MediaCaptureVinResponse> getFiles(
    @Path('caseId') String caseId,
    @Query('docType') String docType,
  );

  @POST('/api/v2/media/{caseId}')
  Future<void> uploadFile(
    @Path('caseId') String caseId,
    @Header('Content-Type') String contentType,
    @Body() FormData formData,
  );

  @DELETE('/api/v2/media/{caseId}')
  Future<void> deleteFile(
    @Path('caseId') String caseId,
    @Field('documentId') String documentId,
  );
}
