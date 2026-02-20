import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../models/media_file.dart';
import '../providers/media_capture_vin_api_provider.dart';

@lazySingleton
class MediaCaptureRepository {
  final MediaCaptureApiProvider provider;

  const MediaCaptureRepository({
    required this.provider,
  });

  Future<List<MediaFile>> getFiles(
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
      'name': 'media',
    });

    await provider.uploadFile(
      caseId,
      'multipart/form-data',
      formData,
    );
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
