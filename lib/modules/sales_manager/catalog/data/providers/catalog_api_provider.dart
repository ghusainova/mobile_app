import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../shared/_data/models/auto_info.dart';
import '../models/filter.dart';
import '../models/catalog.dart';

part 'generated/catalog_api_provider.g.dart';

@RestApi()
@lazySingleton
abstract class CatalogApiProvider {
  @factoryMethod
  factory CatalogApiProvider(Dio dio) = _CatalogApiProvider;

  @GET('/api/v1/sm/orders/{serviceId}/?offset={offset}&listSize={listSize}')
  Future<Catalog<AutoInfo>> getAutoCatalog({
    @Path('serviceId') required String serviceId,
    @Path('offset') required int offset,
    @Path('listSize') required int listSize,
    @Queries() Filter? filter,
  });

  @GET('/api/v1/catalogs/brands')
  Future<List<String>> getBrands();

  @GET('/api/v1/catalogs/models')
  Future<List<String>> getModels({
    @Query('brand') required String brand,
  });
}
