import 'package:flutter/material.dart';

import '../../../../data/models/inspection_item/inspection_item.dart';
import '../../../../data/models/inspection_item/inspection_value/inspection_subvalue.dart';
import '../../../../data/models/inspection_item/inspection_value/inspection_value.dart';
import '../../main_form/widgets/compression_input_widget/compression_input_widget.dart';
import '../../main_form/widgets/show_photo_selection_widget.dart';
import 'equipment_subvalues_widget.dart';
import '../../main_form/widgets/paint_thickness_input_widget.dart';
import 'values_selection_widget.dart';

class EquipmentCheckboxWidget extends StatefulWidget {
  final String? title;
  final String? documentType;
  final InspectionItem item;
  final void Function(InspectionItem item) onChanged;

  const EquipmentCheckboxWidget({
    required this.item, required this.onChanged, super.key,
    this.title,
    this.documentType,
  });

  @override
  State<EquipmentCheckboxWidget> createState() =>
      _EquipmentCheckboxWidgetState();
}

class _EquipmentCheckboxWidgetState extends State<EquipmentCheckboxWidget> {
  late InspectionItem item;

  @override
  void initState() {
    super.initState();
    item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    if (item.isCompressionCheck) {
      return CompressionInputWidget(
        item: item,
        onChange: onSelectItems,
      );
    }

    return Column(
      children: [
        ...item.sortedValues.map(
          (e) => Column(
            children: [
              ValuesSelectionWidget(
                value: e,
                isMultiSelect: item.multiSelect,
                onSelect: () => onSelectItems(e),
              ),
              EquipmentSubValuesWidget(
                value: e,
                isItemSelected: e.selected,
                onChange: (updatedSubValues) => onSelectSubValues(
                  value: e,
                  updatedSubValues: updatedSubValues,
                ),
              ),
            ],
          ),
        ),
        PaintThicknessInputWidget(
          value: item.paintThicknessValue,
          onChange: onSelectItems,
        ),
        ShowPhotoSelectionWidget(item: item, documentType: widget.documentType),
      ],
    );
  }

  void onSelectItems(InspectionValue value) {
    mapItemsSelection(value);
    widget.onChanged(item);
  }

  void onSelectSubValues({
    required InspectionValue value,
    required List<InspectionSubvalue> updatedSubValues,
  }) {
    item = InspectionItem.updateSubValues(
      item: item,
      value: value,
      updatedSubValues: updatedSubValues,
    );

    widget.onChanged(item);
  }

  void mapItemsSelection(InspectionValue value) {
    final uncheckOthersRule = !value.isPaintwork &&
        (!item.multiSelect ||
            value.uncheckOthers ||
            item.values
                .any((element) => element.uncheckOthers && element.selected));

    if (uncheckOthersRule) {
      clearSelections();
    }

    selectItem(value);
  }

  void clearSelections() {
    item = InspectionItem.uncheckAllValues(item);
  }

  void selectItem(InspectionValue value) {
    item = InspectionItem.updateValuesSelection(item: item, value: value);
  }
}
