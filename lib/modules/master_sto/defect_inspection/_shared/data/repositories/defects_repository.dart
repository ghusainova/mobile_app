import 'package:injectable/injectable.dart';

import '../models/defect_model.dart';
import '../providers/defects_api_provider.dart';

@lazySingleton
class DefectsRepository {
  final DefectsApiProvider provider;

  const DefectsRepository({required this.provider});

  Future<DefectModel> getDefect(String orderId, String bodyPart) async {
    return await provider.getDefect(
      orderId: orderId,
      bodyPart: bodyPart,
    );
  }

  Future<void> setDefects(
    String orderId,
    DefectModel defect,
  ) async {
    return await provider.setDefect(
      orderId: orderId,
      defect: defect,
    );
  }

  Future<List<DefectModel>> getDefects(String orderId) async {
    return await provider.getDefects(orderId: orderId);
  }
}
