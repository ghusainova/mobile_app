import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../components/widgets/page_form_widget.dart';
import '../../../../../../components/UI/radio_button_tile/radio_button_tile_widget.dart';
import '../../../data/models/complete_type_item.dart';

class CompletingTypeSelectionPage extends StatefulWidget {
  final List<CompleteTypeItem> completingTypes;

  const CompletingTypeSelectionPage(this.completingTypes, {super.key});

  @override
  State<CompletingTypeSelectionPage> createState() =>
      _CompletingTypeSelectionPageState();
}

class _CompletingTypeSelectionPageState
    extends State<CompletingTypeSelectionPage> {
  final title = 'Выберите тип завершения работы';
  late List<CompleteTypeItem> completingTypes;

  @override
  void initState() {
    super.initState();
    completingTypes = widget.completingTypes;
  }

  @override
  Widget build(BuildContext context) {
    return PageFormWidget(
      appBarTitle: 'Завершение работы',
      pageTitle: title,
      children: [
        ...completingTypes.map(
          (e) => RadioButtonTileWidget(
            title: e.title,
            subtitle: e.subtitle,
            enabled: e.isSelected,
            onTap: () => onSelect(e),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: BlueButton(onPressed: navigateToComplete),
          ),
        ),
      ],
    );
  }

  void onSelect(CompleteTypeItem selectedItem) {
    completingTypes = completingTypes
        .map((e) => CompleteTypeItem.onSelect(e, selectedItem))
        .toList();
    setState(() => completingTypes);
  }

  void navigateToComplete() {
    final selectedItem =
        completingTypes.firstWhereOrNull((element) => element.isSelected);

    if (selectedItem?.routeNav != null) {
      selectedItem!.routeNav!();
    } else {
      showSnackBar(context, title);
    }
  }
}
