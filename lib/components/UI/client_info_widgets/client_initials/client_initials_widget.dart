import 'package:flutter/material.dart';

import '../../../../modules/shared/_data/helpers/launch_urls.dart';
import '../../../../modules/shared/queue/data/models/active_client_dto.dart';
import '../../../styles/app_colors.dart';
import '../../../../modules/shared/_domain/utility/formatters/phone_number_formatter.dart';
import 'client_image_widget.dart';

class ClientInitialsWidget extends StatelessWidget {
  final ActiveClientDTO activeClient;
  final bool showPhoneNumber;

  const ClientInitialsWidget(
    this.activeClient, {
    super.key,
    this.showPhoneNumber = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          ClientImageWidget(activeClient.iin),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${activeClient.firstname ?? ''} ${activeClient.patronymic ?? ''}'
                      .trim(),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                if ((activeClient.iin ?? '').isNotEmpty)
                  GestureDetector(
                    onTap: () => copyIinToClipboard(activeClient.iin!),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'ИИН: ${activeClient.iin}',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: AppColors.inactiveText),
                      ),
                    ),
                  ),
                if (showPhoneNumber && (activeClient.phone ?? '').isNotEmpty)
                  GestureDetector(
                    onTap: () => callToClient(activeClient.phone!),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        formatPhoneNumber(activeClient.phone!),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: AppColors.inactiveText),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
