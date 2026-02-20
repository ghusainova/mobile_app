import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../shared/_data/models/auto_info.dart';
import '../../../catalog/data/models/catalog.dart';

part 'generated/approved_credit_api_provider.g.dart';

@RestApi()
@lazySingleton
abstract class ApprovedCreditApiProvider {
  @factoryMethod
  factory ApprovedCreditApiProvider(Dio dio) = _ApprovedCreditApiProvider;

  @GET('/api/v1/sm/orders/approved-order?iin={iin}')
  Future<Catalog<AutoInfo>> getApprovedCredit(
    @Path('iin') String iin,
  );
}
