import 'package:injectable/injectable.dart';

import '../providers/tires_api_provider.dart';

@lazySingleton
class TiresRepository {
  final TiresApiProvider tiresApiProvider;

  const TiresRepository(this.tiresApiProvider);

  Future<List<String>> getTiresBrands() async {
    return await tiresApiProvider.getTiresBrands();
  }
}
