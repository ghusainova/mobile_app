import '../../../../../components/router/data/routes.dart';
import '../../../../shared/_data/enums/status_type_enum.dart';
import '../../../../buyer_manager/shared/_data/models/status_page_configs.dart';

final salesManagerConfigs = StatusPageConfigs(
  appBarTitle: 'Оформление авто',
  title: 'Заявка отправлена\nна оформление',
  subtitle: 'Проводите клиента к Менеджеру\nоформления авто',
  buttonText: 'Вернуться на Главную',
  routePath: ClientRoute.path,
  statusType: StatusTypeEnum.success,
);
