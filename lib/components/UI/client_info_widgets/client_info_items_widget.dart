import 'package:flutter/material.dart';
import '../../../modules/sales_manager/client_processing/data/models/info_widget_item.dart';
import '../../styles/app_colors.dart';

class ClientInfoItemWidget extends StatelessWidget {
  final InfoWidgetItem item;

  const ClientInfoItemWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          item.title,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: AppColors.inactiveText),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            item.subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
