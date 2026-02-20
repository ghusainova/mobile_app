import 'package:dio/dio.dart';

InterceptorsWrapper errorHandlingInterceptor() {
  return InterceptorsWrapper(
    onError: (error, handler) {
      final errorMessage = _getMessageByErrorType(error);

      return handler.next(
        error.copyWith(message: errorMessage),
      );
    },
  );
}

String? _getMessageByErrorType(DioException error) {
  if (error.response.toString().contains('Invalid user credentials')) {
    return 'Неверный логин или пароль';
  } else if (error.message?.contains('Failed host lookup') ?? false) {
    return 'Нет соединения с сервером. Проверьте подключение к сети интернет.';
  } else if (error.response?.data != null) {
    final url = error.requestOptions.path;
    final statusCode = error.response?.statusCode;
    final message = error.response!.data['message'];
    final response = error.response!.data['response'];
    final result = error.response!.data['result'];
    return 'url: $url,\nstatusCode:$statusCode,\nmessage: $message,\nresponse: $response,\nresult: $result';
  }

  return 'Ошибка ${error.response?.statusCode}';
}
