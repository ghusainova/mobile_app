import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../shared/_data/models/auto_info.dart';
import '../../../../catalog/data/models/credit.dart';

part 'generated/get_credit_request_body.freezed.dart';
part 'generated/get_credit_request_body.g.dart';

@freezed
class GetCreditRequestBody with _$GetCreditRequestBody {
  const factory GetCreditRequestBody({
    String? brand,
    String? model,
    String? bodyType,
    int? year,
    int? creditTerm,
    int? price,
    int? initialPaymentRatio,
    int? initialPaymentAmount,
    int? annualPaymentAmount,
    int? minInitialPaymentAmount,
    double? creditRatio,
  }) = _GetCreditRequestBody;

  factory GetCreditRequestBody.fromJson(Map<String, dynamic> json) =>
      _$GetCreditRequestBodyFromJson(json);

  factory GetCreditRequestBody.fromAutoInfo(AutoInfo? autoInfo) =>
      GetCreditRequestBody(
        brand: autoInfo?.auto?.brand,
        model: autoInfo?.auto?.model,
        bodyType: autoInfo?.auto?.bodyType,
        year: autoInfo?.auto?.year,
        price: int.tryParse(autoInfo?.priceSelling ?? ''),
        creditTerm: autoInfo?.credit?.creditTerm,
        initialPaymentRatio: autoInfo?.credit?.initialPaymentRatio,
        initialPaymentAmount: autoInfo?.credit?.initialPaymentAmount,
        annualPaymentAmount: autoInfo?.credit?.annualPaymentAmount,
        minInitialPaymentAmount: autoInfo?.credit?.minInitialPaymentAmount,
      );

  factory GetCreditRequestBody.fromCredit(Credit? credit) =>
      GetCreditRequestBody(
        brand: credit?.brand,
        model: credit?.model,
        bodyType: credit?.bodyType,
        year: credit?.year,
        creditTerm: credit?.creditTerm,
        price: credit?.price,
        initialPaymentRatio: credit?.initialPaymentRatio,
        initialPaymentAmount: credit?.initialPaymentAmount,
        annualPaymentAmount: credit?.annualPaymentAmount,
        minInitialPaymentAmount: credit?.minInitialPaymentAmount,
      );
}
