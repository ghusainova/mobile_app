import 'package:flutter/material.dart';

import '../../../../../../components/router/data/routes.dart';
import '../../../../../../components/styles/app_colors.dart';
import '../../../../../../components/widgets/cached_image_widget.dart';

class CarToTransferCardWidget extends StatelessWidget {
  const CarToTransferCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => const DataForDocPrintingRoute().push(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: CachedImageWidget(
                '',
                width: MediaQuery.of(context).size.width / 3.95,
                height: MediaQuery.of(context).size.height / 10.8,
                borderRadius: 8,
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hyundai Solaris, 2014',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: RichText(
                      text: TextSpan(
                        text: 'VIN-код: Z94CT41DBFR346801',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: AppColors.inactiveText),
                        children: const [
                          TextSpan(text: '\nНомер кузова: Z94CT41DBFR346801'),
                        ],
                      ),
                    ),
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
