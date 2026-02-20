import 'dart:ui';

import '../../../../../components/router/app_router.dart';
import '../../../../../components/router/data/routes.dart';
import '../../../../shared/complete_client_session/data/models/complete_reason_item.dart';

enum BuyerCompleteRefusedEnum {
  thinkForDecision,
  refusedToSell,
  carPledged,
  other,
}

extension BuyerCompleteRefusedEnumExt on BuyerCompleteRefusedEnum {
  String get title {
    switch (this) {
      case BuyerCompleteRefusedEnum.thinkForDecision:
        return 'Ушли подумать над решением';
      case BuyerCompleteRefusedEnum.refusedToSell:
        return 'Отказались от продажи авто';
      case BuyerCompleteRefusedEnum.carPledged:
        return 'Авто в залоге';
      case BuyerCompleteRefusedEnum.other:
        return 'Другое';
    }
  }

  VoidCallback? get routeNav {
    final context = rootNavigatorKey.currentContext;

    if (context == null) {
      return null;
    }

    switch (this) {
      case BuyerCompleteRefusedEnum.thinkForDecision:
      case BuyerCompleteRefusedEnum.carPledged:
      case BuyerCompleteRefusedEnum.other:
        return () {};

      case BuyerCompleteRefusedEnum.refusedToSell:
        return () => const SellCarSumReasonRoute().push(context);
    }
  }
}

List<CompleteReasonItem> getBuyerRefusedReasons() {
  return BuyerCompleteRefusedEnum.values
      .map((e) => CompleteReasonItem(title: e.title, routeNav: e.routeNav))
      .toList();
}
