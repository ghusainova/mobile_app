import 'package:flutter/material.dart';

import '../../../../../../../components/router/data/routes.dart';
import '../../../../../../../components/styles/app_assets.dart';
import '../../../../../../../components/styles/app_colors.dart';
import '../../../../../../../components/widgets/buttons/icon_button_widget.dart';

class SalesContractItemWidget extends StatelessWidget {
  final String documentBase64;
  final VoidCallback onDelete;

  const SalesContractItemWidget({
    required this.documentBase64,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => PdfPreviewRoute(documentBase64).push(context),
      child: Row(
        children: [
          const Image(image: AssetImage(AppAssets.document)),
          const SizedBox(width: 16),
          Text(
            'Договор купли-продажи',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButtonWidget(
                icon: const Icon(Icons.delete, color: AppColors.inactiveText),
                onTap: onDelete,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
