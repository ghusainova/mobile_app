import 'package:flutter/material.dart';

import '../../../../data/models/phase.dart';
import 'final_nav_btns.dart';
import 'history_nav_btns.dart';

class HistoryNavBtnsWidget extends StatelessWidget {
  final bool isFinalStage;
  final void Function(Phase? phase) onTap;

  const HistoryNavBtnsWidget(
    this.onTap, {
    required this.isFinalStage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (isFinalStage) {
      return const FinalNavBtns();
    }

    return HistoryNavBtns(onTap: onTap);
  }
}
