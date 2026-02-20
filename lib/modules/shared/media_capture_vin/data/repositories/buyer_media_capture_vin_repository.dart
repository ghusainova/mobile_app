import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../sales_manager/auto_detail/data/models/media_file_v1.dart';
import '../providers/buyer_media_capture_vin_api_provider.dart';

@lazySingleton
class BuyerMediaCaptureRepository {
  final BuyerMediaCaptureApiProvider provider;

  const BuyerMediaCaptureRepository({
    required this.provider,
  });

  Future<List<MediaFileV1>> getFiles(
    String caseId,
    String mediaType,
  ) async {
    final response = await provider.getFiles(
      caseId,
      mediaType,
    );

    return response.files;
  }

  Future<void> uploadFile(
    String caseId,
    String type,
    String ext,
    File file,
  ) async {
    final multipartFile = await MultipartFile.fromFile(file.path);
    final formData = FormData.fromMap({
      'file': multipartFile,
      'type': type,
      'ext': ext,
      'name': type,
      'orderId': caseId,
    });

    await provider.uploadFile('multipart/form-data', formData);
  }

  Future<void> deleteFile(
    String caseId,
    String documentId,
  ) async {
    await provider.deleteFile(
      caseId,
      documentId,
    );
  }
}
