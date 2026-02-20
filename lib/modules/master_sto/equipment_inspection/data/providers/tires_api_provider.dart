import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'generated/tires_api_provider.g.dart';

@RestApi()
abstract class TiresApiProvider {
  @factoryMethod
  factory TiresApiProvider(Dio dio) = _TiresApiProvider;

  @GET('/api/v2/catalog/tires')
  Future<List<String>> getTiresBrands();
}
