import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../components/styles/app_colors.dart';
import '../../../../../../shared/_data/models/auto_info.dart';

class ApplicationCardTitleWidget extends StatelessWidget {
  final AutoInfo order;

  const ApplicationCardTitleWidget(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: launchBrowser,
      child: Row(
        children: [
          Text(
            '${order.auto?.brand ?? ''} ${order.auto?.model ?? ''}, ${order.auto?.year ?? ''}'
                .trim(),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.primaryBlue,
                  decoration: TextDecoration.underline,
                ),
          ),
          if (order.linkSell.isNotEmpty)
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(Icons.link, color: AppColors.primaryBlue),
            ),
        ],
      ),
    );
  }

  void launchBrowser() {
    if (order.linkSell.isNotEmpty) {
      launchUrl(
        Uri.parse(order.linkSell),
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
