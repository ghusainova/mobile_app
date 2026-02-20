import 'package:flutter/material.dart';

import '../../../data/models/complete_reason_item.dart';
import '../../../../../../components/UI/radio_button_tile/radio_button_tile_widget.dart';

class ReasonsTileListWidget extends StatefulWidget {
  final List<CompleteReasonItem> completingReason;
  final void Function(String text) onReasonChanged;
  final void Function(String text) onCommentChanged;

  const ReasonsTileListWidget({
    required this.completingReason,
    required this.onReasonChanged,
    required this.onCommentChanged,
    super.key,
  });

  @override
  State<ReasonsTileListWidget> createState() => _ReasonsTileListWidgetState();
}

class _ReasonsTileListWidgetState extends State<ReasonsTileListWidget> {
  List<CompleteReasonItem> reasonItemsList = [];

  @override
  void initState() {
    super.initState();
    reasonItemsList = widget.completingReason;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Column(
        children: reasonItemsList
            .map(
              (e) => RadioButtonTileWidget(
                title: e.title,
                enabled: e.isSelected,
                isLastItem: reasonItemsList.last.title.contains(e.title),
                onTap: () => onTap(e),
                onCommentChanged: widget.onCommentChanged,
                onValidate: onValidate,
              ),
            )
            .toList(),
      ),
    );
  }

  void onTap(CompleteReasonItem item) {
    widget.onReasonChanged(item.title);

    reasonItemsList = reasonItemsList
        .map(
          (e) => e == item
              ? item.copyWith(isSelected: true)
              : e.copyWith(isSelected: false),
        )
        .toList();

    setState(() => reasonItemsList);
  }

  String? onValidate(String? text) {
    if ((text ?? '').trim().length < 15) {
      return 'Опишите подробнее причину завершения';
    }

    return null;
  }
}
