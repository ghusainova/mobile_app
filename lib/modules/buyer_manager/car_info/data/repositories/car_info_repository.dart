import 'package:injectable/injectable.dart';

import '../../../../shared/_data/models/auto.dart';
import '../providers/car_info_api_provider.dart';

@lazySingleton
class CarInfoRepository {
  final CarInfoApiProvider provider;
  const CarInfoRepository({required this.provider});

  Future<Auto> getCarInfo(String orderId) async {
    return await provider.getCarInfo(orderId: orderId);
  }
}
