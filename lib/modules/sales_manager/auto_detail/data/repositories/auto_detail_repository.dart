import 'package:injectable/injectable.dart';

import '../../../../shared/_data/models/auto_info.dart';
import '../../../client_processing/data/models/approved_credit/get_auto_request_body.dart';
import '../../../catalog/data/models/catalog.dart';
import '../providers/auto_detail_api_provider.dart';

@lazySingleton
class AutoDetailRepository {
  AutoDetailRepository(this.autoDetailApiProvider);

  final AutoDetailApiProvider autoDetailApiProvider;

  Future<AutoInfo?> getAutoAuto(String orderId) {
    return autoDetailApiProvider.getAutoAuto(orderId: orderId);
  }

  Future<Catalog<AutoInfo>> getSimilarAutoCatalog(
    String? serviceId,
    GetAutoRequestBody requestBody,
  ) async {
    return await autoDetailApiProvider.getSimilarAutoCatalog(
      serviceId,
      requestBody,
    );
  }
}
