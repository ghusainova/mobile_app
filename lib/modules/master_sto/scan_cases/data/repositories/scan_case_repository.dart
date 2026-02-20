import 'package:injectable/injectable.dart';

import '../models/scan_case.dart';
import '../providers/scan_case_api_provider.dart';

@lazySingleton
class ScanCaseRepository {
  final ScanCaseApiProvider provider;

  const ScanCaseRepository(this.provider);

  Future<List<ScanCase>> getCases() async {
    return await provider.getCases();
  }

  Future getCaseInWork(String caseId) async {
    return await provider.getCaseInWork(caseId: caseId);
  }
}
