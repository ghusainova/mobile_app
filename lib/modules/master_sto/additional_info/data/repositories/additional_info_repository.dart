import 'package:injectable/injectable.dart';

import '../models/additional_info.dart';
import '../providers/additional_info_api_provider.dart';

@lazySingleton
class AdditionalInfoRepository {
  final AdditionalInfoApiProvider provider;
  const AdditionalInfoRepository({required this.provider});

  Future<AdditionalInfo> getAdditionalInfo(String orderId) async {
    return await provider.getAdditionalInfo(orderId: orderId);
  }

  Future<List<String>> getEngineVolumes(String brand, String model) async {
    return await provider.getEngineVolumes(brand: brand, model: model);
  }

  Future setAdditionalInfo(
    String orderId,
    AdditionalInfo additionalInfo,
  ) async {
    return await provider.setAdditionalInfo(
      orderId: orderId,
      additionalInfo: additionalInfo,
    );
  }
}
