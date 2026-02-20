import 'package:injectable/injectable.dart';

import '../models/media_file_v1.dart';
import '../providers/photos_api_provider.dart';

@lazySingleton
class PhotosRepository {
  PhotosRepository(this.photosApiProvider);

  final PhotosApiProvider photosApiProvider;

  Future<List<MediaFileV1>> getPhotos(String orderId, String type) async {
    final response =
        await photosApiProvider.getPhotos(orderId: orderId, documentType: type);
    return response.files;
  }
}
