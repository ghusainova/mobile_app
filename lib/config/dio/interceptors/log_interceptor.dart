import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';

AwesomeDioInterceptor logInterceptor() {
  return AwesomeDioInterceptor(
    logRequestTimeout: false,
    logRequestHeaders: false,
    logResponseHeaders: false,
  );
}
