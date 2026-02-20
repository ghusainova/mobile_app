import 'package:injectable/injectable.dart';

import '../models/credit_documents.dart';
import '../providers/credit_documents_api_provider.dart';

@lazySingleton
class CreditDocumentsRepository {
  final CreditDocumentsApiProvider provider;
  const CreditDocumentsRepository({required this.provider});

  Future<CreditDocuments> getCreditDocuments(String clientIin) async {
    return await provider.getCreditDocuments(clientIin);
  }
}
