import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/queue/data/models/active_client_dto.dart';
import '../../../application_status/data/models/credit_status_item.dart';
import 'credit_application_advert.dart';
import 'credit_application_auto.dart';
import 'credit_application_client.dart';
import 'credit_application_conditions.dart';
import 'credit_application_order_info.dart';
import 'credit_application_seller.dart';

part 'generated/credit_application.freezed.dart';
part 'generated/credit_application.g.dart';

@freezed
class CreditApplication with _$CreditApplication {
  const factory CreditApplication({
    required CreditApplicationClient client,
    required CreditApplicationConditions credit,
    required CreditApplicationAuto auto,
    required CreditApplicationOrderInfo order,
    required CreditApplicationSeller seller,
    required CreditApplicationAdvert? advert,
    @Default([]) List<CreditStatusItem> status,
  }) = _CreditApplication;

  factory CreditApplication.fromJson(Map<String, dynamic> json) =>
      _$CreditApplicationFromJson(json);
}

ActiveClientDTO? mapSellerToActiveClient(CreditApplicationSeller? seller) {
  if (seller == null) {
    return null;
  }

  return ActiveClientDTO(
    firstname: seller.firstName,
    patronymic: seller.lastName,
    iin: seller.iin,
  );
}
