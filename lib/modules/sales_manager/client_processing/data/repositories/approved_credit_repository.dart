import 'package:injectable/injectable.dart';

import '../../../../shared/_data/models/auto_info.dart';
import '../../../catalog/data/models/catalog.dart';
import '../providers/approved_credit_api_provider.dart';

@lazySingleton
class ApprovedCreditRepository {
  final ApprovedCreditApiProvider approvedCreditApiProvider;

  const ApprovedCreditRepository({required this.approvedCreditApiProvider});

  Future<Catalog<AutoInfo>> getApprovedCredit(String iin) async {
    return await approvedCreditApiProvider.getApprovedCredit(iin);
  }
}
