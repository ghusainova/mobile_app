import 'package:collection/collection.dart';

import '../../../../../components/router/data/routes.dart';

enum BuyerStatusEnum {
  ownerIsGivingConsent,
  ownerGaveConsent,
  carDataIsNotFound,
  readyToBuy,
  inInspectionProcess,
  checkInspectionReport,
  documentsOnCheck,
  documentsChecked,
  reworkIsRequired,
  needToReplaceTechPassport,
  needToPayFee,
  needToRemoveFromPledge,
  autoIsNotOkForBuyout,
}

extension BuyerStatusEnumExt on BuyerStatusEnum {
  String? get routePath {
    switch (this) {
      case BuyerStatusEnum.ownerIsGivingConsent:
      case BuyerStatusEnum.inInspectionProcess:
      case BuyerStatusEnum.documentsOnCheck:
        return null;

      case BuyerStatusEnum.ownerGaveConsent:
        return OwnerDataRoute.path;

      case BuyerStatusEnum.carDataIsNotFound:
        return CarOwnerConsentRoute.path;

      case BuyerStatusEnum.readyToBuy:
      case BuyerStatusEnum.checkInspectionReport:
      case BuyerStatusEnum.needToReplaceTechPassport:
      case BuyerStatusEnum.needToPayFee:
      case BuyerStatusEnum.needToRemoveFromPledge:
      case BuyerStatusEnum.autoIsNotOkForBuyout:
        return CarInspectionReportRoute.path;

      case BuyerStatusEnum.documentsChecked:
        return FinalSscNavRoute.path;

      case BuyerStatusEnum.reworkIsRequired:
        return null; //TODO: fix route
    }
  }

  String get name {
    switch (this) {
      case BuyerStatusEnum.ownerIsGivingConsent:
        return 'Владелец даёт согласие';
      case BuyerStatusEnum.ownerGaveConsent:
        return 'Владелец дал согласие';
      case BuyerStatusEnum.carDataIsNotFound:
        return 'Данные авто не найдены';
      case BuyerStatusEnum.readyToBuy:
        return 'Готовы выкупить авто';
      case BuyerStatusEnum.inInspectionProcess:
        return 'Авто проходит осмотр';
      case BuyerStatusEnum.checkInspectionReport:
        return 'Изучите акт осмотра';

      case BuyerStatusEnum.documentsOnCheck:
        return 'Документы на проверке';
      case BuyerStatusEnum.documentsChecked:
        return 'Документы проверены';
      case BuyerStatusEnum.reworkIsRequired:
        return 'Требуется доработка';
      case BuyerStatusEnum.needToReplaceTechPassport:
        return 'Нужно заменить техпаспорт';
      case BuyerStatusEnum.needToPayFee:
        return 'Нужно оплатить утильсбор';
      case BuyerStatusEnum.needToRemoveFromPledge:
        return 'Нужно снять авто с залога';
      case BuyerStatusEnum.autoIsNotOkForBuyout:
        return 'Авто не подходит для выкупа';
    }
  }
}

BuyerStatusEnum? getBuyerStatusFromMessage(String message) {
  if (message.isEmpty) {
    return null;
  }
  return BuyerStatusEnum.values.firstWhereOrNull((e) => e.name == message);
}
