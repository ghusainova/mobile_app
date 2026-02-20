import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../components/router/data/routes.dart';
import '../../../../../../components/widgets/main_info_title.dart';

import '../../../../../shared/queue/domain/bloc/queue_bloc.dart';
import '../../../../../shared/_data/models/auto_info.dart';
import 'item_card_description_widget.dart';
import 'item_card_price_widget.dart';
import 'item_image_widget.dart';
import 'item_select_to_view_widget.dart';

class CatalogItemCard extends StatelessWidget {
  final AutoInfo autoInfo;
  final bool showSelectBtn;
  final bool fromApprovedCredit;

  const CatalogItemCard({
    required this.autoInfo,
    super.key,
    this.showSelectBtn = true,
    this.fromApprovedCredit = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AutoDetailRoute(
        AutoDetailRouteArgs(
          autoInfo: autoInfo,
          fromApprovedCredit: fromApprovedCredit,
        ),
      ).push(context),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ItemImageWidget(
              imageUrl: autoInfo.auto?.mainPhotoLink,
              parking: autoInfo.parking,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainInfoTitleWidget(
                    autoInfo: autoInfo,
                    textSize: 14,
                  ),
                  ItemCardPriceWidget(autoInfo),
                  ItemCardDescriptionWidget(autoInfo),
                  if (showSelectBtn)
                    BlocBuilder<QueueBloc, QueueState>(
                      builder: (context, state) {
                        if (context.read<QueueBloc>().activeClient != null) {
                          return SizedBox(
                            width: 158,
                            child: SelectToViewWidget(autoInfo),
                          );
                        }

                        return const SizedBox();
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
