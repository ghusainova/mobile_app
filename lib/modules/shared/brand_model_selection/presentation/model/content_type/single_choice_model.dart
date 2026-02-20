import 'package:flutter/material.dart';

import '../../../../../../components/UI/radio_button_tile/radio_button_tile_widget.dart';

class SingleChoiceModel extends StatelessWidget {
  final EdgeInsets? padding;
  final List<String> models;
  final String? selectedModel;
  final void Function(String? selectedModel) onSelect;

  const SingleChoiceModel({
    required this.models,
    required this.selectedModel,
    required this.onSelect,
    super.key,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: models.length,
      padding: padding,
      itemBuilder: (context, index) => RadioButtonTileWidget(
        title: models[index],
        enabled: selectedModel == models[index],
        onTap: () => onSelect(models[index]),
      ),
    );
  }
}
