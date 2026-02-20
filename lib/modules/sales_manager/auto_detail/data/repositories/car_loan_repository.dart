import 'package:injectable/injectable.dart';

import '../../../catalog/data/models/credit.dart';
import '../../../client_processing/data/models/approved_credit/get_credit_request_body.dart';
import '../providers/car_loan_api_provider.dart';

@lazySingleton
class CarLoanRepository {
  final CarLoanApiProvider carLoanApiProvider;

  CarLoanRepository({
    required this.carLoanApiProvider,
  });

  Future<Credit?> getCreditInfo(GetCreditRequestBody requestBody) {
    return carLoanApiProvider.getCreditInfo(requestBody);
  }
}
