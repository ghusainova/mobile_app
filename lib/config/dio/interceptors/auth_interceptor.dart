import 'package:dio/dio.dart';

import '../../injectable/injectable.dart';
import '../../../services/local_storage/token_manager/token_manager.dart';
import 'error_by_status_handler.dart';

InterceptorsWrapper authInterceptor(Dio dio) {
  return InterceptorsWrapper(
    onRequest: _onRequest,
    onError: (error, handler) => handleErrorsByStatusCode(dio, error, handler),
  );
}

Future<void> _onRequest(
  RequestOptions options,
  RequestInterceptorHandler handler,
) async {
  final tokenManager = getIt.get<TokenManager>();
  final accessToken = await tokenManager.accessToken;

  options.headers['Authorization'] = 'Bearer $accessToken';
  return handler.next(options);
}
