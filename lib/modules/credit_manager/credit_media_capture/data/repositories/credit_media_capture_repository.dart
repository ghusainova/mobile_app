import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../models/credit_media_file.dart';
import '../providers/credit_media_capture_api_provider.dart';

@lazySingleton
class CreditMediaCaptureRepository {
  final CreditMediaCaptureApiProvider provider;

  const CreditMediaCaptureRepository({
    required this.provider,
  });

  Future<List<CreditMediaFile>> getFiles({
    required String orderId,
    required String category,
    String? fileType,
  }) async {
    final response = await provider.getFiles(
      orderId: orderId,
      category: category,
      fileType: fileType,
    );

    return response.files;
  }

  Future<void> uploadFile({
    required String orderId,
    required String fileType,
    required String category,
    required File file,
  }) async {
    final multipartFile = await MultipartFile.fromFile(file.path);
    final formData = FormData.fromMap({
      'file': multipartFile,
      'fileType': fileType,
      'bucketName': 'resauto-dev',
      'orderId': orderId,
      'category': category,
    });
    await provider.uploadFile(
      'multipart/form-data',
      formData,
    );
  }

  Future<void> deleteFile(int fileId) async {
    await provider.deleteFile(fileId);
  }
}
