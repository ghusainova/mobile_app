import 'package:collection/collection.dart';

import '../../../../../components/router/app_router.dart';
import '../../../../../components/router/data/routes.dart';
import '../../../../../config/injectable/injectable.dart';
import '../../../credit_application/domain/credit_application/credit_application_bloc.dart';
import '../enum/credit_rework_enum.dart';
import '../helpers/credit_route_args.dart';
import 'credit_status.dart';

class CreditStatusAction {
  final String statusCode;
  const CreditStatusAction(this.statusCode);

  String? get btnTitle => _getTitleByCode();
  void Function()? get btnRoute => _getRouteByCode();

  static const _btnTitleMap = {
    CreditStatus.getSellerCheck: 'Получить данные',
    CreditStatus.getAutoCheck: 'Отправить данные',
    CreditStatus.signDoc: 'Изменить данные',
    CreditStatus.regZalog: 'Распечатать документы',
    CreditStatus.verificationRework: 'Перейти к доработкам',
    creditReworkTechPassType: 'Сделать фото техпаспорта',
  };
  static const _btnRouteMap = {
    CreditStatus.getSellerCheck: _getSellerCheckRoute,
    CreditStatus.getAutoCheck: navigateCreditRegCertInspection,
    CreditStatus.signDoc: _getSignDocRoute,
    CreditStatus.regZalog: _getRegZalogRoute,
    CreditStatus.verificationRework: _getVerificationReworkRoute,
    creditReworkTechPassType: _getTechPassReworkRoute,
  };

  static void _getSellerCheckRoute() {
    final context = rootNavigatorKey.currentContext;
    if (context != null) {
      const GetSellerDataRoute().push(context);
    }
  }

  static void _getSignDocRoute() {
    final context = rootNavigatorKey.currentContext;
    if (context != null) {
      const MaritalStatusRoute().push(context);
    }
  }

  static void _getRegZalogRoute() {
    final context = rootNavigatorKey.currentContext;
    if (context != null) {
      const CreditDocumentsRoute().push(context);
    }
  }

  static void _getVerificationReworkRoute() {
    final context = rootNavigatorKey.currentContext;
    if (context != null) {
      const CreditReworkRoute().push(context);
    }
  }

  static void _getTechPassReworkRoute() {
    navigateCreditRegCertInspection(
      onFinalRoute: () => getIt
          .get<CreditApplicationBloc>()
          .add(const CompletePhotoInspection()),
    );
  }

  String? _getTitleByCode() {
    return _btnTitleMap.entries
        .firstWhereOrNull((e) => e.key == statusCode)
        ?.value;
  }

  void Function()? _getRouteByCode() {
    return _btnRouteMap.entries
        .firstWhereOrNull((e) => e.key == statusCode)
        ?.value;
  }
}
