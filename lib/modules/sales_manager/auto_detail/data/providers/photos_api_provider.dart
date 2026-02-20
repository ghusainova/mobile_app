import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/media_capture_v1_response.dart';

part 'generated/photos_api_provider.g.dart';

@RestApi()
@lazySingleton
abstract class PhotosApiProvider {
  @factoryMethod
  factory PhotosApiProvider(Dio dio) = _PhotosApiProvider;

  @GET('/api/v1/files/{orderId}')
  Future<MediaCaptureV1Response> getPhotos({
    @Path('orderId') required String orderId,
    @Query('documentType') required String documentType,
  });
}
