import 'package:injectable/injectable.dart';

import '../models/single_message_response.dart';
import '../providers/qr_api_provider.dart';

@lazySingleton
class QrRepository {
  final QrApiProvider qrApiProvider;

  const QrRepository({required this.qrApiProvider});

  Future<SingleMessageResponse> getApprovalForCarLoan(
    String? id,
    String? clientIin,
    String? advertLink,
    int? clientTransactionId,
  ) async {
    return await qrApiProvider.getApprovalForCarLoan(
      id,
      int.tryParse(clientIin ?? ''),
      advertLink,
      clientTransactionId,
    );
  }

  Future<void> applyWithoutCarLoan(
    String? id,
    String? clientIin,
    int? clientTransactionId,
  ) async {
    await qrApiProvider.applyWithoutCarLoan(
      id,
      clientIin,
      clientTransactionId,
    );
  }
}
