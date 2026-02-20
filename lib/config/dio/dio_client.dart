import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../modules/shared/_data/constants/global_constants.dart';
import '../app/app_config.dart';
import '../injectable/injectable.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/error_handling_interceptor.dart';
import 'interceptors/log_interceptor.dart';

class DioClient {
  DioClient() {
    _initDio();
  }

  late Dio _dio;

  Dio get dio => _dio;

  void _initDio() {
    _dio = Dio();

    _dio.options = BaseOptions(
      baseUrl: getIt.get<AppConfig>().resaleBaseUrl,
      contentType: ContentType.json.toString(),
      connectTimeout: Constants.dioTimeout,
      sendTimeout: Constants.dioTimeout,
      receiveTimeout: Constants.dioTimeout,
    );

    _dio.interceptors.add(authInterceptor(_dio));
    _dio.interceptors.add(errorHandlingInterceptor());

    if (!kReleaseMode) {
      _dio.interceptors.add(logInterceptor());
    }
  }
}
