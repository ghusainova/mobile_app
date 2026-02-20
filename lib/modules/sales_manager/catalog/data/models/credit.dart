import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../client_processing/data/models/approved_credit/get_credit_request_body.dart';
import '../../../../shared/_data/models/auto_info.dart';

part 'generated/credit.freezed.dart';
part 'generated/credit.g.dart';

@freezed
class Credit with _$Credit {
  const factory Credit({
    @Default('') String brand,
    @Default('') String model,
    @Default('') String bodyType,
    @Default(0) int creditTerm,
    @Default(0) int annualPaymentAmount, //месячный платеж
    @Default(0) int minInitialPaymentAmount, // минимальный ПВ
    @Default(0) int year,
    @Default(0) int price,
    @Default(0) int initialPaymentRatio,
    @Default(0) int initialPaymentAmount,
  }) = _Credit;

  factory Credit.fromJson(Map<String, dynamic> json) => _$CreditFromJson(json);

  factory Credit.fromAutoInfo(AutoInfo? autoInfo) => Credit(
        brand: autoInfo?.auto?.brand ?? '',
        model: autoInfo?.auto?.model ?? '',
        bodyType: autoInfo?.auto?.bodyType ?? '',
        creditTerm: autoInfo?.credit?.creditTerm ?? 0,
        annualPaymentAmount: autoInfo?.credit?.annualPaymentAmount ?? 0,
        minInitialPaymentAmount: autoInfo?.credit?.minInitialPaymentAmount ?? 0,
        year: autoInfo?.auto?.year ?? 0,
        price: autoInfo?.credit?.price ?? 0,
        initialPaymentRatio: autoInfo?.credit?.initialPaymentRatio ?? 0,
        initialPaymentAmount: autoInfo?.credit?.initialPaymentAmount ?? 0,
      );

  factory Credit.fromRequestBody(GetCreditRequestBody? requestBody) => Credit(
        creditTerm: requestBody?.creditTerm ?? 0,
        annualPaymentAmount: requestBody?.annualPaymentAmount ?? 0,
        minInitialPaymentAmount: requestBody?.minInitialPaymentAmount ?? 0,
        price: requestBody?.price ?? 0,
        initialPaymentRatio: requestBody?.initialPaymentRatio ?? 0,
        initialPaymentAmount: requestBody?.initialPaymentAmount ?? 0,
      );
}
