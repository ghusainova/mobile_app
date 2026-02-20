import '../../../../shared/complete_client_session/data/models/complete_reason_item.dart';

enum CreditCompletingReasonsEnum {
  changedDecision,
  want3rdPartyRegister,
  badCreditConditions,
  other,
}

extension CreditCompletingReasonsEnumExt on CreditCompletingReasonsEnum {
  String get title {
    switch (this) {
      case CreditCompletingReasonsEnum.changedDecision:
        return 'Передумали';
      case CreditCompletingReasonsEnum.want3rdPartyRegister:
        return 'Хотят оформить на 3-е лицо';
      case CreditCompletingReasonsEnum.badCreditConditions:
        return 'Не устроили условия Автокредита';
      case CreditCompletingReasonsEnum.other:
        return 'Другое';
    }
  }
}

List<CompleteReasonItem> getCreditCompletingReasons() {
  return CreditCompletingReasonsEnum.values
      .map((e) => CompleteReasonItem(title: e.title))
      .toList();
}
