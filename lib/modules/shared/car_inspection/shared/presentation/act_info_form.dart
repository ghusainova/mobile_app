import 'package:flutter/material.dart';

import '../../../../../components/styles/app_colors.dart';
import '../../../../sales_manager/auto_detail/data/enums/photo_type_enum.dart';
import '../../other_parts/presentation/screens/widgets/photo_row.dart';
import '../data/models/act_detail.dart';
import 'act_info_form_item.dart';

class ActInfoForm extends StatelessWidget {
  final String? orderId;
  final Map<String, List<ActDetail>> actDetailInfo;

  const ActInfoForm({
    required this.actDetailInfo,
    this.orderId,
    super.key,
  });

  Border get _divider =>
      const Border(bottom: BorderSide(color: AppColors.backBase));

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: actDetailInfo.entries
            .map(
              (entry) => ExpansionTile(
                initiallyExpanded: true,
                tilePadding: EdgeInsets.zero,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                iconColor: AppColors.borderDark,
                collapsedIconColor: AppColors.borderDark,
                title: Text(
                  entry.key,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                shape: _divider,
                collapsedShape: _divider,
                children: entry.value.map(
                  (item) {
                    bool isComputerDiagnostics =
                        item.equipment == PhotoTypeEnum.diagnostics.label;
                    bool showPhotos = isComputerDiagnostics ||
                        (item.isDefect &&
                            PhotoTypeEnum.values.any(
                              (element) => element.label == item.equipment,
                            ));
                    return Column(
                      children: [
                        ActInfoFormItem(item: item),
                        if (showPhotos)
                          PhotoRow(
                            type: item.equipment,
                            orderId: orderId,
                          ),
                      ],
                    );
                  },
                ).toList(),
              ),
            )
            .toList(),
      ),
    );
  }
}
