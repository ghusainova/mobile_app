import '../../../../../components/router/data/routes.dart';

enum UserRoleEnum {
  admin,
  salesManager,
  buyerManager,
  creditManager,
  techSpecialist,
  logisticSupervisor,
}

extension UserRoleEnumExt on UserRoleEnum {
  String get label {
    switch (this) {
      case UserRoleEnum.admin:
        return 'Администратор';
      case UserRoleEnum.salesManager:
        return 'Менеджер продаж';
      case UserRoleEnum.buyerManager:
        return 'Менеджер выкупа';
      case UserRoleEnum.creditManager:
        return 'Кредитный менеджер';
      case UserRoleEnum.techSpecialist:
        return 'Мастер СТО / Парковщик';
      case UserRoleEnum.logisticSupervisor:
        return 'Супервайзер';
    }
  }

  String get code {
    switch (this) {
      case UserRoleEnum.admin:
        return 'keyc_ra_admin';
      case UserRoleEnum.salesManager:
        return 'keyc_ra_sales_manager';
      case UserRoleEnum.buyerManager:
        return 'keyc_ra_buyer_manager';
      case UserRoleEnum.creditManager:
        return 'keyc_auto_credit_manager';
      case UserRoleEnum.techSpecialist:
        return 'keyc_ra_tech_specialist';
      case UserRoleEnum.logisticSupervisor:
        return 'keyc_ra_logistic_supervisor';
    }
  }

  String get routePath {
    switch (this) {
      case UserRoleEnum.admin:
        return UserRoleSelectionRoute.path;
      case UserRoleEnum.salesManager:
        return ClientRoute.path;
      case UserRoleEnum.buyerManager:
        return BuyerQueueRoute.path;
      case UserRoleEnum.creditManager:
        return CreditQueueRoute.path;
      case UserRoleEnum.techSpecialist:
      case UserRoleEnum.logisticSupervisor:
        return MasterStoRoute.path;
    }
  }
}
