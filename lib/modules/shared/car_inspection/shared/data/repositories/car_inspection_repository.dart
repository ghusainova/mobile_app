import 'package:injectable/injectable.dart';

import '../../../../../sales_manager/auto_detail/data/models/defects.dart';
import '../models/act_detail.dart';
import '../models/equipment.dart';
import '../providers/car_inspection_api_provider.dart';

@lazySingleton
class CarInspectionRepository {
  final CarInspectionApiProvider carInspectionApiProvider;

  CarInspectionRepository({
    required this.carInspectionApiProvider,
  });

  Future<List<TempDefectModel>?> getCarBody(String orderId) async {
    return await carInspectionApiProvider.getCarBody(orderId: orderId);
  }

  Future<Map<String, List<ActDetail>>?> getInterior(String orderId) async {
    return await carInspectionApiProvider.getInterior(orderId: orderId);
  }

  Future<Map<String, List<ActDetail>>?> getOtherParts(String orderId) async {
    return await carInspectionApiProvider.getOtherParts(orderId: orderId);
  }

  Future<Map<String, List<Equipment>>?> getEquipment(String orderId) {
    return carInspectionApiProvider.getEquipment(orderId: orderId);
  }
}
