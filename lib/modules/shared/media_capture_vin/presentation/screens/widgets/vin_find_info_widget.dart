import 'package:flutter/material.dart';

import '../../../data/constants/media_capture_constants.dart';
import '../../../../../../components/styles/app_assets.dart';
import '../../../../../../components/widgets/buttons/outlined_blue_button.dart';

class VinFindInfoWidget extends StatelessWidget {
  const VinFindInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedBlueButton(
      text: 'Где найти VIN-код на кузове авто?',
      slim: true,
      showBorder: false,
      mainAxisAlignment: MainAxisAlignment.start,
      padding: EdgeInsets.zero,
      onPressed: () => _showModal(context),
    );
  }

  void _showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      isScrollControlled: true,
      builder: (context) => const _VinInfoModal(),
    );
  }
}

class _VinInfoModal extends StatelessWidget {
  const _VinInfoModal();

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Где найти VIN-код?',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Image.asset(AppAssets.carParts),
            ),
            ...vinInfoItems.asMap().entries.map(
                  (e) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${e.key + 1}. ${e.value.keys.first}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 16, top: 8, bottom: 16),
                        child: Text(
                          e.value.values.first,
                          style: Theme.of(context).textTheme.bodyLarge,
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
