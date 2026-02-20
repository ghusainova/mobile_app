import 'package:flutter/material.dart';

import '../../../../../../components/UI/checkbox_list/checkbox_list.dart';

class MultiChoiceModel extends StatelessWidget {
  final List<String> models;
  final List<String>? selectedModels;
  final void Function(List<String> selectedModels) onSelect;

  const MultiChoiceModel({
    required this.models,
    required this.selectedModels,
    required this.onSelect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxList(
      values: models,
      selectedValues: selectedModels ?? [],
      isScrollable: true,
      onSelect: onSelect,
    );
  }
}
