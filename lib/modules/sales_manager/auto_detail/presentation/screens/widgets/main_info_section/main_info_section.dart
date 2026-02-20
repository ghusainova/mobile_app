import 'package:flutter/material.dart';

import '../../../../../../../components/widgets/card_widget/card_border_type_enum.dart';
import '../../../../../../../components/widgets/card_widget/card_widget.dart';
import 'image_section/image_section.dart';
import 'info_section/info_section_content.dart';

class MainInfoSection extends StatelessWidget {
  const MainInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const CardWidget(
      margin: EdgeInsets.only(bottom: 12),
      boxPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      borderRadius: CardBorderTypeEnum.onlyBottom,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageSection(),
          InfoSectionContent(),
        ],
      ),
    );
  }
}
