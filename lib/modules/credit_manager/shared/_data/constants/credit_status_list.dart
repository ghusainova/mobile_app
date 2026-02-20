import 'package:collection/collection.dart';

import '../../../application_status/data/models/credit_status_item.dart';
import '../enum/credit_rework_enum.dart';
import 'credit_status.dart';

//TODO: REFACTOR!!!
class CreditStatusList {
  final List<CreditStatusItem> completedStatuses;
  const CreditStatusList(this.completedStatuses);

  List<CreditStatusItem> get mappedItems => _getStagedStatusList();

  CreditStatusItem? get _reworkItem => completedStatuses.firstWhereOrNull(
        (e) => e.statusCode == CreditStatus.verificationRework,
      );

  List<String> get _reworkCodes =>
      completedStatuses
          .firstWhereOrNull((e) => e.reworkCodes.isNotEmpty)
          ?.reworkCodes ??
      [];

  List<CreditStatusItem> _mapStatusCompleteness() {
    final mappedList = CreditStatus.itemList
        .map((e) {
          final matchedItem = completedStatuses
              .firstWhereOrNull((c) => c.statusCode == e.statusCode);

          if (e.statusCode == CreditStatus.verificationRework &&
              _reworkItem == null) {
            return null;
          } else if (matchedItem != null) {
            return e.copyWith(isDone: matchedItem.isDone);
          }

          return e;
        })
        .where((e) => e != null)
        .toList();
    final output = mappedList.map((e) => e!).toList();

    return output;
  }

  List<CreditStatusItem> _getStagedStatusList() {
    final mappedItems = _mapStatusCompleteness();
    final reworkItems = _getReworkItems();
    final stageItem =
        mappedItems.firstWhereOrNull((e) => e.isStageItem == true);
    int stageIndex = 0;
    List<CreditStatusItem> output = [];

    if (stageItem == null) {
      return mappedItems;
    } else {
      stageIndex = mappedItems.indexOf(stageItem);
    }

    if (!stageIndex.isNegative && stageItem.isDone) {
      output = mappedItems.sublist(stageIndex);
    } else {
      output = mappedItems.sublist(0, stageIndex + 1);
    }

    if (reworkItems.isNotEmpty) {
      output.insertAll(
        output.lastIndexWhere((e) => e.isDone) + 1,
        reworkItems,
      );
    }

    return output;
  }

  List<CreditStatusItem> _getReworkItems() {
    if (_reworkItem?.isDone == true) {
      return [];
    }

    const reworkValues = CreditReworkEnum.values;
    final passportReworkValues = reworkValues.where(
      (e) =>
          e.type == creditReworkTechPassType && _reworkCodes.contains(e.code),
    );
    final recycleReworkValues = reworkValues.where(
      (e) => e.type == creditReworkRecycleType && _reworkCodes.contains(e.code),
    );
    List<CreditStatusItem> output = [];

    if (passportReworkValues.isNotEmpty) {
      output.add(
        CreditStatusItem(
          name: passportReworkValues.first.name,
          finalName: passportReworkValues.first.finalName,
          comment: passportReworkValues.map((e) => e.description).join('\n'),
          statusCode: passportReworkValues.first.type,
          isRework: true,
        ),
      );
    }

    if (recycleReworkValues.isNotEmpty) {
      final values = recycleReworkValues.map(
        (e) => CreditStatusItem(
          name: e.name,
          finalName: e.finalName,
          comment: e.description,
          statusCode: e.type,
          isRework: true,
        ),
      );
      output.addAll(values);
    }

    return output;
  }
}
