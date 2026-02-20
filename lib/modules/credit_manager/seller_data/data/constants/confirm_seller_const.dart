import '../../../../../components/router/data/routes.dart';
import '../../../../buyer_manager/shared/_data/models/status_page_configs.dart';

class ConfirmSellerConst {
  static StatusPageConfigs buyerNeedToConfirm = StatusPageConfigs(
    appBarTitle: 'Данные продавца и авто',
    title: 'Покупателю нужно подтвердить условия Автокредита',
    subtitle: 'Отправили сообщение покупателю в приложении Kaspi.kz',
    routePath: CreditApplicationRoute.path,
  );
  static StatusPageConfigs carCreditUnavailable = StatusPageConfigs(
    appBarTitle: 'Данные продавца и авто',
    title: 'Авто не подходит под условия автокредитования',
    subtitle: 'Отправили сообщение покупателю в приложении Kaspi.kz ',
    routePath: CreditApplicationRoute.path,
  );
}
