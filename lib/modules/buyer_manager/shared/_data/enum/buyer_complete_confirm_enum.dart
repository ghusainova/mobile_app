import '../../../../shared/complete_client_session/data/models/complete_reason_item.dart';

enum BuyerCompleteConfirmEnum {
  didntWaitInLine,
  dontWantToBeChecked,
  carPledged,
  notSuitableForPurchase,
  other,
}

extension BuyerCompleteConfirmEnumExt on BuyerCompleteConfirmEnum {
  String get title {
    switch (this) {
      case BuyerCompleteConfirmEnum.didntWaitInLine:
        return 'Не дождались очереди';
      case BuyerCompleteConfirmEnum.dontWantToBeChecked:
        return 'Не хотят проходить проверку';
      case BuyerCompleteConfirmEnum.carPledged:
        return 'Авто в залоге';
      case BuyerCompleteConfirmEnum.notSuitableForPurchase:
        return 'Авто не подходит для выкупа';
      case BuyerCompleteConfirmEnum.other:
        return 'Другое';
    }
  }
}

List<CompleteReasonItem> getBuyerConfirmReasons() {
  return BuyerCompleteConfirmEnum.values
      .map((e) => CompleteReasonItem(title: e.title))
      .toList();
}
