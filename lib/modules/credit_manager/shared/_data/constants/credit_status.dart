import '../../../application_status/data/models/credit_status_item.dart';

class CreditStatus {
  static const getSellerCheck = 'GET_SELLER_CHECK';
  static const prepare = 'PREPARE';
  static const getAutoCheck = 'GET_AUTO_CHECK';
  static const verificationRework = 'VERIFICATION_REWORK';
  static const verificationProcess = 'VERIFICATION_PROCESS';
  static const verificationReject = 'VERIFICATION_REJECT';
  static const signDoc = 'SIGN_DOC';
  static const waitSeller = 'WAIT_SELLER';
  static const managerSignDoc = 'MANAGER_SIGN_DOC';
  static const waitPayNow = 'WAIT_PAY_NOW';
  static const regZalog = 'REG_ZALOG';
  static const scoringAlternative = 'SCORING_ALTERNATIVE';
  static const scoringReject = 'SCORING_REJECT';

  static const List<CreditStatusItem> _itemList = [
    CreditStatusItem(
      statusCode: getSellerCheck,
      name: 'Получите данные Продавца и авто',
      finalName: 'Данные продавца и авто получены',
    ),
    CreditStatusItem(
      statusCode: prepare,
      name: 'Покупатель подтверждает условия автокредита',
      finalName: 'Покупатель подтвердил условия Автокредита',
    ),
    CreditStatusItem(
      statusCode: getAutoCheck,
      name: 'Отправьте данные авто на проверку',
      finalName: 'Данные авто отправлены на проверку',
    ),
    CreditStatusItem(
      statusCode: verificationRework,
      name: 'Сделайте доработки по данным авто',
    ),
    CreditStatusItem(
      statusCode: verificationProcess,
      name: 'Авто проходит проверку',
      finalName: 'Авто прошло проверку',
      comment:
          'Проверка авто занимает 10-15 минут. Вы можете начать работу с другим клиентом',
      isStageItem: true,
    ),
    CreditStatusItem(
      statusCode: signDoc,
      name: 'Покупатель подписывает документы',
      finalName: 'Покупатель подпиcал документы',
      comment:
          'При неверном семейном положении, отправьте покупателю сообщение для изменения данных',
    ),
    CreditStatusItem(
      statusCode: waitSeller,
      name: 'Продавец подписывает документы',
      finalName: 'Продавец подпиcал документы',
    ),
    CreditStatusItem(
      statusCode: managerSignDoc,
      name: 'Подпишите документы онлайн',
      finalName: 'Вы подписали документы',
    ),
    CreditStatusItem(
      statusCode: waitPayNow,
      name: 'Покупатель вносит первоначальный взнос',
      finalName: 'Покупатель внес первоначальный взнос',
    ),
    CreditStatusItem(
      statusCode: regZalog,
      name: 'Продавец и Покупатель переоформляют авто',
      comment: 'Для переоформления авто в СпецЦоне распечатайте документы',
    ),
  ];

  static CreditStatusItem get alternativeItem => const CreditStatusItem(
        statusCode: scoringAlternative,
        name: 'Условия Автокредита изменились',
        comment: 'Мы отправили покупателю сообщение с новыми условиями',
      );

  static List<CreditStatusItem> get itemList => _itemList;
}
