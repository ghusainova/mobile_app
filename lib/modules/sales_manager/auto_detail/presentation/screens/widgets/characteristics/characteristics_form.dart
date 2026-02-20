import 'package:flutter/material.dart';

import '../../../../../../../components/widgets/card_widget/card_widget.dart';
import 'characteristics_item_list.dart';

class CharactericticsForm extends StatelessWidget {
  const CharactericticsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const CardWidget(
      margin: EdgeInsets.only(bottom: 12),
      title: 'Характеристики',
      child: CharacteristicItemList(),
    );
  }
}
