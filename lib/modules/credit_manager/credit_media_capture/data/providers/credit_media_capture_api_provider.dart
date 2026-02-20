import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/credit_media_capture_vin_response.dart';

part 'generated/credit_media_capture_api_provider.g.dart';

@RestApi()
abstract class CreditMediaCaptureApiProvider {
  @factoryMethod
  factory CreditMediaCaptureApiProvider(Dio dio) =
      _CreditMediaCaptureApiProvider;

  @GET('/api/v1/files')
  Future<CreditMediaCaptureVinResponse> getFiles({
    @Query('orderId') required String orderId,
    @Query('category') required String category,
    @Query('fileType') String? fileType,
  });

  @POST('/api/v1/files/')
  Future<void> uploadFile(
    @Header('Content-Type') String contentType,
    @Body() FormData formData,
  );

  @DELETE('/api/v1/files/{fileId}')
  Future<void> deleteFile(
    @Path('fileId') int fileId,
  );
}
