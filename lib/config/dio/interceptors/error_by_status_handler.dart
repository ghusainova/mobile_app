import 'dart:async';

import 'package:dio/dio.dart';

import '../../../modules/shared/login/domain/auth/auth_bloc.dart';
import '../../../components/router/app_router.dart';
import '../../../components/router/data/routes.dart';
import '../../injectable/injectable.dart';
import '../../logs/log.dart';
import '../../../services/local_storage/token_manager/token_manager.dart';

void handleErrorsByStatusCode(
  Dio dio,
  DioException error,
  ErrorInterceptorHandler handler,
) {
  switch (error.response?.statusCode) {
    case 401:
      _handle401Status(dio, error, handler);
      break;
    case 403:
      _handle403Status(dio, error, handler);
      break;
    default:
      return handler.next(error);
  }
}

Future<void> _handle401Status(
  Dio dio,
  DioException error,
  ErrorInterceptorHandler handler,
) async {
  final tokenManager = getIt.get<TokenManager>();

  try {
    await tokenManager.refreshAccessToken();
  } catch (e) {
    await _reLogin();
  }

  try {
    logger.i('retry after 401: $error');
    final response = await _retry(dio, error.requestOptions);
    return handler.resolve(response);
  } on DioException catch (e) {
    return handler.next(e);
  }
}

Future<void> _handle403Status(
  Dio dio,
  DioException error,
  ErrorInterceptorHandler handler,
) async {
  await _reLogin();

  try {
    logger.i('retry after 403: $error');
    final response = await _retry(dio, error.requestOptions);
    return handler.resolve(response);
  } on DioException catch (e) {
    return handler.next(e);
  }
}

Future<void> _reLogin() async {
  try {
    final logInCredentials =
        await getIt.get<TokenManager>().getLoginCredentials();

    if (logInCredentials != null) {
      await getIt.get<AuthBloc>().logIn(
            login: logInCredentials.login,
            password: logInCredentials.password,
          );
    } else {
      throw Exception('Missing login credentials');
    }
  } catch (e) {
    await _logOut();
  }
}

Future<void> _logOut() async {
  final context = rootNavigatorKey.currentContext;

  if (context != null) {
    const LoginRoute().go(context);
  }

  try {
    await getIt.get<AuthBloc>().logOut(forceLogOut: true);
  } catch (e) {
    logger.e(e);
  }
}

Future<Response<dynamic>> _retry(Dio dio, RequestOptions requestOptions) async {
  final options = Options(
    method: requestOptions.method,
    headers: requestOptions.headers,
    contentType: requestOptions.contentType,
    responseType: requestOptions.responseType,
  );

  if (requestOptions.data is FormData) {
    final newFormData = (requestOptions.data as FormData).clone();
    requestOptions.data = newFormData;
  }

  return dio.request(
    requestOptions.path,
    data: requestOptions.data,
    queryParameters: requestOptions.queryParameters,
    options: options,
  );
}
