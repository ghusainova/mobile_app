import 'package:injectable/injectable.dart';

import '../../../../shared/_data/models/auto_info.dart';
import '../models/filter.dart';
import '../models/catalog.dart';
import '../providers/catalog_api_provider.dart';

@lazySingleton
class CatalogRepository {
  CatalogRepository(this.catalogApiProvider);

  final CatalogApiProvider catalogApiProvider;

  Future<Catalog<AutoInfo>> getAutoCatalog({
    required String serviceId,
    int? offset,
    Filter? filter,
  }) async {
    return await catalogApiProvider.getAutoCatalog(
      serviceId: serviceId,
      offset: offset ?? 0,
      listSize: 20,
      filter: filter,
    );
  }

  Future<List<String>> getBrands() async {
    return await catalogApiProvider.getBrands();
  }

  Future<List<String>> getModels(String brand) async {
    return await catalogApiProvider.getModels(brand: brand);
  }
}
