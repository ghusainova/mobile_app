import 'package:injectable/injectable.dart';

import '../../../search_case/data/model/updating_info_params.dart';
import '../providers/buyout_shared_api_provider.dart';

@lazySingleton
class BuyoutSharedRepository {
  final BuyoutSharedApiProvider provider;

  BuyoutSharedRepository(this.provider);

  Future getCarOwnerConsent(
    String clientIin,
    String integrationId,
  ) async {
    return await provider.getCarOwnerConsent(
      clientIin,
      integrationId,
    );
  }

  Future<bool> updateAutoInfo(
    String? orderId,
    UpdatingInfoParams updatingInfoParams,
  ) async {
    if (orderId == null) {
      return false;
    }
    try {
      await provider.updateAutoInfo(orderId, updatingInfoParams);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> finishWork(
    String? orderId,
  ) async {
    if (orderId == null) {
      return false;
    }
    try {
      await provider.finishWork(orderId);
      return true;
    } catch (_) {
      return false;
    }
  }
}
