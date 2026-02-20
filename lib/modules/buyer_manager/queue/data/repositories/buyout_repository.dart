import 'package:injectable/injectable.dart';

import '../../../../shared/_data/models/auto_info.dart';
import '../../../../sales_manager/catalog/data/models/catalog.dart';
import '../../../../shared/login/domain/user/user_bloc.dart';
import '../enum/buyer_status.dart';
import '../../../../shared/_data/enums/status_type_enum.dart';
import '../models/client_case_request_params.dart';
import '../models/status.dart';
import '../providers/buyout_api_provider.dart';

@lazySingleton
class BuyoutRepository {
  final BuyoutApiProvider provider;
  final UserBloc userBloc;

  BuyoutRepository(this.provider, this.userBloc);

  Future<Catalog<AutoInfo>> getBuyerCatalog(
    ClientCaseRequestParams? requestBody,
  ) async {
    final region = userBloc.user?.region;

    if (region == null || requestBody == null) {
      return Catalog();
    }

    return await provider.getBuyerCatalog(region, requestBody);
  }

  Future<Status?> getStatus(String orderId) async {
    final status = await provider.getStatus(orderId);
    if (status == null) {
      return status;
    }
    final statusTypeEnum = getStatusEnumFromType(status.type);
    final buyerStatusEnum = getBuyerStatusFromMessage(status.description);
    final statusWithEnum = status.copyWith(
      statusTypeEnum: statusTypeEnum,
      buyerStatusEnum: buyerStatusEnum,
    );

    return statusWithEnum;
  }
}
