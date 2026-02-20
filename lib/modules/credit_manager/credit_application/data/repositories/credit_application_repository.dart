import 'package:injectable/injectable.dart';

import '../models/credit_application.dart';
import '../providers/credit_application_api_provider.dart';

@lazySingleton
class CreditApplicationRepository {
  final CreditApplicationApiProvider provider;
  const CreditApplicationRepository({required this.provider});

  Future<CreditApplication?> getCreditApplicationOrder(
    String activeClientIin,
  ) async {
    return await provider.getCreditApplicationByIin(clientIin: activeClientIin);
  }

  Future<List<CreditApplication>> getCreditApplicationList() async {
    return await provider.getCreditApplicationList();
  }

  Future<List<CreditApplication>> searchCreditApplications(
    String searchParam,
  ) async {
    return await provider.searchCreditApplications(searchParam);
  }

  Future<void> changeMaritalStatus(String orderId) async {
    await provider.changeMaritalStatus(orderId);
  }

  Future<void> readyToEstim(String orderId) async {
    await provider.readyToEstim(orderId);
  }
}
