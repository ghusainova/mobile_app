import 'package:injectable/injectable.dart';

import '../models/credit_rework_model.dart';
import '../providers/credit_rework_api_provider.dart';

@lazySingleton
class CreditReworkRepository {
  final CreditReworkApiProvider provider;

  const CreditReworkRepository({required this.provider});

  Future<CreditReworkModel> getCreditReworkItems(String orderId) async {
    final response = await provider.getCreditReworkItems(orderId: orderId);
    final modifiedResponse = CreditReworkModel.fromCreditWorkResponse(response);
    return modifiedResponse;
  }
}
