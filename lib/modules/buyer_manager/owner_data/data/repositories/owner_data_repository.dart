import 'package:injectable/injectable.dart';

import '../models/owner_data.dart';
import '../providers/owner_data_api_provider.dart';

@lazySingleton
class OwnerDataRepository {
  final OwnerDataApiProvider provider;
  const OwnerDataRepository({required this.provider});

  Future<OwnerData> getOwnerData(
    String clientIin,
    String orderId,
  ) async {
    return await provider.getOwnerData(clientIin, orderId);
  }
}
