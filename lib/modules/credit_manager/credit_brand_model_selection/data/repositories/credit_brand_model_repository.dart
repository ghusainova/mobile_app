import 'package:injectable/injectable.dart';

import '../providers/credit_brand_model_api_provider.dart';

@lazySingleton
class CreditBrandModelRepository {
  CreditBrandModelRepository(this.provider);

  final CreditBrandModelApiProvider provider;
  Future<List<String>> getCreditBrands(int page) async {
    final response = await provider.getCreditBrands(page: page, size: 15);
    return response.content;
  }

  Future<List<String>> searchCreditBrands(String searchValue) async {
    final response = await provider.searchCreditBrands(
      brand: searchValue,
      page: 0,
      size: 100,
    );
    return response.content;
  }

  Future<List<String>> getCreditModels(String brand) async {
    List<String> models = [];

    final response = await provider.getCreditModels(
      brand: brand,
      page: 0,
      size: 100,
    );
    models = response.content;

    return models;
  }
}
