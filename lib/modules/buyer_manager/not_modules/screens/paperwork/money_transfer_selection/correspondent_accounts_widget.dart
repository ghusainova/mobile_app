import 'package:flutter/material.dart';

import '../../../../../../components/UI/radio_button_tile/radio_button_tile_widget.dart';
import '../../../../../../components/widgets/card_widget/card_border_type_enum.dart';
import '../../../../../../components/widgets/card_widget/card_widget.dart';

class CorrespondentAccountsWidget extends StatefulWidget {
  final void Function(int index) onSelect;

  const CorrespondentAccountsWidget({
    required this.onSelect,
    super.key,
  });

  @override
  State<CorrespondentAccountsWidget> createState() =>
      _CorrespondentAccountsWidgetState();
}

class _CorrespondentAccountsWidgetState
    extends State<CorrespondentAccountsWidget> {
  final List<String> correspondentAccounts = [
    'На Kaspi Gold Олжас К.',
    'На счет другого банка',
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      title: 'Выберите счет для зачисления денег и распечатайте документы',
      borderRadius: CardBorderTypeEnum.onlyBottom,
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          ...correspondentAccounts.asMap().entries.map(
                (e) => RadioButtonTileWidget(
                  title: e.value,
                  enabled: e.key == selectedIndex,
                  onTap: () {
                    setState(() => selectedIndex = e.key);
                    widget.onSelect(e.key);
                  },
                ),
              ),
        ],
      ),
    );
  }
}
