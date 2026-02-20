import 'package:injectable/injectable.dart';

import '../models/equipment_inspection.dart';
import '../providers/equipment_inspection_api_provider.dart';

@lazySingleton
class EquipmentInspectionRepository {
  final EquipmentInspectionApiProvider provider;
  const EquipmentInspectionRepository({required this.provider});

  Future<EquipmentInspection> getEquipments({
    required String caseId,
    required String type,
  }) async {
    return await provider.getEquipments(caseId: caseId, type: type);
  }

  Future<void> saveEquipments({
    required String caseId,
    required EquipmentInspection body,
  }) async {
    await provider.saveEquipments(
      caseId: caseId,
      body: body,
    );
  }
}
