import 'package:injectable/injectable.dart';

import '../models/credit_additional_response.dart';
import '../providers/credit_additional_info_api_provider.dart';

@lazySingleton
class CreditAdditionalInfoRepository {
  final CreditAdditionalInfoApiProvider provider;
  const CreditAdditionalInfoRepository({required this.provider});

  Future<CreditAdditionalResponse> getAdditionalInfo(String orderId) async {
    return await provider.getAdditionalInfo(orderId: orderId);
  }

  Future<void> setAdditionalInfo(
    String orderId,
    CreditAdditionalResponse additionalInfoResponse,
  ) async {
    return await provider.setAdditionalInfo(
      orderId: orderId,
      additionalInfoResponse: additionalInfoResponse,
    );
  }
}
