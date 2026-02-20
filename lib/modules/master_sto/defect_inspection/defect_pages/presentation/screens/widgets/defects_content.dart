import 'package:flutter/material.dart';

import '../../../../_shared/data/enum/car_body_part.dart';
import 'defect_buttons.dart';
import 'defect_list_form/defect_list_form.dart';
import 'defect_top_form/defect_top_form.dart';
import 'recolour.dart';

class DefectContent extends StatelessWidget {
  final CarBodyPart bodyPart;

  const DefectContent({
    required this.bodyPart,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        DefectTopForm(bodyType: bodyPart.genitiveLabel),
        bodyPart.imageWidget,
        if (bodyPart.recolourIsNeed) const Recolour(),
        DefectListFormWidget(bodyPart: bodyPart),
        DefectButtons(bodyPart: bodyPart),
      ],
    );
  }
}
