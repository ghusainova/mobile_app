import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/{{filename.snakeCase()}}.dart';

part 'generated/{{filename.snakeCase()}}_api_provider.g.dart';

@RestApi()
{{#is_provider_lazysingleton}}@lazySingleton{{/is_provider_lazysingleton}}
abstract class {{filename.pascalCase()}}ApiProvider {
  @factoryMethod
  factory {{filename.pascalCase()}}ApiProvider(Dio dio) = _{{filename.pascalCase()}}ApiProvider;

  @GET('/api/v2/cars/{orderId}/{{filename.snakeCase()}}')
  Future<{{filename.pascalCase()}}> get{{filename.pascalCase()}}();
}
