import 'package:injectable/injectable.dart';

import '../../../../shared/_data/models/auto_info.dart';
import '../../../catalog/data/models/catalog.dart';
import '../models/approved_credit/get_auto_request_body.dart';
import '../providers/recommended_autos_api_provider.dart';

@lazySingleton
class RecommendedAutosRepository {
  final RecommendedAutosApiProvider recommendedAutosApiProvider;

  const RecommendedAutosRepository({required this.recommendedAutosApiProvider});

  Future<Catalog<AutoInfo>> getRecommendedAutos(
    String? serviceId,
    GetAutoRequestBody requestBody,
  ) async {
    return await recommendedAutosApiProvider.getRecommendedAutos(
      serviceId,
      requestBody,
    );
  }
}
