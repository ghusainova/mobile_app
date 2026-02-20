import 'package:flutter/material.dart';

import '../../../../../../components/styles/app_colors.dart';
import '../../../../../../components/widgets/cached_image_widget.dart';
import '../../../../../../components/widgets/status_widget.dart';
import '../../../../../shared/_data/enums/status_type_enum.dart';
import '../../../../credit_application/data/models/credit_application.dart';

class CreditApplicationItemWidget extends StatelessWidget {
  final CreditApplication item;
  const CreditApplicationItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CachedImageWidget(
              item.advert?.urlAdvert,
              width: 40,
              height: 40,
              borderRadius: 100,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${item.client.firstName} ${item.client.lastName}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  item.client.phoneNumber,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AppColors.inactiveText),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  'ИИН: ${item.client.iin}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AppColors.inactiveText),
                ),
              ),
              Text(
                '${item.auto.brand} ${item.auto.model}, ${item.auto.year}',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.inactiveText),
              ),
              if (item.status.isNotEmpty)
                StatusWidget(
                  status: StatusTypeEnum.info,
                  subtitle: item.status.first.name,
                  margin: const EdgeInsets.only(top: 8),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
