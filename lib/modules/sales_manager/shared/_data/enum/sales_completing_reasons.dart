import '../../../../shared/complete_client_session/data/models/complete_reason_item.dart';

List<String> salesManagerCompleteReasons = [
  'Ушли подумать',
  'Хотят оформить на 3-е лицо',
  'Отказали в автокредите',
  'Не устроило техсостояние авто',
  'Не устроила стоимость авто',
  'Не дождались очереди',
  'Другое',
];

enum SalesCompletingReasonsEnum {
  goneToThink,
  want3rdPartyRegister,
  refusedCarLoan,
  badCarTechCondition,
  badCarPrice,
  didntWaitInLine,
  other,
}

extension SalesCompletingReasonsEnumExt on SalesCompletingReasonsEnum {
  String get title {
    switch (this) {
      case SalesCompletingReasonsEnum.goneToThink:
        return 'Ушли подумать';
      case SalesCompletingReasonsEnum.want3rdPartyRegister:
        return 'Хотят оформить на 3-е лицо';
      case SalesCompletingReasonsEnum.refusedCarLoan:
        return 'Отказали в автокредите';
      case SalesCompletingReasonsEnum.badCarTechCondition:
        return 'Не устроило техсостояние авто';
      case SalesCompletingReasonsEnum.badCarPrice:
        return 'Не устроила стоимость авто';
      case SalesCompletingReasonsEnum.didntWaitInLine:
        return 'Не дождались очереди';
      case SalesCompletingReasonsEnum.other:
        return 'Другое';
    }
  }
}

List<CompleteReasonItem> getSalesCompletingReasons() {
  return SalesCompletingReasonsEnum.values
      .map((e) => CompleteReasonItem(title: e.title))
      .toList();
}
