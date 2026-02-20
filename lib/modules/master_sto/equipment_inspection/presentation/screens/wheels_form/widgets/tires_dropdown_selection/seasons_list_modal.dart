import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../../components/UI/radio_button_tile/radio_button_tile_widget.dart';
import '../../../../../../../../components/UI/modal_appbar.dart';

class SeasonsListModal extends StatelessWidget {
  final List<String> seasonsList;
  final String selectedSeason;

  const SeasonsListModal({
    required this.seasonsList,
    required this.selectedSeason,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ModalAppBar(text: 'Сезонность'),
          ListView.builder(
            shrinkWrap: true,
            itemCount: seasonsList.length,
            itemBuilder: (context, index) => RadioButtonTileWidget(
              title: seasonsList[index],
              enabled: seasonsList[index] == selectedSeason,
              prefixBox: true,
              onTap: () => context.pop(seasonsList[index]),
            ),
          ),
        ],
      ),
    );
  }
}
