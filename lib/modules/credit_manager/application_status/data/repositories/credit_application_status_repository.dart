import 'package:injectable/injectable.dart';

import '../models/credit_status_item.dart';
import '../providers/credit_application_status_api_provider.dart';

@lazySingleton
class CreditApplicationStatusRepository {
  final CreditApplicationStatusApiProvider provider;
  const CreditApplicationStatusRepository({required this.provider});

  Future<List<CreditStatusItem>> getCreditApplicationStatusList(
    String orderId,
  ) async {
    final response = await provider.getCreditApplicationStatusList(orderId);
    return response.status;
  }
}
