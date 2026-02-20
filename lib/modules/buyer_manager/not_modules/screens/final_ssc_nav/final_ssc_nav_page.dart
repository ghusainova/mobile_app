import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../components/widgets/page_form_widget.dart';
import '../../../../../components/widgets/timeline/timeline_tile_widget.dart';
import '../../../../shared/_data/models/timeline_tile_item.dart';
import 'widgets/docs_print_btn_widget.dart';
import 'widgets/owners_reg_manual_widget.dart';

class FinalSscNavPage extends StatelessWidget {
  const FinalSscNavPage({super.key});

  static const List<TimelineTileItem> todoItems = [
    TimelineTileItem(
      title: 'Возьмите ключи авто у владельца',
    ),
    TimelineTileItem(
      title: 'Распечатайте приказ и доверенность для СпецЦОНа',
      child: DocsPrintBtnWidget(
        base64String: '',
      ),
    ),
    TimelineTileItem(
      title: 'Отправьте владельца авто в СпецЦОН для снятия с учета',
      child: OwnersRegManualWidget(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PageFormWidget(
      appBarTitle: 'Отправьте владельца авто в СпецЦОН',
      useParentTitle: true,
      children: [
        ...todoItems.asMap().entries.map(
              (e) => TimelineTileWidget(
                item: e.value.copyWith(
                  key: e.key + 1,
                  isLast: e.value == todoItems.last,
                ),
              ),
            ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: BlueButton(
              text: 'Завершить работу',
              onPressed: () => context.pop(),
            ),
          ),
        ),
      ],
    );
  }
}
