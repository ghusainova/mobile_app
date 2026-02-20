import 'package:injectable/injectable.dart';

import '../models/main_info.dart';
import '../providers/main_info_api_provider.dart';

@lazySingleton
class MainInfoRepository {
  final MainInfoApiProvider provider;

  const MainInfoRepository({
    required this.provider,
  });

  Future<MainInfo> getMainInfo(String orderId) async {
    return await provider.getMainInfo(
      orderId: orderId,
    );
  }

  Future setMainInfo(
    String orderId,
    MainInfo mainInfo,
  ) async {
    return await provider.setMainInfo(
      orderId: orderId,
      mainInfo: mainInfo,
    );
  }
}
