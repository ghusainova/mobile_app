import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../../../components/styles/app_colors.dart';
import '../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../../components/widgets/timeline/check_key_widget.dart';
import '../../../../../components/widgets/timeline/timeline_tile_widget.dart';
import '../../../../shared/_data/models/timeline_tile_item.dart';
import '../../../shared/_data/constants/credit_status.dart';
import '../../../shared/_data/constants/credit_status_action.dart';
import '../../../shared/_data/constants/credit_status_list.dart';
import '../../data/models/credit_status_item.dart';
import 'timeline_button.dart';

class NextStepsContent extends StatelessWidget {
  final List<CreditStatusItem> completedStatuses;

  const NextStepsContent(this.completedStatuses, {super.key});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      title: 'Дальнейшие шаги',
      margin: const EdgeInsets.only(bottom: 16),
      contentPadding: const EdgeInsets.all(16).copyWith(bottom: 0),
      child: Column(children: _getCreditTimeline()),
    );
  }

  List<Widget> _getCreditTimeline() {
    final mappedStatuses = CreditStatusList(completedStatuses).mappedItems;

    return mappedStatuses
        .map(
          (statusItem) => TimelineTileWidget(
            item: _mapCreditStatusItem(statusItem, mappedStatuses),
            subItem: _mapCreditStatusSubItem(statusItem),
          ),
        )
        .toList();
  }

  TimelineTileItem _mapCreditStatusItem(
    CreditStatusItem statusItem,
    List<CreditStatusItem> mappedStatuses,
  ) {
    final title = statusItem.isDone && statusItem.finalName != null
        ? statusItem.finalName!
        : statusItem.name;
    final prevStatusIndex = mappedStatuses.indexOf(statusItem) - 1;
    String comment = '';

    if (!prevStatusIndex.isNegative &&
        mappedStatuses[prevStatusIndex].isDone &&
        !statusItem.isRework) {
      comment = statusItem.comment;
    }

    return TimelineTileItem(
      title: title,
      subtitle: comment,
      isLast: mappedStatuses.last == statusItem,
      lineInProgressColor: AppColors.success,
      isSelected: statusItem.isDone,
      customKeyWidget: CheckKeyWidget(statusItem.isDone),
      child: _getTimeLineButton(statusItem),
    );
  }

  TimelineTileItem? _mapCreditStatusSubItem(CreditStatusItem statusItem) {
    final alternative = completedStatuses.firstWhereOrNull(
      (e) => e.statusCode == CreditStatus.scoringAlternative,
    );

    if (statusItem.isRework) {
      return TimelineTileItem(
        subtitle: statusItem.comment,
      );
    }

    if (statusItem.statusCode == CreditStatus.verificationProcess &&
        statusItem.isDone &&
        alternative != null) {
      return TimelineTileItem(
        title: CreditStatus.alternativeItem.name,
        subtitle: CreditStatus.alternativeItem.comment,
      );
    }

    return null;
  }

  Widget? _getTimeLineButton(CreditStatusItem item) {
    final upcomingStatuses =
        CreditStatusList(completedStatuses).mappedItems.where((e) => !e.isDone);

    if (upcomingStatuses.isEmpty) {
      return null;
    }

    if (!item.isDone && upcomingStatuses.first.statusCode == item.statusCode) {
      final action = CreditStatusAction(item.statusCode);

      return TimelineButton(
        title: action.btnTitle,
        onRouteNav: action.btnRoute,
      );
    }

    return null;
  }
}
